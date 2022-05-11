import util.sbbregions as sbbregions

grouped_labels = [
  'Wenig bis kein',
  'Wenig',
  'Mittlerer',
  'Mittelstarker',
  'Starker'
]

def get_grouped_labels(type, region):
  # Copy grouped_labels so labels can be popped out without any consquences for other charts
  labels = grouped_labels.copy()
  
  # Remove label "Mittelstarker Regenfall" for region ost and west, since there is no data for these ranges
  if (type == 'Regenfall' and (region == 'ROT' or region == 'RWT')):
    labels.pop(3)

  return [f'{label} {type}' for label in labels]

def create_vline_avg_delay(region):
  return {
    'x': sbbregions.get_avg_region_delay(region),
    'annotation_xanchor':'center',
    'annotation_y': 1.1,
    'line_dash': "dash",
    'line_color': "grey",
    'annotation_text': f'Durchschnittsverspätung: {sbbregions.get_avg_region_delay(region)}%'
  }