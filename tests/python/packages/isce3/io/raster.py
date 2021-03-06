#!/usr/bin/env python3

from osgeo import gdal
gdal.UseExceptions()

class commonClass:
    def __init__(self):
        self.nc = 100
        self.nl = 200
        self.nbx = 5
        self.nby = 7
        self.latFilename = 'lat.tif'
        self.lonFilename = 'lon.vrt'
        self.incFilename = 'inc.bin'
        self.mskFilename = 'msk.bin'
        self.vrtFilename = 'topo.vrt'


def test_createGeoTiffFloat():
    import isce3
    import os
    import numpy as np

    cmn = commonClass()
    if os.path.exists( cmn.latFilename):
        os.remove(cmn.latFilename)

    raster = isce3.io.raster(filename=cmn.latFilename, width=cmn.nc, length=cmn.nl,
                        numBands=1, dtype=gdal.GDT_Float32,
                        driver='GTiff', access=gdal.GA_Update)

    assert( os.path.exists(cmn.latFilename))
    assert( raster.width == cmn.nc )
    assert( raster.length == cmn.nl )
    
    assert( raster.numBands == 1)
    assert( raster.getDatatype() == gdal.GDT_Float32)
    del raster

    data = np.zeros((cmn.nl, cmn.nc))
    data[:,:] = np.arange(cmn.nc)[None,:]

    ds = gdal.Open(cmn.latFilename, gdal.GA_Update)
    ds.GetRasterBand(1).WriteArray(data)
    ds = None

    return

def test_createVRTDouble_setGetValue():
    import isce3
    import os
    import numpy as np
    import numpy.testing as npt

    cmn = commonClass()
    if os.path.exists( cmn.lonFilename):
        os.remove(cmn.lonFilename)

    raster = isce3.io.raster(filename=cmn.lonFilename, width=cmn.nc, length=cmn.nl,
                        numBands=1, dtype=gdal.GDT_Float64,
                        driver='VRT', access=gdal.GA_Update)

    assert( os.path.exists(cmn.lonFilename))
    assert( raster.getDatatype() == gdal.GDT_Float64)
    del raster

    data = np.zeros((cmn.nl, cmn.nc))
    data[:,:] = np.arange(cmn.nl)[:,None]

    ##Open and populate
    ds = gdal.Open(cmn.lonFilename, gdal.GA_Update)
    ds.GetRasterBand(1).WriteArray(data)
    arr = ds.GetRasterBand(1).ReadAsArray()
    npt.assert_array_equal(data, arr, err_msg='RW in Update mode')
    ds = None

    ##Read array
    ds = gdal.Open(cmn.lonFilename, gdal.GA_ReadOnly)
    arr = ds.GetRasterBand(1).ReadAsArray()
    ds = None

    npt.assert_array_equal(data, arr, err_msg='Readonly mode')

    return

def test_createTwoBandEnvi():
    import isce3
    import os
    import numpy as np

    cmn = commonClass()
    if os.path.exists( cmn.incFilename):
        os.remove(cmn.incFilename)

    raster = isce3.io.raster(filename=cmn.incFilename, width=cmn.nc, length=cmn.nl,
                        numBands=2, dtype=gdal.GDT_Int16,
                        driver='ENVI', access=gdal.GA_Update)

    assert( os.path.exists(cmn.incFilename))
    assert( raster.width == cmn.nc )
    assert( raster.length == cmn.nl )
    
    assert( raster.numBands == 2)
    assert( raster.getDatatype() == gdal.GDT_Int16)
    del raster

    return

def test_createMultiBandVRT():
    import isce3
    import os

    cmn = commonClass()
    lat = isce3.io.raster(filename=cmn.latFilename)
    lon = isce3.io.raster(filename=cmn.lonFilename)
    inc = isce3.io.raster(filename=cmn.incFilename)

    if os.path.exists( cmn.vrtFilename):
        os.remove(cmn.vrtFilename)

    vrt = isce3.io.raster(filename=cmn.vrtFilename, collection=[lat,lon,inc])

    assert( vrt.width == cmn.nc)
    assert( vrt.length == cmn.nl)
    assert( vrt.numBands == 4)
    assert( vrt.getDatatype(1) == gdal.GDT_Float32)
    assert( vrt.getDatatype(2) == gdal.GDT_Float64)
    assert( vrt.getDatatype(3) == gdal.GDT_Int16)
    assert( vrt.getDatatype(4) == gdal.GDT_Int16)

    vrt = None

    return

def test_createNumpyDataset():
    import numpy as np
    import isce3
    from osgeo import gdal_array
    import os

    ny, nx = 200, 100
    data = np.random.randn(ny, nx).astype(np.float32)
    
    dset = gdal_array.OpenArray(data)
    raster = isce3.io.raster(filename='', dataset=dset)

    assert(raster.width == nx)
    assert(raster.length == ny)
    assert(raster.getDatatype() == 6)

    dset = None
    del raster

    return

if __name__ == '__main__':
    test_createGeoTiffFloat()
    test_createVRTDouble_setGetValue()
    test_createTwoBandEnvi()
    test_createMultiBandVRT()
    test_createNumpyDataset()
