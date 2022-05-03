import plotly.graph_objects as go
import pandas as pd
import util.helper as helper
import util.sbbregions as sbbregions

def get_figure(region='RME'):
    query = f'''
        SELECT * FROM weatherdailydelay_rainfallinranges
             WHERE sbbregion_isocode = '{region}'
        '''

    result = pd.read_sql(sql=query, con=helper.get_sql_connection())
    result_df = pd.DataFrame(result)
    result_df['range_start'] = result_df['range'].str.split(" ", 1).str[0]
    result_df.range_start = pd.to_numeric(result_df.range_start, errors='coerce')
    result_df = result_df.sort_values('range_start')
    text_array = [(str(round(value, 1)) + "% Verspätete Züge") for value in result_df['avg_delay'].to_numpy()]

    datatrace1 = {
        'name': 'Rainfall',
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
            ticktext=['Wenig bis kein Regenfall', 'Wenig Regenfall', 'Mittlerer Regenfall', 'Mittelstarker Regenfall', 'Starker Regenfall', '']
        )
    )
    fig.add_vline(x=sbbregions.get_avg_region_delay(region), annotation_xanchor='center', annotation_y=1.1,
                  line_dash="dash", line_color="grey",
                  annotation_text=f'Durchschnittsverspätung: {sbbregions.get_avg_region_delay(region)}%')
    fig.update_traces(textposition='auto')
    return fig

