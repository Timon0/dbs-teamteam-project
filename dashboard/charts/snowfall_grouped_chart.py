import pandas as pd
import plotly.graph_objects as go

import util.charts as charts
import util.helper as helper


def get_figure(region='RME'):
    query = '''
        SELECT * FROM weatherdailydelay_snowfallinranges 
             WHERE sbbregion_isocode = %s
    '''

    result = pd.read_sql(sql=query, con=helper.get_sql_connection(), params=[region])
    result_df = pd.DataFrame(result)
    print(result_df);
    result_df['range_start'] = result_df['range'].str.split(" ", 1).str[0]
    result_df.range_start = pd.to_numeric(result_df.range_start, errors='coerce')
    result_df = result_df.sort_values('range_start')
    text_array = [(str(round(value, 1)) + "% Verspätete Züge") for value in result_df['avg_delay'].to_numpy()]

    datatrace1 = {
        'name': 'Snowfall',
        'type': 'bar',
        'y': result_df['range'],
        'x': result_df['avg_delay'],
        'orientation': 'h',
        'text': text_array,
        'marker': {'color': '#f08576'}
    }
    figdict = {'data': [datatrace1]}
    fig = go.Figure(**figdict)
    fig.update_layout(
        yaxis=dict(
            tickmode='array',
            tickvals=result_df['range'],
            ticktext=charts.get_grouped_labels('Schnefall', region)
        )
    )
    fig.add_vline(**charts.create_vline_avg_delay(region))
    fig.update_traces(textposition='auto')
    return fig

