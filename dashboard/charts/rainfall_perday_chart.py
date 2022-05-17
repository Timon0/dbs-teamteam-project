import plotly.graph_objects as go
import pandas as pd
import util.helper as helper


def get_figure(region='RME', month=1):
    query = '''
    SELECT * FROM weatherdailydelay 
         WHERE 
            sbbregion_isocode =%s AND MONTH(date)=%s
    '''

    result = pd.read_sql(sql=query, con=helper.get_sql_connection(), params=[region, month])
    result_df = pd.DataFrame(result)
    result_df.zugpuenktlichkeit = 100 - result_df.zugpuenktlichkeit

    rainfall_trace = {
        'name': 'Regenfall',
        'type': 'bar',
        'x': result_df['date'],
        'y': result_df['rainfall']
    }

    delay_trace = {
        'name': 'Zugverspätungen in %',
        'type': 'scatter',
        'line_color': '#f08576',
        'x': result_df['date'],
        'y': result_df['zugpuenktlichkeit']
    }

    snowfall_trace = {
        'name': 'Schnefall',
        'type': 'bar',
        'x': result_df['date'],
        'y': result_df['snowfall'],
        'marker': {
            'color': '#2aeef5'
        }
    }

    layout = {
        'barmode': 'stack',
        'xaxis_tickformat': '%e.%m.%y',
        'legend_traceorder': 'normal'
    }

    figdict = {'data': [rainfall_trace, snowfall_trace, delay_trace], 'layout': layout}

    return go.Figure(**figdict)
