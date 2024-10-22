program compare_files, rclass
    version 17
    syntax, file1(string) file2(string)

    if (lower(c(os)) != "windows") {
        di as error "This program is only available for Windows"
        exit
    }

    capture confirm file "`file1'"
    if _rc!=0 {
        confirm file "`file1'"
    }
    capture confirm file "`file2'"
    if _rc!=0 {
        confirm file "`file2'"
    }
    
    get_hash using "`file1'"
    local hash1 = "`r(hash)'"
    get_hash using "`file2'"
    local hash2 = "`r(hash)'"

    if "`hash1'" != "`hash2'" {
        di as error "Files are different"
        return scalar identity = 0
    }
    else {
        return scalar identity = 1
    }
end