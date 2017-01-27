{--Haskell Notes:
--Functional language
Everything is immutable-}
--comments

{--in cmd prompt, E: to switch drives
"ghci" to run compiler
":l filename" to load file, without extension
:r to reload/run file
":t function" to read the type
:q to quit out of GHCi
ghc --make programname

"let num7 = 7
let getTriple x = x * 3
getTriple num7"
returns 21. No quotes
--}

{-- Errors
Not in scope : 'function' == Can't find 'function'
-}

-- import Data.List
-- import System.IO

--Int -2^63 to 2^63
-- minInt = minBound :: Int

--Integer Unbounded whole number (as much as your memory can hold)
--Float, Double (up to 11 points)
--Bool (True False)
--Char ('s')
--Tuple (two values only)

--Always prints 5
-- always5 :: Int
-- always5 = 5

-- sumOfNums = sum [1..1000]
-- addEx = 5 + 4
-- subEx = 5 - 4
-- multEx = 5 * 4
-- divEx = 5 / 4

--5 mod 4 in 2 different functions: (modEx2 is using ` above tab, not quote)
-- modEx = mod 5 4
-- modEx2 = 5 `mod` 4
--modEx uses mod, which is a prefix operator. modEx2 uses `mod` which is an infix operator

--when adding a negative number, must be in parenthesis
-- negNumEx = 5 + (-4)

--converting Int to Float
-- num9 = 9 :: Int
-- sqrtOf9 = sqrt (fromIntegral num9)

{-- Built in Math functions
piVal = pi
ePow9 = exp 9
logOf9 = log 9
squared9 = 9 ** 2

--produces 9
truncateVal = truncate 9.999

roundVal = round 9.999
ceilingVal = ceiling 9.999
floorVal = floor 9.999

Also, (sin, cos, tan, asin, atan, acos, sinh, tanh, cosh, asinh, atanh, acosh)

trueAndFalse = True && False
trueOrFalse = True || False
notTrue = not(True)
-}

--to create a list
-- primeNumbers = [3,5,7,11]

--to concatenate lists
-- morePrimes = primeNumbers ++ [13,17]

--how to add numbers into a list
-- favNums = 2 : 7 : 21 : 66 : []

--to create a list of lists
-- multList = [[3,5,7],[11,13,17]]

--to add to say, front and back of the list respectively
-- morePrimes2 = 2 : morePrimes
-- morePrimes3 = morePrimes : 2

--to get length of a list
-- lenPrime = length morePrimes

--reverse list
-- revPrime = reverse morePrimes

--check if list is empty
-- isListEmpty = null morePrimes

--returning second item in list ("!! #" represents spot, with list starting at 0)
-- secondPrime = morePrimes2 !! 1

--returning first and last items in list
-- firstPrime = head morePrimes
-- lastPrime = last morePrimes

--return all but last item in list
-- primeInit = init morePrimes

--get first # of items from list
-- first3Primes = take 3 morePrimes

--returns all but the first # of items from list
-- removedPrimes = drop 3 morePrimes

--checks if # is in list
-- is7InList = 7 `elem` morePrimes

--max and min values of list
-- maxPrime = maximum morePrimes
-- minPrime = minimum morePrimes

--multiply everything in list together
-- newList = [2,3,5]
-- prodPrimes = product NewList

--generate list 0 to 10
-- zeroToTen = [0..10]

--generate list of even numbers from 2 to 20
-- evenList = [2,4..20]

--same for letters
-- upperLetters = ['A'..'Z']
-- otherLetters = ['A','C'..'Z']

--you can create an "infinite" list
--lazy, will only create what is asked for. If you need 50, it'll produce 50, but won't produce anymore unless asked to
-- infinite10s = [10,20..]

--creates a list of 10 2's ([2,2,2,2,2,2,2,2,2,2]) 2 different ways
-- many2s = take 10 (repeat 2)
-- many2s2 = replicate 10 2

--repeats list until it creates 10. E.G. outputs [1,2,3,4,5,1,2,3,4,5]
-- cycleList = take 10 (cycle [1,2,3,4,5])

--takes list of 1-10, stores in x, multiples everything by 2
-- listTimes2 = [x * 2 | x <- [1..10]]

--multiply everything in list by 3 but only return results lower than 50
-- listTimes3 = [x * 3 | x <- [1..10], x * 3 <= 50]

--go through list 1-500, return items divisible by both 13 and 9
-- divisBy9And13 = [x | x <- [1..500], x `mod` 13 == 0, x `mod` 9 == 0]

--sort list
-- sortedList = sort [9,1,8,3,4,7,6]

--add two lists values together (i.e. this line will return sumOfLists = [7,9,11,13,15])
-- sumOfLists = zipWith (+) [1,2,3,4,5] [6,7,8,9,10]

--filter out numbers smaller than/equal to 5 from list
-- listBiggerThan5 = filter (>5) morePrimes

--generate list of even numbers up to, including, 20
-- evensUpTo20 = takeWhile (<= 20) [2,4..]

--fold from left to right and multiply all together (i.e. returns 120 (2*3*4*5))
-- multOfList = foldl (*) 1 [2,3,4,5]
--also foldr to go right to left

--create a list of 3^n where n = 1 to 10. I.E. pow3List = [3,9,27,81,243,729,2187,6561,19683,59049]
-- pow3List = [3^n | n <- [1..10]]

--creates a list of lists holding multiple of first number. I.E. first list = 1-10, second = 2-20 multiples of 2, third = 3-30 multiples of 3
-- multTable = [[x * y | y <- [1..10] | x <- [1..10]]


--tuples need not have 2 of same types. i.e. Integer and String
-- randTuple = (1, "Random Tuple")

--to get first item in tuple
-- bobSmith = ("Bob Smith",52)
-- bobsName = fst bobSmith
--to get second item
-- bobsAge = snd bobSmith

--combine 2 lists to create list of tuples: [("Bob",50),("Mary",45),("Tom",43)]
-- names = ["Bob", "Mary", "Tom"]
-- ages = [50,45,43]
-- namesNAges = zip names ages

--print "What's your name", set variable name as their input, print "Hello name"
-- main = do
	-- putStrLn "What's your name"
	-- name <- getLine
	-- putStrLn ("Hello " ++ name)

--create type declaration/function (funcName param1 param2.. = operations (returned value))
--function names cannot begin with captial letters
--this one takes 2 Ints and returns an Int
--taking 2 ints x and y, return operation (x + y)'s result
-- addMe :: Int -> Int -> Int
-- addMe x y = x + y

--no type declaration still works. Now you can use floats or ints or w/e.
-- sumMe x y = x + y

--adding tuples
-- addTuples :: (Int, Int) -> (Int, Int) -> (Int, Int)
-- addTuples (x, y) (x2, y2) = (x + x2, y + y2)

--return specific results and finally, for anything else, return a set message
-- whatAge :: Int -> String
-- whatAge 16 = "You can drive"
-- whatAge 18 = "You can vote"
-- whatAge 21 = "You're an adult"
-- whatAge x = "Nothing Important"

--recursion as factorial
-- factorial :: Int -> Int
-- factorial 0 = 1
-- factorial n = n * factorial (n - 1)

--simple way to do factorial
-- prodFact n = product [1..n]

--guards are used to create different actions based on different conditions
--Much like if's, first if n is even, return false. Otherwise return 0.
-- isOdd :: Int -> Bool
-- isOdd n
	-- | n `mod` 2 == 0 = False
	-- | otherwise = True

-- whatGrade :: Int -> String
-- whatGrade age
	-- | (age >= 5) && (age <= 6) = "Kindergarten"
	-- | (age > 6) && (age <= 12) = "Elementary School"
	-- | (age > 12) && (age <= 15) = "Middle School"
	-- | (age > 15) && (age <= 18) = "High School"
	-- | otherwise = "Go to college"
	
--essentially, calculating avg last but for multiple guards	
-- batAvgRating :: Double -> Double -> String
-- batAvgRating hits atBats
	-- | avg <= 0.200 = "Terrible Batting Average"
	-- | avg <= 0.250 = "Average Player"
	-- | otherwise = "You're a Superstar"
	-- where avg = hits / atBats

--Accessing list items
-- getListItems :: [Int] -> String
-- getListItems [] = "Your list is empty"
-- getListItems (x:[]) = "Your list starts with " ++ show x --show x is used to print x on screen
-- getListItems (x:y:[]) = "Your list contains " ++ show x " and " ++ show y
-- getListItems (x:xs) = "The 1st item is " ++ show x " and the rest are " ++ show xs

--Essentially, print everything, or all, then print the first letter
-- getFirstItem :: String -> String
-- getFirstItem [] = "Empty String"
-- getFirstItem all@(x:xs) = "The first letter in " ++ all ++ " is " ++ [x]



--HIGHER ORDER FUNCTIONS
-- times4 :: Int -> Int
-- times4 x = x * 4

--map is used to apply a function to everything within a list
-- listTimes4 = map times4 [1,2,3,4,5]

--doing the map function above manually
-- multBy4 :: [Int] -> [Int]
-- multBy4 [] = []
-- multBy4 (x:xs) = times4 x : multBy4 xs

--Checking string equality using recursion
--List of characters = string
--Empty, true. Check first element of both lists with each other. Recursively call function again with remainder lists
--The last line covers all other cases. Not equal and not list items.
-- areStringsEq :: [Char] -> [Char] -> Bool
-- areStringsEq = [] [] = True
-- areStringsEq (x:xs) (y:ys) = x == y && areStringsEq xs ys
-- areStringsEq _ _ = False

--Passing a function into a function. (Assume using times4 above as said function)
--This one for example, needs a function that accepts 1 Int argument and returns an Int.
-- doMult :: (Int -> Int) -> Int
-- doMult func = func 3
-- num3Times4 = doMult times4

--Returning a function
-- getAddFunc :: Int -> (Int -> Int)
-- getAddFunc x y = x + y
-- adds3 = getAddFunc 3
-- fourPlus3 = adds3 4

--same as above with map
-- thressPlusList = map adds3 [1,2,3,4,5]



--lambdas
--this takes a list [1..10] and doubles all values inside it
-- dbl1To10 = map (\x -> x * 2) [1..10]

--Comparisons: <, >, <=, >=, ==, /= (which is !=)
--Boolean operators: &&, ||, not

--using if's in Haskell. MUST have an else with every if.
-- doubleEvenNumber y = 
	-- if (y `mod` 2 \= 0)
		-- then y
	-- else y * 2

--case statements
--last case with wildcard _ catches all other cases.
-- getClass :: Int -> String
-- getClass n = case n of
	-- 5 -> "Go to Kindergarten"
	-- 6 -> "Go to elementary school"
	-- _ -> "Go away"

--modules contain a bunch of functions. Loaded using "import"
--To create a module, create new mod file (just another file essentially with all the functions)
--SampFunctions would be the file. Inside () are the functions you'd like to access
-- module SampFunctions (getClass, doubleEvenNumbers) where
-- import SampFunctions

--Numeration types. Used to find a list of possible types
-- data BaseballPlayer = Pitcher | Catcher | Infielder | Outfielder deriving Show
--Or you case space it out like
-- data BaseballPlayer = Pitcher
					-- | Catcher
					-- | Infielder
					-- | Outfielder
					-- deriving Show
					
-- barryBonds :: BaseballPlayer -> Bool
-- barryBonds Outfielder = True

-- barryInOF = print(barryBonds Outfielder)

--Custom data types
--This creates a Customer with name, address, and balance
--getBalance is saying, check that they're a customer, and return balance. _ _ represent that we don't care what's there.
-- data Customer = Customer String String Double
	-- deriving Show
	
-- tomSmith :: Customer
-- tomSmith = Customer "Tom Smith" "123 Main" 20.50

-- getBalance :: Customer -> Double
-- getBalance (Customer _ _ b) = b

--Another example
-- data RPS = Rock
		-- | Paper
		-- | Scissors
		
-- shoot :: RPS -> RPS -> String
-- shoot Paper Rock = "Paper beats Rock"
-- shoot Paper Scissors = "Scissors beats Paper"
-- shoot Rock Scissors = "Rock beats Scissors"
-- shoot Rock Paper = "Paper beats Rock"
-- shoot Scissors Paper = "Scissors beats Paper"
-- shoot Scissors Rock = "Rock beats Scissors"
-- shoot _ _ = "Error"

--Another example of a custom type. Also, in Rectangle, you can see you can substitute "$" for (). Whatever comes after $ takes precedence to stuff before $.
-- data Shape = Circle Float Float Float
			-- | Rectangle Float Float
			-- deriving Show

-- area :: Shape -> Float
-- area (Circle _ _ r) = pi * r ^ 2
-- area (Rectangle x y x2 y2) = (abs $ x2 - x) * (abs $ y2 - y)
-- Equivalent to
-- area (Rectangle x y x2 y2) = (abs (x2 - x)) * (abs (y2 - y))

--using . operator. Used to chain functions to pass output of right side as input for leftside.
--both sumValue and sumValue2 do the same thing
-- sumValue = putStrLn (show (1+2))
-- sumValue2 = putStrLn . show $ 1 + 2



--Type classes (Num Eq Or Show)
--Employee posses name, position, idNum of types String, String, and Int respectively.
--with "deriving (Eq, Show)", you can show Employees as strings, and check them for equality
-- data Employee = Employee { name :: String,
							-- position :: String,
							-- idNum :: Int
							-- } deriving (Eq, Show)

-- samSmith = Employee {name = "Sam Smith", position = "Manager", idNum = 1000}
-- pamMarx = Employee {name = "Pam Marx", position = "Sales", idNum = 1001}

--compare sam and pam
-- isSamPam = samSmith == pamMarx

--this is used to print samSmith's data, because we declared "Show" earlier in Employee
-- samSmithData = show samSmith

--Another example with overriding Eq and Show for this datatype
-- data ShirtSize = S | M | L

--This is how we want Shirtsizes to be compared, overriding with Eq would've done before naturally
-- instance Eq ShirtSize where
	-- S == S = True
	-- M == M = True
	-- L == L = True
	-- _ == _ = False
	
--This is how we want things to print. If asked to print S, M, or L, we'll print their meanings instead of just the letters
-- instance Show ShirtSize where
	-- show S = "Small"
	-- show M = "Medium"
	-- show L = "Large"

--check if small is available, i.e. is S and element of shirt sizes
-- smallAvail = S `elem` [S, M, L]

--check if asking to print S actually prints "Small" like we overrode it to, or not.
-- theSize = show S


--defining custom type classes
-- class MyEq a where
	-- areEqual :: a -> a -> Bool
	
-- instance MyEq ShirtSize where
	-- areEqual S S = True
	-- areEqual M M = True
	-- areEqual L L = True
	-- areEqual _ _ = False
	
-- newSize = areEqual M M



--Input and Output
--This will print "What's your name" and set name = whatever is inputted.
-- sayHello = do
	-- putStrLn "What's your name"
	-- name <- getLine
	-- putStrLn $ "Hello " ++ name

--File I/O
--theFile holds file now. WriteMode makes it Write only, no reading
--to put text into the file, use hPutStrLn
--then close the file
-- writeToFile = do
	-- theFile <- openFile "fileToOpen.txt" WriteMode
	-- hPutStrLn theFile ("Random line of text")
	-- hClose theFile

-- readFromFile = do
	-- theFile2 <- openFile "fileToOpen.txt" ReadMode
	-- content <- hGetContents theFile2
	-- putStr contents
	-- hClose theFile2


--this prints the fib sequence, 1, 1, 2, 3, 5, 8, etc.
fib = 1 : 1 : [a + b | (a, b) <- zip fib (tail fib)]
--starts off by creating list of [1,1]
--(a, b) <- zip fib (tail fib) sets a = fib and b = (tail fib). Then a + b.

--this returns the 300th fib number
fib300 = fib !! 300




















































