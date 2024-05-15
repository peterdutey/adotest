program compare_txt, rclass
syntax, file1(string) file2(string)

    if (lower(c(os)) != "windows") {
        di as error "This program is only available for Windows"
        exit
    }

    quietly which inshell
    if _rc==111 {
        di as error "inshell not found"
        exit 111
    }

    capture quietly dir `file1'
    if _rc!=0 {
        di as error "file1 not found"
        exit
    }
    capture quietly dir `file2'
    if _rc!=0 {
        di as error "file2 not found"
        exit
    }

    inshell Certutil -hashfile `c(pwd)'/`file1' SHA256
    local hash1 = "`r(no2)'"
    inshell Certutil -hashfile `c(pwd)'/`file2' SHA256
    local hash2 = "`r(no2)'"

    return list

    if "`hash1'" != "`hash2'" {
        di as error "Files are different"
        return scalar identity = 0
    }
    else {
        return scalar identity = 1
    }
end