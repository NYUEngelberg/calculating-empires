# calculating-empires

In order to turn this repo into the full site, you need to generate the tiles.  A requirement of doing so is gdal.  You can install this on a mac using homebrew with the command

`brew install gdal --HEAD`

Once you have cloned the repo locally, you will need to take two additional steps:

1. make the file generation script executable:
`chmod 755 generate_tiles.sh`

2. run the generate tiles script
`./generate_tiles.sh`

Generating the tiles will take ~30 minutes on an M3 macbook pro.
