.thistest = .testcase.new, ///
  id("27") ///
  name("Test test_console")

cap program drop test_console 
do ./ado/test_console.ado

capture test_console using "i don't exist", exp("blah")
test_assert _rc == 601, message("If console_file does not exist, expect error code 601")

capture test_console using "test/suite1/TC0027/console_describe.txt"
test_assert _rc == 198, message("If exp is missing, expect error 198 1/2")

capture test_console using "test/suite1/TC0027/console_describe.txt", exp("") 
test_assert _rc == 198, message("If exp is missing, expect error 198 2/2")

clear
test_console using "test/suite1/TC0027/console_describe.txt", exp("describe")
insobs 1
test_console using "test/suite1/TC0027/console_describe1.txt", exp("describe")
// test without quote marks
test_console using test/suite1/TC0027/console_describe1.txt, exp("describe")

// Another Stata obsession to add file extensions
webuse nhanes2, clear
log_something using test/suite1/TC0027/test_logging_something, exp("table agegrp") 
compare_files, file1("test/suite1/TC0027/test_logging_something.log") file2("test/suite1/TC0027/expected_table1.txt")
test_assert `r(identity)' == 1, message("log_something successfully logs output of some code")

erase test/suite1/TC0027/test_logging_something.log

test_console using "test/suite1/TC0027/expected_table1.txt", exp("table agegrp")
test_console using "test/suite1/TC0027/expected_table1if.txt", exp("table agegrp if agegrp <= 3")


// Clean up
program drop _all
