program define test_package
version 18
	// -- USE -----------------------------------------------------
	//
	// Give directory of "test-*.do" files.
	//
	// run_tests, testfiledirectory(< path/to/tests-*.do >)
	//
	// OPTIONAL ARGUMENT
	//
	// - stopiferror: include if you want Stata to stop on false
	//                assertion; good for inspecting error
	//
	// ------------------------------------------------------------
	syntax, TESTdir(string) OUTputdir(string) [ stopiferror ]
	if "`stopiferror'" != "" {
		global stopiferror = 1
	}
	quietly: gen file = ""
	quietly: gen pass = 0
	quietly: gen fail = 0
    quietly: gen total = 0

	local tfiles: dir "`testfiledirectory'" files "tc*.do"
	display as input _newline _dup(80) "="
	foreach tf of local tfiles {
		quietly: insobs 1
		display as input "FILE: `tf'    " _cont 
		preserve
		quietly do "`testfiledirectory'/`tf'"
		restore
		quietly: replace file = "`tf'" if _n==_N
		quietly: replace pass = $qms_tc_pass if _n==_N
		quietly: replace fail = $qms_tc_fail if _n==_N
		quietly: replace total = $qms_tc_total if _n==_N
		quietly: assert  $qms_tc_pass + $qms_tc_fail == $qms_tc_total
	display as input _newline _dup(80) "="
	}
	
	list *
	macro drop stopiferror
end
