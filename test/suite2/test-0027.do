.thistest = .testcase.new, ///
  id("27") ///
  name("Test test_console [part expected to fail]")

insobs 2
test_console using "test/suite1/TC0027/console_describe.txt", exp("describe")
clear
local console_output_to_delete: dir "" file "test_console_*.log"
erase `console_output_to_delete'