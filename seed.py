import csv
import json
import os
import urllib2

grid = [
    'HP', 'HT', 'HU', 'HW', 'HX', 'HY', 'HZ', 'NA', 'NB', 'NC',
    'ND', 'NF', 'NG', 'NH', 'NJ', 'NK', 'NL', 'NM', 'NN', 'NO',
    'NR', 'NS', 'NT', 'NU', 'NW', 'NX', 'NY', 'NZ', 'OV', 'SC',
    'SD', 'SE', 'TA', 'SH', 'SJ', 'SK', 'TF', 'TG', 'SM', 'SN',
    'SO', 'SP', 'TL', 'TM', 'SR', 'SS', 'ST', 'SU', 'TQ', 'TR',
    'SV', 'SW', 'SX', 'SY', 'SZ', 'TV',
]

columns = [
    'coverageLayer',
    'description',
    'descriptiveName',
    'displayOrder',
    'fileName',
    'fileSize',
    'groupName',
    'guid',
    'id',
    'metaDataUrl',
    'pyramid',
    'tileReference',
]

with open('catalog.csv', 'w') as f:
    writer = csv.DictWriter(f, fieldnames=columns)
    writer.writeheader()

    for g in grid:
        for c in range(0, 100):
            cell = '{}{:02}'.format(g, c)
            catalog_cache = '{}_catalog.json'.format(cell)

            url = 'http://www.geostore.com/environment-agency/rest/product/EA_SUPPLIED_OS_10KM/{}?catalogName=Survey'.format(cell)
            resp = urllib2.urlopen(url)
            results = json.load(resp)
            writer.writerows(results)
