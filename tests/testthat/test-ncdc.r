context("ncdc")

test_that("ncdc returns the correct ...", {
  vcr::use_cassette("ncdc", {
    # Normals Daily GHCND:USW00014895 dly-tmax-normal data
    aa <- ncdc(datasetid='NORMAL_DLY', datatypeid='dly-tmax-normal', startdate = '2010-05-01', enddate = '2010-05-10')
    # Datasetid, locationid and datatypeid
    # dd <- ncdc(datasetid='PRECIP_HLY', locationid='ZIP:28801', datatypeid='HPCP')
    # Datasetid, locationid, stationid and datatypeid
    # ee <- ncdc(datasetid='PRECIP_HLY', locationid='ZIP:28801', stationid='COOP:310301', datatypeid='HPCP')
    # Normals Daily GHCND dly-tmax-normal data
    gg <- ncdc(datasetid='GHCND', datatypeid = 'PRCP', stationid='GHCND:USC00200230', startdate = "2013-09-03", enddate = "2013-09-30", limit=30)
    # Hourly Precipitation data for ZIP code 28801
    # ii <- ncdc(datasetid='PRECIP_HLY', locationid='ZIP:28801', datatypeid='HPCP', startdate='2012-03-01', enddate='2013-03-15')
    
    # class
    expect_is(aa, "ncdc_data")
  #   expect_is(dd, "noaa_data")
  #   expect_is(ee, "noaa_data")
    expect_is(gg, "ncdc_data")
  #   expect_is(ii, "noaa_data")
    expect_is(aa$meta, "list")
    expect_is(aa$data, "data.frame")
    expect_is(aa$data$date, "character")

    expect_is(gg$meta, "list")
    expect_is(gg$data, "data.frame")
    expect_is(gg$data$date, "character")

    # dimensions
    expect_equal(length(aa$meta), 3)
    expect_equal(dim(aa$data), c(25,5))

    expect_equal(length(gg$meta), 3)
    expect_equal(dim(gg$data), c(28,8))
  #   expect_equal(dim(ii$data), c(22,5))
  #   expect_equal(length(ii$atts), 3)
  })
})


context("ncdc: add units")
test_that("ncdc add units works", {
  vcr::use_cassette("ncdc_add_units", {
    # not add units
    aa <- ncdc(datasetid='NORMAL_DLY', datatypeid='dly-tmax-normal', 
      startdate = '2010-05-01', enddate = '2010-05-10')

    expect_is(aa, "ncdc_data")
    expect_is(aa$data, "tbl_df")
    expect_null(suppressWarnings(aa$data$units))

    # add units
    bb <- ncdc(datasetid='NORMAL_DLY', datatypeid='dly-tmax-normal', 
      startdate = '2010-05-01', enddate = '2010-05-10', add_units = TRUE)

    expect_is(bb, "ncdc_data")
    expect_is(bb$data, "tbl_df")
    expect_is(bb$data$units, "character")


    # not add units
    cc <- ncdc(datasetid='GSOM', startdate = '2013-10-01', 
      enddate = '2013-12-01', stationid = "GHCND:AE000041196")

    expect_is(cc, "ncdc_data")
    expect_is(cc$data, "tbl_df")
    expect_null(suppressWarnings(cc$data$units))

    # add units
    dd <- ncdc(datasetid='GSOM', startdate = '2013-10-01', 
      enddate = '2013-12-01', stationid = "GHCND:AE000041196", add_units = TRUE)

    expect_is(dd, "ncdc_data")
    expect_is(dd$data, "tbl_df")
    expect_is(dd$data$units, "character")
  })
})
