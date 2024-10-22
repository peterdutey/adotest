noisily .thistest = .testcase.new, ///
  id("26") ///
  name("Test get_hash")


* Load subcommands
do "ado/get_hash.ado"

capture process_stderr using "test/suite1/TC0026/empty_file.txt"
test_assert _rc == 0, message("process_stderr does not raise error in presence of empty file")

capture process_stderr using "test/suite1/TC0026/error-from-stderr.txt"
test_assert _rc == 197, message("process_stderr otherwise raises error and prints stderr")

capture process_stdout using "test/suite1/TC0026/stdout_empty_file.txt"
test_assert _rc == 0, message("process_stderr does not raise error in presence of empty file")

process_stdout using "test/suite1/TC0026/correct_hash.txt"
test_assert "`r(hash)'" == "faeda27889bb95f3fb5eba84b5f2aa87bf0c604ea7fc2b88172cbb82e05cac7d", message("process_stdout returns correct hash")

process_stdout using test/suite1/TC0026/correct_hash.txt
test_assert "`r(hash)'" == "faeda27889bb95f3fb5eba84b5f2aa87bf0c604ea7fc2b88172cbb82e05cac7d", message("process_stdout returns correct hash when using has no quotes")

capture process_stdout using "test/suite1/TC0026/short_hash.txt"
test_assert _rc == 197, message("process_stdout raises error when hash is not 64 characters long 1/2")

capture process_stdout using "test/suite1/TC0026/long_hash.txt"
test_assert _rc == 197, message("process_stdout raises error when hash is not 64 characters long 1/2")

capture process_stdout using "test/suite1/TC0026/bad_hash.txt"
test_assert _rc == 197, message("process_stdout raises error when file is not as expected")

capture process_stdout using "test/suite1/TC0026/empty_file.txt"
test_assert _rc == 197, message("process_stdout raises error when file is empty")

capture get_hash using "test/suite1/TC0026/I don't exist.txt"
test_assert _rc == 601, message("get_hash raises error when file does not exist")

get_hash using "test/suite1/TC0026/error-from-stderr.txt"
test_assert "`r(hash)'" == "faeda27889bb95f3fb5eba84b5f2aa87bf0c604ea7fc2b88172cbb82e05cac7d", message("get_hash returns correct hash")

capture get_hash using test/suite1/TC0026/empty_file.txt
test_assert "`r(hash)'" == "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", message("get_hash successfully returns hash when file is empty")


* Clean up
program drop _all
