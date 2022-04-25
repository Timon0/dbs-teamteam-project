import streamlit as st

import charts.rainfall_chart as rainfallchart
import util.sbbregions as sbbregions
import util.months as months

st.title('SBB Zugsverspätung bei Regenfall und Schnee')


# Rainfall chart
col1, col2 = st.columns(2)
sbbregion = col1.selectbox('SBB Region', sbbregions.get_region_descriptions())
month = col2.selectbox('Monat', months.get_month_descriptions())
st.plotly_chart(
    rainfallchart.get_figure(sbbregions.get_region_key_from_descriptions(sbbregion),
                             months.get_month_key_from_descriptions(month))
)

