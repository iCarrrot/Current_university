let zero = [false]
let one = [true]
let two = [false; true]
let three = [true; true]
(*poprawione zadania z listy 1*)
(*z1.1*)
type 'a flbt = int -> 'a

(*wersja a*)

(*z1.2*)
 let rec treeAB : char flbt = fun n -> if nless n one then raise Not_found else match n with
 	  [true;true]->'b'
 	| [false;true]->'a'
 	| [true]->'a'
 	| _->treeAB(ndiv2 n) 



(*z1.3*)
let pos_root=one
let rec pow1 = fun n -> match n with
	|[true]->one
	| _->nmul2 (pow1 (ndiv2 n))

let rec pow2 = fun n -> match n with
	[true]->two
	| _->nmul2 (pow2 (ndiv2 n))


let pos_right_child = fun n -> nadd n (pow2 n)
let pos_left_child = fun n -> nadd n (pow1 n)

(*z1.4*)


let get t n = t(n)
let falser _ = false 
let is_empty t = try falser(t pos_root) with _ -> true


(*z1.5*)
let empty (n:int) =   raise Not_found
let join s t v= 
	fun n->if n=one then v else match nmod2 n with
	|[false]-> s(ndiv2 n)
	|[true]-> t(ndiv2 n)
	|_->raise Not_found

let left_subtree t= fun n -> t(nmul2 n)
let right_subtree t= fun n -> t(nadd (nmul2 n) one)

(*z1.6*)
let max x y = if (nless y x) then x else y
let rec depth t = if (is_empty t) 
	then zero 
	else nadd one (max (depth(left_subtree t)) (depth(right_subtree t)))


(*z1.7*)
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

(*z1.8*)

let subtree (t:(int->'a))= fun n -> if  (nmod2 n = [false]) 
then ( left_subtree t) 
else (right_subtree t )

let rec loop2 t = fun n -> 
  try t n with _ -> (if is_empty (subtree t n) 
  	then (loop2 t) (ndiv2 n)
  	else (loop2 (subtree t n)) (ndiv2 n))


let loop t = loop2 t

 ;;
 (*pół zadania nr 4*)

 let sum_nt t = if (is_empty t) then 0 else 
 	match is_empty (left_subtree t), is_empty (right_subtree t) with
 	|true,true -> t(pos_root)+sum_(left_subtree)+sum_(right_subtree)
 	|true, false-> t(pos_root)+sum_(right_subtree)
 	|false, true-> t(pos_root)+sum_(left_subtree)
 	|false, false-> t(pos_root);;
