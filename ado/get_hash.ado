program define get_hash, rclass
	// This function uses the MS Windows cmd.exe certutil command to get the SHA256 hash of a file.
	// The hash is returned as a string in r(hash).
	// If no output is found the file instead reads from stderr and prints this into the console before returning an error.
	// Inspired by Matthew Bryant Hall, 2021. "INSHELL: Stata module to send commands to the 
	// shell as well as capture and print their standard output, standard error, and native shell return codes," 
	// Statistical Software Components S459033, Boston College Department of Economics, revised 01 Jan 2023.
	// <https://ideas.repec.org/c/boc/bocode/s459033.html> 
	version 17
	syntax using/  /// path of text file containing expected console output
	
	// Using MS Windows
  	if (lower(c(os)) != "windows") {
		display as error "This command is only implemented on MS Windows"
		error 111
	}

	// File exists
	confirm file "`using'"

	// Temporary files for stdout and stderr
	tempfile stdout stderr 

	// Create temporary bat file and pass this to the shell
	tempname batn
	local batfilename = "batfile`batf'.bat"	
	capture file close `batn' 
	quietly file open `batn' using "`batfilename'", write text replace
	quietly file write `batn' `"certutil -hashfile "`using'" SHA256 1> "`stdout'" 2> "`stderr'""' _n
	file close `batn'
	quietly shell "`batfilename'"
	quietly erase "`batfilename'"
	
	process_stderr using `stderr'
	process_stdout using `stdout'

	return local hash "`r(hash)'"
end

program define process_stderr
	// Read stderr and throw error if not empty
	version 17
	syntax using
	tempname stderr_handle
	file open `stderr_handle' `using', read text 
	file read `stderr_handle' stderr_content
	if "`stderr_content'" != "" | r(eof)==0 {
		di as error "`stderr_content'"
		while r(eof)==0 {
            file read `stderr_handle' stderr_content
			di as error "`stderr_content'"
        }
		error
	}
	file close `stderr_handle'
end

program define process_stdout, rclass
	// Retrieve the hash - but if not found or not 64 characters long, throw an error
	version 17
	syntax using
	tempname stdout_handle
	file open `stdout_handle' `using', read text
	file read `stdout_handle' stdout_content
	if "`stdout_content'" == "CertUtil: -hashfile command FAILED: 0x800703ee (WIN32: 1006 ERROR_FILE_INVALID)" {
		// Means the file is empty
		return local hash "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
		exit
	}
	if "`stdout_content'" == "" | r(eof) == 1 {
		// Handle like an error, the file should not end here
		di as error "`stdout_content'"
		di as error "Invalid CertUtil output"
		error
	}
	
	// Expecting hash on line 2 - return this
	file read `stdout_handle' stdout_content 
	return local hash "`stdout_content'"

	if r(eof) == 1 {
		// Handle like an error, the file should contain 3 lines
		process_stderr `using'
	}
	if length("`stdout_content'") != 64 {
		// Hash should be 64 characters long
		// Handle like an error
		process_stderr `using'
	}
	file read `stdout_handle' forgetme
	file read `stdout_handle' forgetme
	if r(eof) == 0 {
		// Handle like an error
		process_stderr `using'
	}
end
