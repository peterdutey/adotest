.actualtest = .testcase.new, ///
  id("9") ///
  name("Check test_assert function")

**# Step 1 
capture test_assert 1+1 == 2, ///
  message("Missing .testcase instantiation! test asset must raise an error 111")
if _rc == 111 {
    display as input "> PASS > test_assert raised error 111 in absence of a .thistest instance"
}
else {
    display as error "> FAIL > test_assert did not raise error 111"
}

**# Step 2 
.thistest = .testcase.new, id("faketest") name("faketest")

capture test_assert 1+1 == 2, ///
  message("Instantiate a .thistest testcase and test a pass")

if _rc == 0 & `.thistest.passed' == 1 & `.thistest.failed' == 0 {
     display as input "> PASS > test_assert reported a pass as expected"
    .actualtest.pass
}
else {
    display as error "> FAIL > test_assert did not count a failed assertion"
    .actualtest.fail
}

**# Step 3 
.thistest = .testcase.new, id("faketest") name("faketest")

capture test_assert 1+1 == 4, ///
  message("Reset .thistest and test a fail")

if _rc == 0 & `.thistest.passed' == 0 & `.thistest.failed' == 1  {
     display as input "> PASS > test_assert reported a fail as expected"
    .actualtest.pass
}
else {
    display as error "> FAIL > test_assert did not count a failed assertion"
    .actualtest.fail
}

**# Step  TODO check the print test_assert 1+1 == 4, message("1+1=4") when the test_console function is developed

.thistest = .actualtest
classutil drop .actualtest
classutil dir
