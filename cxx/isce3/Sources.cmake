set(SRCS
core/Attitude.cpp
core/Baseline.cpp
core/Basis.cpp
core/BicubicInterpolator.cpp
core/BilinearInterpolator.cpp
core/Constants.cpp
core/DateTime.cpp
core/detail/BuildOrbit.cpp
core/Ellipsoid.cpp
core/EulerAngles.cpp
core/Interpolator.cpp
core/LUT2d.cpp
core/LookSide.cpp
core/Metadata.cpp
core/NearestNeighborInterpolator.cpp
core/Orbit.cpp
core/Pegtrans.cpp
core/Poly1d.cpp
core/Poly2d.cpp
core/Projections.cpp
core/Quaternion.cpp
core/Sinc2dInterpolator.cpp
core/Spline2dInterpolator.cpp
core/TimeDelta.cpp
core/Utilities.cpp
error/ErrorCode.cpp
except/Error.cpp
geometry/boundingbox.cpp
fft/detail/ConfigureFFTLayout.cpp
fft/detail/FFTWWrapper.cpp
fft/detail/Threads.cpp
focus/Backproject.cpp
focus/Chirp.cpp
focus/DryTroposphereModel.cpp
focus/GapMask.cpp
focus/RangeComp.cpp
geocode/baseband.cpp
geocode/geocodeSlc.cpp
geocode/interpolate.cpp
geocode/loadDem.cpp
geometry/DEMInterpolator.cpp
geometry/Geo2rdr.cpp
geometry/Geocode.cpp
geometry/geometry.cpp
geometry/RTC.cpp
geometry/Topo.cpp
image/ResampSlc.cpp
io/gdal/Dataset.cpp
io/gdal/detail/MemoryMap.cpp
io/gdal/GeoTransform.cpp
io/gdal/SpatialReference.cpp
io/IH5.cpp
io/IH5Dataset.cpp
io/Raster.cpp
matchtemplate/ampcor/correlators/c2r.cpp
matchtemplate/ampcor/correlators/correlate.cpp
matchtemplate/ampcor/correlators/detect.cpp
matchtemplate/ampcor/correlators/maxcor.cpp
matchtemplate/ampcor/correlators/migrate.cpp
matchtemplate/ampcor/correlators/nudge.cpp
matchtemplate/ampcor/correlators/offsets.cpp
matchtemplate/ampcor/correlators/r2c.cpp
matchtemplate/ampcor/correlators/refStats.cpp
matchtemplate/ampcor/correlators/sat.cpp
matchtemplate/ampcor/correlators/tgtStats.cpp
matchtemplate/ampcor/dom/Raster.cc
matchtemplate/ampcor/dom/SLC.cc
math/Bessel.cpp
product/Product.cpp
product/RadarGridParameters.cpp
signal/Covariance.cpp
signal/Crossmul.cpp
signal/Filter.cpp
signal/Looks.cpp
signal/NFFT.cpp
signal/shiftSignal.cpp
signal/Signal.cpp
unwrap/icu/Grass.cpp
unwrap/icu/Neutron.cpp
unwrap/icu/PhaseGrad.cpp
unwrap/icu/Residue.cpp
unwrap/icu/Tree.cpp
unwrap/icu/Unwrap.cpp
unwrap/phass/ASSP.cc
unwrap/phass/BMFS.cc
unwrap/phass/CannyEdgeDetector.cc
unwrap/phass/ChangeDetector.cc
unwrap/phass/EdgeDetector.cc
unwrap/phass/PhaseStatistics.cc
unwrap/phass/Phass.cpp
unwrap/phass/PhassUnwrapper.cc
unwrap/phass/Point.cc
unwrap/phass/RegionMap.cc
unwrap/phass/Seed.cc
unwrap/phass/sort.cc
)