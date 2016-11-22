(*z4*)
let reverse x_list =
	let rec rev_acc acc x_list = 
	match x_list with
	| x::xs -> rev_acc (x::acc) xs
	| [] -> acc

in 
rev_acc [] x_list




(*z1*)
let rec unfoldr (f : ('a -> ('a * 'b) option)) (a : 'a) : 'b list =
  match aux a with
    | Some(a2, b) -> b :: unfoldr f a2
    | None        -> []



(*z2*)
let scanl (f:'a->'b->'a) (a:'a) (b_list:'b list) : 'a list =
	let rec aux f b_list (a::acc) =
		match b_list with
			|b::bs -> aux f bs ((f a b)::a::acc) 
			|[]->reverse (a::acc) 
	in
	aux f b_list (a::[])



(*z4*)
let reverse x_list= List.fold_left (fun xs x -> x::xs ) [] x_list

(*z5*)
let rec map (f:'a->'b) (x_list:'a list) : 'b list=
	match x_list with
		| x::xs -> (f x)::(map f xs)
		| [] -> []


let map (f:'a->'b) (x_list:'a list) : 'b list = List.fold_right (fun x xs -> (f x)::xs ) x_list []
(*z6*)

let rec all (f: 'a -> bool) (a_list: 'a list) : bool =
	match a_list with
		|x::xs->(f x)&&(all f xs)
		|[]-> true
		
let all (f: 'a -> bool) (a_list: 'a list) : bool = List.fold_right (fun a b -> (f a)&&b) xs true 

(*  z7+a) *)

let rec any (f: 'a -> bool) (a_list: 'a list) : bool =
	match a_list with
		|x::xs->if f x then true else any f xs
		|[]-> false 


exception Znaleziono

let any (f: 'a -> bool) (a_list: 'a list) : bool =
	try 
		List.fold_left (fun a b -> if b then raise Znaleziono else b) false bs
  	with Znaleziono -> true 

(*z8*)
type aritm_literal = Neg | Add | Sub | Mul | Div | Pow | Num of float

(*z9*)

exception IllegalOperation of (aritm_literal* float	* float)
exception TooFewOperations
exception TooMuchOperations

let eval_rpm (a_list:aritm_literal list) : float=
	let bin_bin_operations operator arg1 arg2 : float=
		match operator with 
			| Add -> arg1+.arg2
			| Sub -> arg1-.arg2
			| Mul ->arg1*.arg2
			| Div ->if arg2=0.0 then raise (IllegalOperation(operator,arg1,arg2)) else arg1/.arg2
			| Pow -> if(classify_float( arg1**arg2)=FP_nan) then raise (IllegalOperation(operator,arg1,arg2)) else arg1**arg2
			| _ -> raise (IllegalOperation(operator,arg1,arg2))
	in
		let rec aux (a_list:aritm_literal list) acc =
			match a_list,acc with
			| Num x ::xs, ys-> aux xs (x::ys)
			| Neg::xs,y::ys -> aux xs ((-1.0*.y)::ys)
			| x::xs,y1::y2::ys -> aux xs ((bin_operations x y2 y1)::ys) 
			| x::xs,_ ->raise TooMuchOperations
			| [],y::ys -> if ys=[] then y else raise TooFewOperations
			|[],[] -> raise TooMuchOperations
		in
			aux a_list []

