
{
module Main (main) where
import System.Environment
import Data.Char (chr)
}

%wrapper "monad"

$digit   = 0-9            -- digits
$alpha   = [a-zA-Z]       -- alphabetic characters
$newline = [\n]
@symbols = [\=\+\-\*\/\(\)] 

tokens :-
  "{-"                            {\a l -> nested_comment a l}
  $white+                         ;
  "--".* $newline+                ;
  $newline                        ;
  "{-"                            ;
  let                   { \a l -> return $ Let ((fst.getstrPosn a) l)}
  
  in                    { \a l -> return $ In ((fst.getstrPosn a) l)}
  
  $digit+               { \a l -> do
                              let (posn,str) = getstrPosn a l 
                              return $ Int (read str) posn
                        }

  @symbols              { \a l -> do 
                              let
                                (posn,str) = getstrPosn a l
                              return $ Sym str posn a  
                        }

  $alpha [$alpha $digit \_ \']* 
                        { \a l -> do 
                              let
                                (posn,str) = getstrPosn a l
                              return $ Sym str posn a   
                        }


{
-- The token type:
data Token =  Let AlexPosn 
            | In  AlexPosn
            | Sym String AlexPosn AlexInput   
            | Var String AlexPosn 
            | Int Int AlexPosn
            | LEOF
            deriving (Eq,Show)


-- runAlex :: String -> Alex a -> Either String a

scanner :: String -> Either String [Token]
scanner str = runAlex str (loop [])

loop :: [Token] -> Alex [Token]
loop tlist = do
           tok <- alexMonadScan 
           if tok == LEOF
                  then 
                     return tlist
                  else do 
                     loop (tlist ++ [tok])

nested_comment :: AlexInput -> Int -> Alex Token
nested_comment ainp l = do
       input <- alexGetInput
       undefined
       -- writen a function now that changes and maintains the counter
       -- based on whether it has seen a starting multiline comment or
       -- closing multiline comment from the "input"


alexEOF = return LEOF 

getstrPosn :: AlexInput -> Int -> (AlexPosn,String)
getstrPosn (apn,pchar,_,str) len = (apn,take len str) 


main = do
  s <- getArgs
  conts <- readFile (s !! 0)
  case (scanner conts) of  
      Left error -> 
          putStrLn  error
      Right tokList ->
          mapM_ (putStrLn.show) tokList  

}


