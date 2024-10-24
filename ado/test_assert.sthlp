{smcl}
{cmd:help test_assert} 
{hline}

{title:test_assert}


{title:Syntax}

{p 8 15 2}
{cmd:test_assert} {it:{help exp}} {it:[{help if}]} {it:[{help in}]} [{cmd:,} message("{it:string}")]

{col 5}Option{col 24}Description
{space 4}{hline}
{col 5}message{col 24}A message to print in the test report, if needed.
{space 4}{hline}

{title:Description}

{pstd}
Must be used in a {it:test-*.do} test case file after instantiating the test case with {it:.testcase}.
{cmd:test_assert} tests the assert provided in {it:exp} (subsetting with {it:if} and {it:in} if provided) 
and either passes or fails a unit test for the current test case. 
{p_end}

{marker examples}{...}
{title:Example:}

{pstd}* First, instantiate a test case{p_end}

{phang}.thistest = .testcase.new, id("27") name("Test addition capability")

{pstd}* Then, test some assertions{p_end}

{phang}test_assert 1+1 == 2, message("Correctly added 1 to 1")
 
