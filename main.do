adopath + "./ado"

clear all
test_package, test("test/suite1")
test_package, test("test/suite1") out("test/suite1_reports")
test_package, test("test/suite2") out("test/suite2_reports")

classutil dir
describe