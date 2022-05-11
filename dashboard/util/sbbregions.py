regions = {
    'Region Mitte': 'RME',
    'Region Ost': 'ROT',
    'Region West': 'RWT',
    'Region Süd': 'RSD',
    'Gesamtes Netz': 'NETZ'
}

avg_delay_per_region = {
  "RSD": 9.2,
  "RWT": 11.8,
  "ROT": 5.6,
  "RME": 8.5,
  "NETZ": 8.0
}


def get_region_descriptions():
    return regions.keys()

def get_region_key_from_descriptions(description):
    return regions[description]

def get_avg_region_delay(region_code):
    return avg_delay_per_region[region_code]
