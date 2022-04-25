regions = {
    'Region Mitte': 'RME',
    'Region Ost': 'ROT',
    'Region West': 'RWT',
    'Region Süd': 'RSD'
}


def get_region_descriptions():
    return regions.keys()

def get_region_key_from_descriptions(description):
    return regions[description]