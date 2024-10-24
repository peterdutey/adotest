{smcl}
{cmd:help test_package} 
{right:also see: {help adotest}}
{hline}

{title:test_package}

{title:Syntax}

{p 8 15 2}
{cmd:test_package} {cmd:using} {it:{help filename}} [{cmd:,} OUTputdir("{it:{help filename}}")]

{col 5}Option{col 24}Description
{space 4}{hline}
{col 5}OUTputdir{col 24}directory path where to store the test report, if needed.
{space 4}{hline}

{title:Description}

{pstd}
{cmd:test_package} executes the suite of test cases of the directory passed to {cmd:using}. 
Each test case must be named {it:test-*.do} where the asterisk is a test case name or number.
Test cases can use ancillary files - it is recommended to organise those into subdirectories, 
for instance using consistent names such as {it:TC-*}.
{p_end}

{pstd}
It the option {it:OUTputdir()} is provided, {cmd:test_package} saves a log 
of the test execution as {it:test_report_YYYYMMDDHHMMSS.log} and a table {it:test_report_YYYYMMDDHHMMSS.csv}
summarising the number of assertions passed and failed for each test case.
{p_end}