program define test_package
version 18
syntax, ///
  TESTdir(string)       ///
  [ OUTputdir(string) ] ///
  [ stopiferror ]       // option to trigger error if any test fails

	// Create a class to hold the test results
	.tcresults = .testsuite.new

	if "`outputdir'" == "" {
		log using "`outputdir'/test_report.log", replace
	}

	local tfiles: dir "`testdir'" files "test-*.do", respectcase
	local i = 0
	noisily display as input "Beginning testing in `testdir'."
	
	display as input _newline _dup(80) "="
	foreach tf of local tfiles {
		local i = `i' + 1
		display as input "FILE: `tf'    " 
		run "`testdir'/`tf'"
		.tcresults.testcases[`i'] = .thistest
		classutil drop .thistest
	display as input _dup(80) "="
	}

	display as input _newline "Testing complete."

	if "`outputdir'" == "" {
		log close
	}

	classutil d .tcresults
	if "`stopiferror'" != "" {
		* check if any failed and throw error exit xxxx
	}
end
