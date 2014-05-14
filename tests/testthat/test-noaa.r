context("noaa")

key='YZJVDgzurxvMqiIcfpzrOozpRBVvTBhE'

# Normals Daily GHCND:USW00014895 dly-tmax-normal data
aa <- noaa(datasetid='NORMAL_DLY', datatypeid='dly-tmax-normal', startdate = '2010-05-01', enddate = '2010-05-10', token=key)
# Datasetid, locationid and datatypeid
# dd <- noaa(datasetid='PRECIP_HLY', locationid='ZIP:28801', datatypeid='HPCP')
# Datasetid, locationid, stationid and datatypeid
# ee <- noaa(datasetid='PRECIP_HLY', locationid='ZIP:28801', stationid='COOP:310301', datatypeid='HPCP')
# Normals Daily GHCND dly-tmax-normal data
gg <- noaa(datasetid='GHCND', datatypeid = 'PRCP', stationid='GHCND:USC00200230', startdate = "2013-09-03", enddate = "2013-09-30", limit=30, token=key)
# Hourly Precipitation data for ZIP code 28801
# ii <- noaa(datasetid='PRECIP_HLY', locationid='ZIP:28801', datatypeid='HPCP', startdate='2012-03-01', enddate='2013-03-15')

test_that("noaa returns the correct class", {
  expect_is(aa, "noaa_data")
#   expect_is(dd, "noaa_data")
#   expect_is(ee, "noaa_data")
  expect_is(gg, "noaa_data")
#   expect_is(ii, "noaa_data")
  expect_is(aa$meta, "list")
  expect_is(aa$data, "data.frame")
  expect_is(aa$meta$totalCount, "numeric")
  expect_is(aa$data$date, "character")

  expect_is(gg$meta, "list")
  expect_is(gg$data, "data.frame")
  expect_is(gg$meta$totalCount, "numeric")
  expect_is(gg$data$date, "character")
})

test_that("noaa returns the correct dimensions", {
  expect_equal(length(aa$meta), 3)
  expect_equal(dim(aa$data), c(25,5))

  expect_equal(length(gg$meta), 3)
  expect_equal(dim(gg$data), c(28,8))
#   expect_equal(dim(ii$data), c(22,5))
#   expect_equal(length(ii$atts), 3)
})
