context("noaa_datacats")

key='YZJVDgzurxvMqiIcfpzrOozpRBVvTBhE'

tt <- noaa_datacats(token=key)
uu <- noaa_datacats(datacategoryid="ANNAGR", token=key)

test_that("noaa_datacats returns the correct class", {
  expect_is(tt, "noaa_datacats")
  expect_is(tt$data, "data.frame")
  expect_is(tt$data$name, "character")
  expect_is(uu$data, "data.frame")
  expect_is(uu$data$name, "character")
})

test_that("noaa_datacats returns the correct dimensions", {
  expect_equal(dim(tt$data), c(25,2))
  expect_equal(length(tt$data$id), 25)
  expect_equal(dim(uu$data), c(1,2))
  expect_equal(dim(uu[[1]]), NULL)
})
