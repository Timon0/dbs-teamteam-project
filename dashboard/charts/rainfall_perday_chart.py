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
        'name': 'Regenfall',
        'type': 'bar',
        'x': result_df['date'],
        'y': result_df['rainfall']
    }

    datatrace2 = {
        'name': 'Zugverspätungen in %',
        'type': 'scatter',
        'line_color': '#f08576',
        'x': result_df['date'],
        'y': result_df['zugpuenktlichkeit']
    }

    datatrace3 = {
        'name': 'Durch. Niederschlag (letzten 3 Tage)',
        'type': 'scatter',
        'x': result_df['date'],
        'y': result_df['moving_average'],
        'visible': 'legendonly'
    }

    datatrace4 = {
        'name': 'Temparatur',
        'type': 'scatter',
        'x': result_df['date'],
        'y': result_df['temp'],
        'visible': 'legendonly'
    }


    layout = {
        'xaxis_tickformat': '%e.%m.%y',
    }

    figdict = {'data': [datatrace1, datatrace2, datatrace3, datatrace4], 'layout': layout}

    return go.Figure(**figdict)
