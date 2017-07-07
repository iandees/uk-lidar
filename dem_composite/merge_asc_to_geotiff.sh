# Processes the multiple .asc files inside a LIDAR composite DTM 2 meter zipfile into
# a single GeoTIFF.

set -e

zfile=$1
ofile=$2

if [[ -z "$zfile" || -z "$ofile" ]]; then
  >&2 echo "usage: $(basename $0) <input zipfile name> <output geotiff name>"
  exit 1
fi

vrt_tmp=$(mktemp -d)

unzip -lqq $zfile \
 | awk '{print $4}' \
 | while read filename; do
     gdalwarp -q -s_srs "EPSG:27700" -t_srs "EPSG:27700" -of VRT /vsizip/$zfile/$filename $vrt_tmp/${filename/asc/vrt}
   done

gdal_merge.py \
    -q \
    -co COMPRESS=DEFLATE \
    -co PREDICTOR=3 \
    -co TILED=yes \
    -co BLOCKXSIZE=512 \
    -co BLOCKYSIZE=512 \
    -a_nodata -9999 \
    -init -9999 \
    -o $ofile $vrt_tmp/*.vrt

rm -rf $vrt_tmp
