.thistest = .testcase.new, ///
  id("Enter test case number here") ///
  name("Enter test case name here")


* To test subcommands, do the ado first to load subcommands in memory:
// do "path/to/file.ado"


* Test your assertions here
test_assert 1+1 == 2
test_assert 1+1 == 3

