# UK LIDAR DEM Composite

## Download

Use the `download.sh` script to download the 2-meter resolution LIDAR-based composite data files. You'll end up with approximately 30GB of zipfiles.

## Convert to GeoTIFF

Once you have the zipfiles downloaded, you'll find that the zipfiles contain multiple `.asc` files that represent a rather small area. Use the `merge_asc_to_geotiff.sh` script to merge the `.asc` files in the zipfiles into a GeoTIFF for each `.zip` file. That script operates on one zipfile at a time, so to speed it up you can run it across multiple processors at once like this:

```
find /mnt/uklidar/ -name "*.zip" -print | \
xargs -I {} -P 12 -n 1 -t sh -c 'export f="{}"; ./merge_asc_to_geotiff.sh $f ${f/.zip/.tif}'
```

## Merge GeoTIFFs

Once you have `.tif`s, you can use the `merge_geotiffs.sh` to merge those relatively small `.tif` files into larger `.tif` files that represent larger areas of the UK National Grid. These GeoTIFFs will be closer to 400 MB instead of 1-20 MB as before. The script runs across a whole directory `.tif`'s, so run it like this:

```
./merge_geotiffs.sh /mnt/uklidar
```

## Upload merged GeoTIFFs

For example:

```
find /mnt/uklidar/ -regex ".*[0-9].tif" -print | \
xargs -P 24 -n 1 -I {} -t sh -c 'export f="{}"; aws s3 cp $f s3://elevation-sources-prod/uk_lidar/$(basename $f)'
```
