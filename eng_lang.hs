-- 1) We are assuing the words are separated by white spaces like in English.
-- 2) Also assuming that any word that starts with a capital letter and doesn't belongs to
-- any of the categories below ,i.e verb , adverb , preposition , conjuction,
-- adjective , pronoun , article is a Noun
-- 3) Anything other than the following classifications , a Noun, a full stop and a comma is an error.
-- , and . may or maynot be preceded or succeded by one or multiple spaces.


import Data.Char 
import Data.List.Split
import System.Environment

verb        = words "is am are was were do does be being been will would can could shall should has have had"
adverb      = words "very simply quietly gently calmly angrily"
preposition = words " to from behind below between above"
conjuction  = words "if then and but or"
adjective   = words "their my your his her its good bad happy sad"
pronoun     = words "he she I we it they"
article     = words "a an the"

data Token =  Verb String
            | Adverb String
            | Preposition String
            | Conjuction String
            | Adjective String
            | Pronoun String
            | Noun String
            | Article String
            | FStop 
            | Comma
            deriving (Eq,Show)

-- lexer function takes a string and returns a Token list.
lexer :: String ->[Token] 
lexer str = lexer' inps 
              where  
                alllines = lines str 
                                  -- lines takes a string and converts 
                                  -- it into a list of lines based on
                                  -- separation by '\n'
                strs = concat $ map words alllines
                                  -- words takes a string and converts 
                                  -- it into a list of words based on 
                                  -- separation by spaces  
                inps = stringtoStrings strs -- some other magic


stringtoStrings ::  [String] -> [String]
stringtoStrings [] = []
stringtoStrings (x:xs) = case elem ',' x of
    True  -> (split (dropBlanks $ oneOf ",") x ) ++ stringtoStrings xs   
    False -> case elem '.' x of 
        True  -> (split (dropBlanks $ oneOf ".") x ) ++ stringtoStrings xs
        False ->  x: stringtoStrings xs




lexer' :: [String] -> [Token]
lexer' [] = []
lexer' (x:xs) 
    | x == "I"                      = (Pronoun     x) : lexer' xs 
    | elem (toLower' x) pronoun     = (Pronoun     x) : lexer' xs 
    | elem (toLower' x) verb        = (Verb        x) : lexer' xs 
    | elem (toLower' x) adverb      = (Adverb      x) : lexer' xs 
    | elem (toLower' x) preposition = (Preposition x) : lexer' xs 
    | elem (toLower' x) conjuction  = (Conjuction  x) : lexer' xs 
    | elem (toLower' x) adjective   = (Adjective   x) : lexer' xs 
    | elem (toLower' x) article     = (Article     x) : lexer' xs  
    | x == "."                      = FStop           : lexer' xs 
    | x == ","                      = Comma           : lexer' xs 
    | last x == '.'                 = lexer' (init x:".":xs)
    | isUpper(head x)               = (Noun x) : lexer' xs 
    | otherwise                     = error "\n****************Error: Got a non Token. :(\n"
    where 
        -- toLower' is a function which converts takes  a string and 
        -- if the first character of the string is a capital letter then it changes 
        -- it to lower case (rest is unchanged) otherwise returns the
        -- original string.
        toLower' :: String -> String
        toLower' str@(x:xs) = case isLower x of
            True  -> str 
            False -> (toLower x): xs  


main = do 
    args <- getArgs
    case length args == 0 of
        True  -> do 
               let usage = "\nExpecting of the form < ./eng_lang inputfile > got < ./eng_lang >.\n\nTry again. :(\n"
               error $ "\n****************Error: Expecting file name as an argument." ++ usage
        False -> do
            let fname  = args !! 0 
            conts <- readFile fname
            let tokens = lexer conts 
            putStrLn "\n**************************************\n"
            putStrLn "The List of tokens are as follows.\n"
            mapM_ (putStrLn.show) tokens
             

