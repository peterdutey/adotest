program define test_assert
version 18
syntax anything [, message(string)] 
	quietly classutil dir .thistest
	if "`r(list)'" == "" {
		display as error "The object .thistest is not found. Please make sure it is created before running test_assert"
		exit 111
	}
	capture assert `anything'
	if _rc == 0 {
		display as input "> PASS: `message'"
		.thistest.pass = `.thistest.pass' + 1
	}
	else {
		.thistest.fail = `.thistest.fail' + 1
		display as error "> FAIL: `message'" _newline			
		display as error _col(3) "-- ERROR MESSAGE " _dup(48) "-"
		display as error _col(3) "Assertion returned false: `test_statement'"
		display as error _col(3) _dup(65) "-" _newline
	}
end
