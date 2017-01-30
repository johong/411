{
module Main (main) where
import System.Environment
}

%wrapper "monad"

--Macros to use in token definitions
--Defining numbers, characters, and newline
$digit = 0-9
$alpha = [a-zA-Z]
$newline = [\n]


--ends macro definitions, starts scanner definitions
--regularexpression {code}
--if input matches regexp, return code
--; simply replaces code, meaning this token should be ignored
tokens :-

	$white+							;
	"%".* $newline+					;
	$newline						;
	"/*"							{ \a l -> ncom a l}
	if								{ \s -> IF }
	then							{ \s -> THEN }
	while							{ \s -> WHILE }
	do								{ \s -> DO }
	input							{ \s -> INPUT }
	else							{ \s -> ELSE }
	begin							{ \s -> BEGIN }
	end								{ \s -> END }
	write							{ \s -> WRITE }
	$alpha [$digit $alpha]*			{ \s -> ID s }
	[$digit]+						{ \s -> NUM (read s) }
	"+"								{ \s -> ADD }
	":="							{ \s -> ASSIGN }
	"-"								{ \s -> SUB }
	"*"								{ \s -> MUL }
	"/"								{ \s -> DIV }
	"("								{ \s -> LPAR }
	")"								{ \s -> RPAR }
	";"								{ \s -> SEMICOLON }
	
	
	
	

--Declaring the types of the tokens
--Also creates a main function to use for testing tokens
--main simply tokenises input and prints results as standard output
--"alexScanTokens :: String -> [Token]" provided by Alex to invoke scanner
{
data Token =
		IF			|
		THEN		|
		WHILE		|
		DO			|
		INPUT		|
		ELSE		|
		BEGIN		|
		END			|
		WRITE		|
		ID	String	|
		NUM	Int		|
		ADD			|
		ASSIGN		|
		SUB			|
		MUL			|
		DIV			|
		LPAR		|
		RPAR		|
		SEMICOLON	|
		LEOF
		deriving (Eq,Show)
		
		
		
--AlexInput :: (AlexPosn -> Char -> [Byte] -> String)
--AlexPosn has 3 ints, character offset, line/row, column

--Gets the input, passes it on to ncom_helper with 1
--to increment multiline comment counter
ncom :: AlexInput -> Int -> Alex Token
ncom ainp l = do
	input <- alexGetInput
	ncom_helper 1 input

	
--Supposed to take the input and parse character by
--character, searching for "/*" or "*/", recursively
--incrementing/decrementing the counter.
ncom_helper :: Int -> AlexInput -> Alex Token
ncom_helper count (c,input) =
	case count >
	
		
alexEOF = return LEOF


--Most parts of this main argument was borrowed from Prashant Kumar
main = do
	args <- getArgs
	case length args == 0 of
		True -> do
			let usage = "\nExpecting of the form < ./Main inputfile > got < ./Main >.\n\nTry again. :(\n"
			error $ "\nERROR: Expecting file name as an argument." ++ usage
		False -> do
			let fname = args !! 0
			conts <- readFile fname
			let tokens = alexScanTokens conts
			putStrLn "\n\nTokens:"
			mapM_ (putStrLn.show) tokens
}



















