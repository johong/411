There are 2 alex files. A1.x and A1Attempt.x
A1.x is what you should run the tests with by using the commands:

alex A1.x
ghci
:l A1
:main testfilename.txt

There is a lexical error printed when an unknown symbol is read.
When looking for multiline comments, when encountering "/*", it will look for the very last "*/" that exists in the file. So when there are two sets of multiline comments with actual code between them, the code between them will be ignored as well unfortunately.
As it should, this code will read extra closing multiline comments as a simple DIV MUL.
Also, this does not account for nesting multiline comments. So if you are to open 3 multiline comments within each other, then close just once, all three will become closed.

There was an attempt at creating a function using monads in A1Attempt.x but unfortunately, it won't compile/work. Just throwing it out there just in case.