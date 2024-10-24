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
log query _all

* Verify the stata.toc
net from "`c(pwd)'/ado"
// web equivalent
// net from "https://raw.githubusercontent.com/peterdutey/adotest/main/ado/"


* Verify the pkg file
net describe adotest, from("`c(pwd)'/ado")
// web equivalent
// net describe adotest, from("https://raw.githubusercontent.com/peterdutey/adotest/main/ado/")

