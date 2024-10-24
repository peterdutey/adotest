.thistest = .testcase.new, ///
  id("23") ///
  name("test_assert supports 'if' and 'in' inputs")


* Create some data
insobs 2
gen x = 1
replace x = 2 in 2

* Test simple assertion
test_assert x < 3, message("1 and 2 both < 3")

* Test assertions with if
test_assert x == 1 if _n == 1, message("1=1 with if")
test_assert x == 2 if _n == 2, message("1=1 with if")
test_assert x != 2 if _n == 1, message("1<>2 with if")
test_assert 1 + 1 == 2 if 2 + 2 == 1, message("This test must fail due to a null condition")

* Test assertions with in
test_assert x == 1 in 1, message("1=1 with in") 
test_assert x == 2 in 2, message("1=1 with in") 
test_assert x != 2 in 1, message("1<>2 with in")