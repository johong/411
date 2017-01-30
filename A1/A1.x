{
module Main (main) where
import System.Environment
}

%wrapper "basic"

--Macros to use in token definitions
--Defining numbers, characters, and newline
$digit = 0-9
$alpha = [a-zA-Z]
$newline = [\n]

--ends macro definitions, starts scanner definitions
--regularexpression {code}
--if input matches regexp, return code
--; simply replaces code, meaning this token should be ignored
--Simple tokens.
tokens :-

	$white+							;
	"%".* $newline*					;
	$newline						;
	"/*" (.* $newline)+ (.* "*/")	;
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
		SEMICOLON
		deriving (Eq,Show)
		
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