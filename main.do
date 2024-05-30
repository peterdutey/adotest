adopath + "./ado"

clear all

* Test successful test suite without reporting
test_package, test("test/suite1")

* Test successful test suite with reporting
test_package, test("test/suite1") out("test/suite1_reports")

* Test failing test suite with reporting
test_package, test("test/suite2") out("test/suite2_reports")

* Show memory content after test suites (must be clear)
classutil dir
describe