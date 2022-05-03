regions = {
    'Region Mitte': 'RME',
    'Region Ost': 'ROT',
    'Region West': 'RWT',
    'Region Süd': 'RSD'
}

avg_delay_per_region = {
  "RSD": 10.0,
  "RWT": 9.6,
  "ROT": 4.6,
  "RME": 9.3
}


def get_region_descriptions():
    return regions.keys()

def get_region_key_from_descriptions(description):
    return regions[description]

def get_avg_region_delay(region_code):
    return avg_delay_per_region[region_code]
