import streamlit as st

import charts.rainfall_perday_chart as rainfall_per_day_chart
import charts.rainfall_grouped_chart as rainfall_grouped_chart
import charts.snowfall_grouped_chart as snowfall_grouped_chart
import util.sbbregions as sbbregions
import util.months as months
from PIL import Image


st.set_page_config('Zugverspätung')

st.title('Zugverspätung bei Regenfall und Schnee')
st.markdown('Wir haben untersucht was für einen Einfluss Niederschlag auf die Pünktlichkeit der Züge in der Schweiz hat. Die Daten beziehen sich jeweils auf das Jahr 2021.')

st.text('')
st.text('')

image = Image.open('./assets/sbb_regions.png')
st.image(image)

st.text('')
st.text('')

sbbregion = st.sidebar.selectbox('SBB Region', sbbregions.get_region_descriptions())
sbbregion_key = sbbregions.get_region_key_from_descriptions(sbbregion)

# Rainfall chart
st.subheader('Niederschlag vs Zugverspätung pro Tag')
month = st.selectbox('Monat', months.get_month_descriptions())
st.plotly_chart(
    rainfall_per_day_chart.get_figure(sbbregion_key, months.get_month_key_from_descriptions(month)),
    config={'displayModeBar': False}
)

st.subheader('Niederschlag gruppiert')
# Regenfall grouped chart
st.plotly_chart(
    rainfall_grouped_chart.get_figure(sbbregion_key),
    config={'displayModeBar': False}
)

# Schneefall grouped chart
if sbbregion_key != 'RSD':
    st.plotly_chart(
        snowfall_grouped_chart.get_figure(sbbregion_key),
        config={'displayModeBar': False}
    )
else:
    st.warning('Nicht genügend Daten vorhanden')


