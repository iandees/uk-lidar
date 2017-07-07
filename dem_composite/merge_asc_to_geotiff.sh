# Processes the multiple .asc files inside a LIDAR composite DTM 2 meter zipfile into
# a single GeoTIFF.

set -e

zfile=$1

if [[ -z "$zfile" ]]; then
  >&2 echo "usage: $(basename $0) <input zipfile>"
  exit 1
fi

vrt_tmp=$(mktemp -d)

unzip -lqq $zfile \
 | awk '{print $4}' \
 | while read filename; do
     gdalwarp -s_srs "EPSG:27700" -t_srs "EPSG:27700" -of VRT /vsizip/$zfile/$filename $vrt_tmp/${filename/asc/vrt}
   done

gdal_merge.py -a_nodata -9999 -init -9999 -o ${zfile/zip/tif} $vrt_tmp/*.vrt

rm -rf $vrt_tmp
