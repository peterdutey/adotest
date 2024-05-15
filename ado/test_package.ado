program define test_package
version 18
syntax, ///
  TESTdir(string)       ///
  [ OUTputdir(string) ] /// path where to store 
  [ stopiferror ]       // option to trigger error if any test fails

	// Create a class to hold the test results
	.tcresults = .testsuite.new

	local dttm = strofreal(now(), "%tcCCYYMMDDHHMM")

	if "`outputdir'" != "" {
		quietly log using "`outputdir'/test_report_`dttm'.log", text
	}

	local tfiles: dir "`testdir'" files "test-*.do", respectcase
	local i = 0
	noisily display as input "Beginning testing in `testdir'."
	
	display as input _newline _dup(80) "="
	foreach tf of local tfiles {
		local i = `i' + 1
		display as input "FILE: `tf'    " 
		run "`testdir'/`tf'"
		.thistest.end
		clear
		clear mata 
		clear results
		clear matrix
		clear rngstream
		clear frames
		clear collect
		.tcresults.testcases[`i'] = .thistest
		classutil drop .thistest
	display as input _dup(80) "="
	}

	display as input _newline "Testing complete."

	gen test_id = ""
	gen test_name = ""
	gen passed = 0
	gen failed = 0
	gen total = 0
	gen start_dttm = ""
    gen end_dttm = ""

	quietly : foreach j of numlist 1/`i' {
		insobs 1
		replace test_id = "`.tcresults.testcases[`j'].id'" if _n == _N
		replace test_name = "`.tcresults.testcases[`j'].name'" if _n == _N
		replace passed = `.tcresults.testcases[`j'].passed' if _n == _N
		replace failed = `.tcresults.testcases[`j'].failed' if _n == _N
		replace start_dttm = "`.tcresults.testcases[`j'].start_dttm'" if _n == _N
		replace end_dttm = "`.tcresults.testcases[`j'].end_dttm'" if _n == _N
	}

	quietly replace total = passed + failed

	list  *, clean noobs

	if "`stopiferror'" != "" & failed > 0 {
		display as error "One or more tests failed. See test_report.log for details."
	}
	
	if "`outputdir'" != "" {
		export delimited using "`outputdir'/test_report_`dttm'.csv", quote
		quietly log close
	}	

	clear all
end
