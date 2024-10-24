program define test_package
version 17
syntax using/,                   /// path where unit test do files are stored 
       [ OUTputdir(string) ]     /// path where to store 

	// Create a class to hold the test results
	.tcresults = .testsuite.new

	local dttm = strofreal(now(), "%tcCCYYNNDDHHMMSS")

	if "`outputdir'" != "" {
		quietly log using "`outputdir'/test_report_`dttm'.log", text name(test_package_log)
	}

	local tfiles: dir "`using'" files "test-*.do", respectcase
	local i = 0
	noisily display as input "Beginning testing in `using'."
	
	display as input _newline _dup(80) "="
	foreach tf of local tfiles {
		local i = `i' + 1
		display as input "FILE: `tf'    " 
		run "`using'/`tf'"
		.thistest.end
		clear
		clear programs
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

	if failed > 0 {
		display as error "One or more tests failed."
	}

	list *, clean noobs
	
	if "`outputdir'" != "" {
		export delimited using "`outputdir'/test_report_`dttm'.csv", quote
		quietly log close test_package_log
	}	

	clear all
end
