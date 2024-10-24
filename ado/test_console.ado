program define test_console
version 17
syntax using/,            /// expected console output (without leading and trailing return carriages)
       exp(string)        /// an expression to execute
	
    quietly classutil dir .thistest
	if "`r(list)'" == "" {
		noisily display as error "The object .thistest is not found. Please make sure it is created before running test_console"
		exit 111
	}

    confirm file "`using'"
    local observed_log = "test_console_`=now()'.log"

    noisily display as input "> Capturing console output for [`exp']"
    log_something using `observed_log', exp("`exp'")
    
    compare_files, file1("`observed_log'") file2("`using'")
    if `r(identity)' == 1 {
		noisily display as input "> PASS > The console output matches `using'"
		.thistest.pass
        erase `observed_log'
	}
	if `r(identity)' == 0  {
		.thistest.fail
		noisily display as error "> FAIL > The console output does not match `using'"
		noisily display as error _col(3) "-- CONSOLE OUTPUT " _dup(47) "-"
        display as error _col(3) "Please review output in `observed_log'."
		noisily display as error _col(3) ""
		noisily display as error _col(3) _dup(65) "-" 
	}
end

program define log_something
    version 17
    syntax using, exp(string) 
    di "`exp'" 
    set linesize 255
    set output proc
    log `using', text nomsg name(test_console_log_handle)
    `exp'
    log close test_console_log_handle
end