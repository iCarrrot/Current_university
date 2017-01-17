makeTable' :: GLfloat -> GLfloat -> GLfloat-> GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable' 0 colm rows' x =if colm>1 then [((rows'/10 -0.55,(colm-1)/10 - 1.05),(0,0,0))]++(makeTable' (rows'-1) (colm-1) rows' x) else []
makeTable' rows colm rows' x = if colm>0 then [((rows/10 -0.55,colm/10 - 1.05),(0,0,0))]++(makeTable' (rows-1) colm rows' (x+1)) else []



dcheck :: (Double,Double,Double,Double,Double,Double) -> [((Double,Double),(Double,Double,Double))]->Double->Double
dcheck (_,_,_,_,_,_) [] size = (-1)
dcheck (x,y,z,r,g,b) (((x1,y1),(r1,g1,b1)):table) size
  |dabs (x-x1) < size && dabs (y-y1) < size && r1+g1+b1>0 && r1+g1+b1<3 = 1 
  |dabs (x-x1) < size && dabs (y-y1) < size && (r1+g1+b1==0 || r1+g1+b1==3 ) = 0 
  |otherwise = dcheck (x,y,z,r,g,b) table size


dcheckerY :: [(Double,Double,Double,Double,Double,Double)]->[((Double,Double),(Double,Double,Double))]->Double ->Double
dcheckerY [] table size= 0
dcheckerY ((x,y,z,r,g,b):list) table size
  |dcheck (x,y-size,z,r,g,b) table size == 1 =1
  |dcheck (x,y-size,z,r,g,b) table size == (-1) =(-1)
  |otherwise = dcheckerY list table size


dcheckerX :: [(Double,Double,Double,Double,Double,Double)]->[((Double,Double),(Double,Double,Double))]->Double->Double->Double
dcheckerX [] table _ _= 0
dcheckerX ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table) mult size
  |dcheck (x+mult*size,y,z,r,g,b) table size == 1 =1
  |check (x+mult*size,y,z,r,g,b) table size == (-1) =(-1)
  |otherwise = dcheckerX list table  mult size


  
dabs :: Double->Double
dabs x 
  |x<0 =(-x)
  |otherwise = x