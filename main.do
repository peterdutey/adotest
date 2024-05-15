adopath + "./ado"

clear all
test_package, test("test/tests") out("test") stopiferror
classutil dir
describe