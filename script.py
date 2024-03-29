import pandas as pd
import numpy as np
from scipy.optimize import minimize


df = pd.read_excel('Seasonality.xlsx')
# drops the extra title row
df.drop(df.index[0], axis=0, inplace=True)
# resets the index to start at 0. Could probably just make the datetime the index if you wanted.
df.reset_index(inplace=True, drop=True)

# supply an initial value to alpha
alpha = 0.3

# pulls the actual values into a numpy array
array_of_actual_values = df.Seasonally.values


def full_algorithim(alpha, init_data):
    # values predicted using the single-equation recursive form of Brown’s model
    y = np.empty(len(init_data), float)
    # error values (actual - predicted)
    z = np.empty(len(init_data), float)

    for i in range(0, len(init_data)):
        # sets the first two values in predicted to be the first value in actual
        if i < 2:
            y[i] = init_data[0]
        else:
            y[i] = 2 * init_data[i - 1] - init_data[i - 2] - 2 * (1 - alpha) * z[i - 1] + ((1 - alpha) ** 2) * z[i - 2]

        z[i] = init_data[i] - y[i]

    return np.sqrt(np.mean(np.square(z)))


result = minimize(full_algorithim, alpha, array_of_actual_values, bounds=[(0, 1)])

# there's a tiny amount of variation in the optimal value based on the initial value for alpha
[alpha_optimized] = result.x
print(alpha_optimized)


def algebraic_transformation(df_original, column_name_actual, column_name_predicted, column_name_errors, alpha_opt):
    df_new = df_original

    for i in range(0, len(df_new)):
        if i < 2:
            # sets the first two values in Forecast to be the first value in Seasonally
            df_new.loc[i, column_name_predicted] = df_new.loc[0, column_name_actual]
        else:
            df_new.loc[i, column_name_predicted] = \
                2 * df_new.loc[i - 1, column_name_actual] - df_new.loc[i - 2, column_name_actual] - 2 * (1 - alpha_opt) * df_new.loc[i - 1, column_name_errors] + ((1 - alpha_opt) ** 2 * df_new.loc[i - 2, column_name_errors])

        # calculates the error, y_actual - y_predicted
        df_new.loc[i, column_name_errors] = df_new.loc[i, column_name_actual] - df_new.loc[i, column_name_predicted]

    return df_new


df_changed = algebraic_transformation(df, 'Seasonally', 'Forecast', 'Error', alpha_optimized)

RMSE = np.sqrt(np.mean(np.square(df_changed.Error)))
print(RMSE)

# removes time from date column
df_changed.Date = pd.to_datetime(df.Date).dt.date

with pd.ExcelWriter('Seasonality-with-Forecast-Errors.xlsx', engine='openpyxl', mode='w') as writer:
    df_changed.to_excel(writer, index=False)

