noisily .thistest = .testcase.new, ///
  id("14") ///
  name("Test reporting of failure by test_package")


* Test your assertions here
test_assert 1+1 == 2, message("1+1 = 2")
test_assert 1+1 == 3, message("1+1 <> 3")