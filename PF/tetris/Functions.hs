module Functions (stage,check, checker, printBlock, printBlock',printTable,countScore, getInt, deleter, unzipper,updater, checkerY, checkerX, gLabs,moduloGLFloat, randomBlock, blockSize, makeTable) where

import Graphics.Rendering.OpenGL
import Data.IORef
import System.Random
import Points





stage::GLfloat-> [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
stage y = stage' 1 y 
stage'::GLfloat->GLfloat-> [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
stage' x y =
      if x<=10 
        then [(x/10 -0.55,y/10-1.05,0,0,0,0)] ++ (stage' (x+1) y)
        else []

reverseBlock:: GLfloat->GLfloat->GLfloat-> Char
reverseBlock r g b 
  |r+g+b==0 || r+g+b==3 = 'N'
  |r+g+b ==1.5 = 'T'
  |r==0 && g==0 && b==1 ='S'
  |r==0 && g==1 && b==0 ='Z'
  |r==0 && g==1 && b==1 ='O'
  |r==1 && g==0 && b==0 ='I'
  |r==1 && g==0 && b==1 ='J'
  |r==1 && g==1 && b==0 ='L'
  |otherwise = 'n'


printTable:: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->[(GLfloat,GLfloat,Char)]
printTable [] = []
printTable (((x,y),(r,g,b)):table) =
  (x*10 +5.5,y*10+10.5,reverseBlock r g b):printTable table



printBlock :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[(GLfloat,GLfloat,Char)]
printBlock [] = []
printBlock ((x,y,z,r,g,b):rest)=
  (x*10 +5.5,y*10+10.5,reverseBlock r g b):printBlock rest

printBlock' :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[(GLfloat,GLfloat,Char)]
printBlock' [] = []
printBlock' ((x,y,z,r,g,b):rest)=
  (x,y,reverseBlock r g b):printBlock' rest







unzipper :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->[(GLfloat,GLfloat,GLfloat, GLfloat,GLfloat,GLfloat)]
unzipper [] = []
unzipper ( ((x,y),(r,g,b)) :as) = (x,y,0.0::GLfloat,r,g,b) : (unzipper as)


updater :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]-> GLfloat-> (GLfloat,GLfloat)->GLfloat-> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
updater table random (x,y) angle =
  let typ = randomBlock random in
    let list = block typ (x,y) (0.05::GLfloat) angle in 
      updater' list table

updater' :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
updater' [] table = reverse table
--updater' list [] = []
updater' ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table)
  |gLabs (x-x1) < 0.05 && gLabs (y-y1) < 0.05 = (updater' list (table ++ [((x1,y1),(r,g,b))]))
  |otherwise =   updater'  ((x,y,z,r,g,b):list) (table ++ [((x1,y1),(r1,g1,b1))] )

updater'' :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat-> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
updater'' [] y = []
updater'' (((x1,y1),(r1,g1,b1)):table) y
  |gLabs( y1- (y/10 - 1.05)) < 0.04 =  (updater'' table y)++[((x1,0.95),(0,0,0))]
  |y1<y/10 - 1.05 = (updater'' table y)++[((x1,y1),(r1,g1,b1))]
  |y1>y/10 - 1.05 = (updater'' table y)++[((x1,y1-0.1),(r1,g1,b1))]
  |otherwise = (updater'' table y)++[((x1,y1),(0.7,0.1,0.6))]
  




check :: (GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat) -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->GLfloat
check (x,y,n3,n4,n5,n6) [] size  
  |x<0.45||x>0.45 = 0
  |y>0.95 = 0  
  |otherwise =(-1)
check (x,y,n1,n2,n3,n4) (((x1,y1),(r1,g1,b1)):table) size
  |gLabs (x-x1) < 0.04 && gLabs (y-y1) < 0.04 && r1+g1+b1>0 && r1+g1+b1<3 = 1 
  |gLabs (x-x1) < 0.04 && gLabs (y-y1) < 0.04 && (r1+g1+b1<0.4 || r1+g1+b1>2.6 ) = 0 
  
  |otherwise = check (x,y,n1,n2,n3,n4) table size


checkerY :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat ->GLfloat
checkerY [] table size= 0
checkerY ((x,y,z,r,g,b):list) table size
  |check (x,y-size,z,r,g,b) table size == 1 =1
  |check (x,y-size,z,r,g,b) table size == (-1) =(-1)
  |otherwise = checkerY list table size


checkerX :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->GLfloat->GLfloat
checkerX [] table _ _= 0
checkerX ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table) mult size
  |check (x+mult*size,y,z,r,g,b) table size == 1 =1
  |check (x+mult*size,y,z,r,g,b) table size == (-1) =(-1)
  |otherwise = checkerX list table  mult size


checker :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat ->GLfloat
checker [] table size= 1
checker ((x,y,z,r,g,b):list) table size
  |check (x,y,z,r,g,b) table size == 1 =checker list table size
  |check (x,y,z,r,g,b) table size == (-1) =(-1)
  |otherwise = 0

deleter ::[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->([((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))],GLfloat)
deleter table = deleter' 1 table 0

deleter' :: GLfloat->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->([((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))],GLfloat)
deleter' y table score
  |y> 20 =(table,score)
  |otherwise = if checker (stage y) table (0.05::GLfloat) ==1 
      then deleter' (y+1) (updater'' table y) (score+1)
      else deleter' (y+1) table score






gLabs :: GLfloat->GLfloat
gLabs x 
  |x<0 =(-x)
  |otherwise = x

moduloGLFloat :: GLfloat-> GLfloat->GLfloat
moduloGLFloat m1 m2=if m1>=m2 then moduloGLFloat (m1-m2) m2 else m1

randomBlock :: GLfloat -> Char
randomBlock x
  |x<=0.14 = 'I'
  |x<=0.28 = 'T'
  |x<=0.42 = 'O'
  |x<=0.56 = 'L'
  |x<=0.70 = 'J'
  |x<=0.84 = 'S'
  |x<=1 = 'Z'
  |otherwise = 'n'



blockSize :: GLfloat ->GLfloat ->(GLfloat,GLfloat) 
blockSize num 1
  |num<=0.14 =  (2,1) 
  |num<=0.28 = (1,1)  
  |num<=0.42 = (0,1) 
  |num<=0.56 = (1,1) 
  |num<=0.70 = (1,1) 
  |num<=0.84 = (1,1) 
  |num<=1 = (1,1) 
  |otherwise = (0,0) 

blockSize num 2
  |num<=0.14 = (0,0)
  |num<=0.28 = (1,0)
  |num<=0.42 = (0,1) 
  |num<=0.56 = (1,0) 
  |num<=0.70 = (1,0)
  |num<=0.84 = (1,0) 
  |num<=1 = (0,1) 
  |otherwise = (0,0) 

blockSize num 3
  |num<=0.14 = (2,1) 
  |num<=0.28 = (1,1)
  |num<=0.42 = (0,1) 
  |num<=0.56 = (1,1) 
  |num<=0.70 = (1,1)
  |num<=0.84 = (1,1) 
  |num<=1 = (1,1) 
  |otherwise = (0,0) 

blockSize num _
  |num<=0.14 = (0,0)
  |num<=0.28 = (0,1)
  |num<=0.42 = (0,1)
  |num<=0.56 = (0,1)
  |num<=0.70 = (0,1)
  |num<=0.84 = (1,0)
  |num<=1 = (0,1)
  |otherwise = (0,0)


makeTable :: GLfloat ->GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable rows colm = makeTable' rows colm rows 0


makeTable' :: GLfloat -> GLfloat -> GLfloat-> GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable' 0 colm rows' x =if colm>1 then [((rows'/10 -0.55,(colm-1)/10 - 1.05),(0,0,0))]++(makeTable' (rows'-1) (colm-1) rows' x) else []
makeTable' rows colm rows' x = if colm>0 then [((rows/10 -0.55,colm/10 - 1.05),(0,0,0))]++(makeTable' (rows-1) colm rows' (x+1)) else []

getInt::String->String
getInt x = take (length x - 2) x 


countScore :: GLfloat -> GLfloat
countScore x 
  |x==0 = 0
  |x==1 = 5
  |x==2 = 25
  |x==3 = 125
  |x==4 = 625
  |otherwise = 100000