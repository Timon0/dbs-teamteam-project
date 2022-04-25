import plotly.graph_objects as go
import pandas as pd
import util.helper as helper


def get_figure(region='RME', month=1):
    query = f'''
    SELECT *, avg(rainfall) OVER(ORDER BY date
         ROWS BETWEEN 2 PRECEDING AND current row)
         AS moving_average FROM weatherdailydelay 
         WHERE 
            sbbregion_isocode = '{region}' AND MONTH(date)={month}
    '''

    result = pd.read_sql(sql=query, con=helper.get_sql_connection())
    result_df = pd.DataFrame(result)
    result_df.zugpuenktlichkeit = 100 - result_df.zugpuenktlichkeit

    datatrace1 = {
        'name': 'Rainfall',
        'type': 'bar',
        'x': result_df['date'],
        'y': result_df['rainfall']
    }

    datatrace2 = {
        'name': 'Avg. Rainfall (past 3 days)',
        'type': 'scatter',
        'x': result_df['date'],
        'y': result_df['moving_average']
    }

    datatrace3 = {
        'name': 'Traindelay in %',
        'type': 'scatter',
        'x': result_df['date'],
        'y': result_df['zugpuenktlichkeit']
    }

    datatrace4 = {
        'name': 'Temperature',
        'type': 'scatter',
        'x': result_df['date'],
        'y': result_df['temp']
    }

    figdict = {'data': [datatrace1, datatrace2, datatrace3, datatrace4]}

    return go.Figure(**figdict)
