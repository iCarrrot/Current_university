--z1
newtype Graph a = Graph (a -> [a], [a])

--z


hamCycle (Graph (f,x:xs))=
	

function x acc f list head =

	(/x-> if )




usun [] []=[]
usun [] ys =ys
usun xs [] = []
usun x:xs ys=
	 let remove _ []      = []
      remove el (x:xs) = if x == el then xs else x:remove el xs
      in usn xs (remove x ys)