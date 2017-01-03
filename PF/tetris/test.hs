--test :: [((Int,Int),(Int,Int,Int))]->[(Int,Int,Int,Int,Int)]
test [] = []


test (a:as) = a : (test as)
