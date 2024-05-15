program define test_assert
version 18
syntax anything [, message(string)] 
	quietly classutil dir .thistest
	if "`r(list)'" == "" {
		noisily display as error "The object .thistest is not found. Please make sure it is created before running test_assert"
		exit 111
	}
	capture assert `anything'
	if _rc == 0 {
		noisily display as input "> PASS > `message'"
		.thistest.pass
	}
	else {
		.thistest.fail
		noisily display as error "> FAIL > `message'"			
		noisily display as error _col(3) "-- ERROR MESSAGE " _dup(48) "-"
		noisily display as error _col(3) "This assertion is false: `anything'"
		noisily display as error _col(3) _dup(65) "-"
	}
end
