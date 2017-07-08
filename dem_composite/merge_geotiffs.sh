# For a filename like `LIDAR-DTM-2M-TG43sw.zip`, take the first N chars and sort/group:
grids=$(ls | cut -c -17 | sort | uniq)

for grid in $grids; do
    echo "gdal_merge.py \
        -q \
        -co COMPRESS=DEFLATE \
        -co PREDICTOR=3 \
        -co TILED=yes \
        -co BLOCKXSIZE=512 \
        -co BLOCKYSIZE=512 \
        -a_nodata -9999 \
        -init -9999 \
        -o ${grid}.tif ${grid}*.tif \
    && echo '${grid}.tif'"
done \
| xargs -I {} -n 1 -P 16 sh -c '{}'
