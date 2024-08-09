mkdir -p gdal_intermediate_files;

gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 0 17764 40245 0 \
source_png_files/white_communication/1800ppi/1.png \
gdal_intermediate_files/white_communication_1.tif
gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 40245 17764 80490 0 \
source_png_files/white_communication/1800ppi/2.png \
gdal_intermediate_files/white_communication_2.tif
gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 80490 17764 120735 0 \
source_png_files/white_control/1800ppi/1.png \
gdal_intermediate_files/white_control_1.tif
gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 120735 17764 160980 0 \
source_png_files/white_control/1800ppi/2.png \
gdal_intermediate_files/white_control_2.tif

if [ -f gdal_intermediate_files/combined_white.vrt ] ; then
    rm gdal_intermediate_files/combined_white.vrt
fi;
gdalbuildvrt gdal_intermediate_files/combined_white.vrt \
gdal_intermediate_files/white_communication_1.tif \
gdal_intermediate_files/white_communication_2.tif \
gdal_intermediate_files/white_control_1.tif \
gdal_intermediate_files/white_control_2.tif

if [ -f gdal_intermediate_files/combined_white.vrt.ovr ] ; then
    rm gdal_intermediate_files/combined_white.vrt.ovr
fi;
gdaladdo -r nearest gdal_intermediate_files/combined_white.vrt 2 4 8 16 32
gdal2tiles.py -x -p raster --tilesize=512 -z 0-10 \
gdal_intermediate_files/combined_white.vrt tiles_directory_white_10

rm gdal_intermediate_files/white_communication_1.tif;
rm gdal_intermediate_files/white_communication_2.tif;
rm gdal_intermediate_files/white_control_1.tif;
rm gdal_intermediate_files/white_control_2.tif;
rm gdal_intermediate_files/combined_white.vrt;
rm gdal_intermediate_files/combined_white.vrt.ovr;

gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 0 17764 40245 0 \
source_png_files/black_communication/1800ppi/1.png \
gdal_intermediate_files/black_communication_1.tif
gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 40245 17764 80490 0 \
source_png_files/black_communication/1800ppi/2.png \
gdal_intermediate_files/black_communication_2.tif
gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 80490 17764 120735 0 \
source_png_files/black_control/1800ppi/1.png \
gdal_intermediate_files/black_control_1.tif
gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr 120735 17764 160980 0 \
source_png_files/black_control/1800ppi/2.png \
gdal_intermediate_files/black_control_2.tif

if [ -f gdal_intermediate_files/combined_black.vrt ] ; then
    rm gdal_intermediate_files/combined_black.vrt
fi;
gdalbuildvrt gdal_intermediate_files/combined_black.vrt \
gdal_intermediate_files/black_communication_1.tif \
gdal_intermediate_files/black_communication_2.tif \
gdal_intermediate_files/black_control_1.tif \
gdal_intermediate_files/black_control_2.tif
echo "created black vrt file"

if [ -f gdal_intermediate_files/combined_black.vrt.ovr ] ; then
    rm gdal_intermediate_files/combined_black.vrt.ovr
fi;
gdaladdo -r nearest gdal_intermediate_files/combined_black.vrt 2 4 8 16 32
echo "created black vrt.ovr file"

gdal2tiles.py -x -p raster --tilesize=512 -z 0-10 \
gdal_intermediate_files/combined_black.vrt tiles_directory_black_10
rm gdal_intermediate_files/black_communication_1.tif;
rm gdal_intermediate_files/black_communication_2.tif;
rm gdal_intermediate_files/black_control_1.tif;
rm gdal_intermediate_files/black_control_2.tif;
rm gdal_intermediate_files/combined_black.vrt;
rm gdal_intermediate_files/combined_black.vrt.ovr;
