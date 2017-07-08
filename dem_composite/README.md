# UK LIDAR DEM Composite

## Download

Use the `download.sh` script to download the 2-meter resolution LIDAR-based composite data files. You'll end up with approximately 30GB of zipfiles.

## Convert to GeoTIFF

Once you have the zipfiles downloaded, you'll find that the zipfiles contain multiple `.asc` files that represent a rather small area. Use the `merge_asc_to_geotiff.sh` script to merge the `.asc` files in the zipfiles into a GeoTIFF for each `.zip` file.

Once you have `.tif`s, you can use the `merge_geotiffs.sh` to merge those relatively small `.tif` files into larger `.tif` files that represent larger areas of the UK National Grid. These GeoTIFFs will be closer to 400 MB instead of 1-20 MB as before.
