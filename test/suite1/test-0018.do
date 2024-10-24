.thistest = .testcase.new, ///
  id("18") ///
  name("Verify compare_files detects differences")
 
capture compare_files, file1("file1doesn'texist") file2("test/suite1/TC0018/onefilecopy.txt")
test_assert _rc == 601, message("file1 doesn't exist, expect return code 601")

capture compare_files, file1("test/suite1/TC0018/onefile.txt") file2("file2doesn'texist")
test_assert _rc == 601, message("file2 doesn't exist, expect return code 601")

compare_files, file1("test/suite1/TC0018/onefile.txt") file2("test/suite1/TC0018/onefilecopy.txt")
test_assert `r(identity)' == 1, message("Two identifical files should return 1")

compare_files, file1("test/suite1/TC0018/onefile.txt") file2("test/suite1/TC0018/anotherfile.txt")
test_assert `r(identity)' == 0, message("Two different files should return 0")

compare_files, file1("test/suite1/TC0018/onefile.txt") file2("test/suite1/TC0018/emptyfile.txt")  
test_assert `r(identity)' == 0, message("Two different files should return 0")
