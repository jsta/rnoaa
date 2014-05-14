context("check_response")

key='YZJVDgzurxvMqiIcfpzrOozpRBVvTBhE'

# function to pull error out and convert to character class for checking
error2character <- function(express){
  tryCatch(express, error=function(x) as.character(x))
}

test_that("check_response returns an error", {
  expect_error(noaa_locs_cats(startdate='2100-01-01', token=key))
  expect_error(noaa_locs_cats(startdate='1990-01-0', token=key))
  expect_error(
    noaa(datasetid='GHCNDS', locationid='FIPS:BR', datatypeid='PRCP',
         startdate = '2010-05-01', enddate = '2010-05-10', token=key)
  )
  expect_error(
    noaa(datasetid='GHCND', token=key)
  )
})

test_that("check_response returns the correct error messages", {
  # no data found
  expect_output(error2character(noaa_locs_cats(startdate='2100-01-01', token=key)), "no data found")
  # wrong date input
  expect_output(error2character(noaa_locs_cats(startdate='1990-01-0', token=key)), "error occured while servicing your request")
  # missing startdate parameter
  expect_output(error2character(noaa(datasetid='GHCND', token=key)), "Required parameter 'startdate' is missing")
  # internal server error
  expect_output(
    error2character(
      noaa(datasetid='GHCNDS', locationid='FIPS:BR', datatypeid='PRCP',
           startdate = '2010-05-01', enddate = '2010-05-10', token=key)),
    "Internal Server Error"
  )
  # no data found
  expect_output(error2character(noaa_datacats(startdate = '2013-10-01', locationid = "234234234", token=key)), "no data found")
  # bad key
  expect_output(error2character(noaa_datacats(datacategoryid="ANNAGR", token = "asdfs")), "400")
  # invalid longitude value
  expect_output(error2character(noaa_stations(extent=c(47.5204,-122.2047,47.6139,-192.1065), token=key)), "no data found")
})
