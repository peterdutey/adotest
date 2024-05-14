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
		display as input "> PASS > `message'" _newline
		.thistest.pass
	}
	else {
		.thistest.fail
		display as error "> FAIL > `message'" _newline			
		display as error _col(3) "-- ERROR MESSAGE " _dup(48) "-"
		display as error _col(3) "This assertion is false: `anything'"
		display as error _col(3) _dup(65) "-" _newline
	}
end
