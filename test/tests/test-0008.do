noisily .thistest = .testcase.new, ///
  id("8") ///
  name(".testcase class instances are created and can be updated") ///
  total(1)

test_assert `.thistest.passed' == 0, message("Pass counter starts at zero.")
test_assert `.thistest.passed' == 1, message("Pass counter successfully hiked to 1.")
* test the modifier method pass
.thistest.pass
test_assert `.thistest.passed' == 3, message("Pass counter successfully hiked to 3.")

test_assert `.thistest.failed' == 0, message("Fail counter starts at zero.")
* test the modifier method fail
.thistest.fail
test_assert `.thistest.failed' == 1, message("Fail counter successfully hiked to 1.")
.thistest.failed = 0
test_assert `.thistest.failed' == 0, message("Fail counter reset to 0 to pass the test.")

test_assert `.thistest.isofclass testcase' == 1, message("Object exists and is of class .testcase")

test_assert regexm("`.thistest.start_dttm'", "^2[0-9]{3}-[0-9]{2}-[0-9]{2} [0-2][0-9]:[0-5][0-9]:[0-5][0-9]"), message("Has a start time")
