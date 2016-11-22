let rec rev_app (l1 : 'a list) (l2 : 'a list) : 'a list =
    match l1 with
    | []     -> l2
    | e::l1' -> rev_app l1' (e::l2)


let int2bool (i : int) : bool = 
    i <> 0


let bool2int (b : bool) : int =
    if b then 1 else 0


let rec bin_length (i : int) : int =
    if i = 0 || abs i = 1 then 1
                          else bin_length (i / 2) + 1

type nat = bool list


(*z1*)


let nless_eq2 (n1 : nat) (n2 : nat) : bool =
    let main_rule b1 b2 = 
        match b1, b2 with
        | true, false -> false
        | _,     _    -> true
    in 
    let rec aux n1 n2 a =
        match n1, n2 with
        | b1::n1', b2::n2' -> 
              aux n1' n2' (if b1 = b2 then a else main_rule b1 b2)
        | [],      []      -> a
        | [],      _       -> true
        | _,       []      -> false
    in
        aux n1 n2 true

let nsub (n1 : nat) (n2 : nat) : nat =
    let bit_sub b1 b2 c =
        let c' = (not b1 && b2)||(not b1 && c)||(b1&&c&&b2)in
        let b' = (not c&&(b1||b2)&& not(b1&&b2))||((not c &&c'))||(c &&(b1&&b2||not b1&& not b2) ) in
            (b', c')
    in
    let rec aux n1 n2 c a =
        match n1, n2 with
        | b1::n1', b2::n2' -> let (b', c') = bit_sub b1 b2 c in
                              aux n1' n2' c' (b'::a)
        | [],      _::_    -> [false]
        | _::_,    []      -> if c then aux n1 [false] c a
                                   else rev_app a n1
        | [],      []      ->  (if c then [false] else rev_app a [] )
    in
        aux n1 n2 false []  
    ;;

nsub [false; false; true] [false;true] ;;