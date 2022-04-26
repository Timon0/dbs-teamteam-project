import streamlit as st

import charts.rainfall_perday_chart as rainfallchart
import util.sbbregions as sbbregions
import util.months as months
from PIL import Image

st.title('Zugverspätung bei Regenfall und Schnee')
st.markdown('Wir haben untersucht was für einen Einfluss Regenfall und Schnee auf die Pünktlichkeit der Züge in der Schweiz hat. Die Daten beziehen sich jeweils auf das Jahr 2021.')

st.text('')
st.text('')

image = Image.open('./assets/sbb_regions.png')
st.image(image)

st.text('')
st.text('')

# Rainfall chart
st.subheader('Niederschlag vs Pünktlickeit pro Tag')
col1, col2 = st.columns(2)
sbbregion = col1.selectbox('SBB Region', sbbregions.get_region_descriptions())
month = col2.selectbox('Monat', months.get_month_descriptions())
st.plotly_chart(
    rainfallchart.get_figure(sbbregions.get_region_key_from_descriptions(sbbregion),
                             months.get_month_key_from_descriptions(month)),
    config={'displayModeBar': False}
)


