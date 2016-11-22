(*z1*)
type 'a flbt = int -> 'a

(*wersja a*)

(*z2*)
 let rec treeAB : char flbt = fun n -> if n<1 then raise Not_found else match n with
 	  3->'b'
 	| 2->'a'
 	| 1->'a'
 	| _->treeAB(n/2) 



(*z3*)
let pos_root=1
let rec pow1 = fun n -> match n with
	1->1
	| _->2*pow1 (n/2)

let rec pow2 = fun n -> match n with
	1->2
	| _->(2 * (pow2 (n/2)))


let pos_right_child = fun n -> n+(pow2 n)
let pos_left_child = fun n -> n+(pow1 n)

(*z4*)


let get t n = t(n)
let falser _ = false 
let is_empty t = try falser(t pos_root) with _ -> true


(*z5*)
let empty (n:int) =   raise Not_found
let join s t v= 
	fun n->if n=1 then v else match n mod 2 with
	|0-> s(n/2)
	|1-> t(n/2)
	|_->raise Not_found

let left_subtree t= fun n -> t(n*2)
let right_subtree t= fun n -> t(n*2+1)

(*z6*)
let max x y = if (x>y) then x else y
let rec depth t = if (is_empty t) 
	then 0 
	else 1+(max (depth(left_subtree t)) (depth(right_subtree t)))


(*z7*)
let rec memorize2 t n= 
	if (is_empty t) 
	then empty 
	else let x= (t n) 
		in 
		(join  
			(memorize2 (left_subtree t) (pos_root)) 
			(memorize2 (right_subtree t) (pos_root)) 
			x
		)
let memorize t=memorize2 t pos_root;;

(*z8*)

let subtree (t:(int->'a))= fun n -> if  (n mod 2 = 0) 
then ( left_subtree t) 
else (right_subtree t )

let rec loop2 t = fun n -> 
  try t n with _ -> (if is_empty (subtree t n) 
  	then (loop2 t) (n/2)
  	else (loop2 (subtree t n)) (n/2))


let loop t = loop2 t

 ;;