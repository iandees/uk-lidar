curl -s https://raw.githubusercontent.com/iandees/uk-lidar/master/catalog.csv \
 | grep LIDAR-DTM-2M-ENGLAND-EA-MD-YY \
 | cut -d, -f 8,5 \
 | xargs -I {} -P 24 -n 1 \
   sh -c 'export f="{}"; a=$(cut -d, -f 1 <<< $f); b=$(cut -d, -f 2 <<< $f); curl -s -o $a http://www.geostore.com/environment-agency/rest/product/download/$b'
