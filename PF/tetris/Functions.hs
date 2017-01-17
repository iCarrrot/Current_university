module Functions (unzipper,updater, checkerY, checkerX, gLabs,moduloGLFloat, randomBlock, blockSize, makeTable) where

import Graphics.Rendering.OpenGL
import Data.IORef
import System.Random
import Points

unzipper :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->[(GLfloat,GLfloat,GLfloat, GLfloat,GLfloat,GLfloat)]
unzipper [] = []
unzipper ( ((x,y),(r,g,b)) :as) = (x,y,0.0::GLfloat,r,g,b) : (unzipper as)


updater :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]-> GLfloat-> (GLfloat,GLfloat)->GLfloat-> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
updater table random (x,y) angle =
  let typ = randomBlock random in
    let list = block typ (x,y) (0.05::GLfloat) angle in 
      updater' list table

updater' :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
updater' [] table = table
--updater' list [] = []
updater' ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table)
  |gLabs (x-x1) < 0.05 && gLabs (y-y1) < 0.05 = (updater' list table) ++ [((x1,y1),(r,g,b))]
  |otherwise =   updater'  ((x,y,z,r,g,b):list) (table ++ [((x1,y1),(r1,g1,b1))] )



check :: (GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat) -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->GLfloat
check (_,_,_,_,_,_) [] size = (-1)
check (x,y,z,r,g,b) (((x1,y1),(r1,g1,b1)):table) size
  |gLabs (x-x1) < size && gLabs (y-y1) < size && r1+g1+b1>0 && r1+g1+b1<3 = 1 
  |gLabs (x-x1) < size && gLabs (y-y1) < size && (r1+g1+b1==0 || r1+g1+b1==3 ) = 0 
  |otherwise = check (x,y,z,r,g,b) table size


checkerY :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat ->GLfloat
checkerY [] table size= 0
checkerY ((x,y,z,r,g,b):list) table size
  |check (x,y-size,z,r,g,b) table size == 1 =1
  |check (x,y-size,z,r,g,b) table size == (-1) =(-1)
  |otherwise = checkerY list table size


checkerX :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->GLfloat->GLfloat
checkerX [] table _ _= 0
checkerX ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table) mult size
  |check (x-size,y,z,r,g,b) table size == 1 =1
  |check (x-size,y,z,r,g,b) table size == (-1) =(-1)
  |otherwise = checkerX list table  mult size









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
  |num<=0.56 = (0,1) 
  |num<=0.70 = (1,0) 
  |num<=0.84 = (1,1) 
  |num<=1 = (1,1) 
  |otherwise = (0,0) 

blockSize num 2
  |num<=0.14 = (0,0)
  |num<=0.28 = (1,0)
  |num<=0.42 = (0,1) 
  |num<=0.56 = (1,1) 
  |num<=0.70 = (1,1)
  |num<=0.84 = (1,0) 
  |num<=1 = (0,1) 
  |otherwise = (0,0) 

blockSize num 3
  |num<=0.14 = (2,1) 
  |num<=0.28 = (1,1)
  |num<=0.42 = (0,1) 
  |num<=0.56 = (1,0) 
  |num<=0.70 = (0,1)
  |num<=0.84 = (1,1) 
  |num<=1 = (1,1) 
  |otherwise = (0,0) 

blockSize num _
  |num<=0.14 = (0,0)
  |num<=0.28 = (0,1)
  |num<=0.42 = (0,1)
  |num<=0.56 = (1,1)
  |num<=0.70 = (1,1)
  |num<=0.84 = (1,0)
  |num<=1 = (0,1)
  |otherwise = (0,0)


makeTable :: GLfloat ->GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable rows colm = makeTable' rows colm rows 0


makeTable' :: GLfloat -> GLfloat -> GLfloat-> GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable' 0 colm rows' x =if colm>1 then [((rows'/10 -0.55,(colm-1)/10 - 1.05),(moduloGLFloat (rows'+1+colm) 2,moduloGLFloat (rows'+1+colm) 2,moduloGLFloat (rows'+1+colm) 2))]++(makeTable' (rows'-1) (colm-1) rows' x) else []
makeTable' rows colm rows' x = if colm>0 then [((rows/10 -0.55,colm/10 - 1.05),(moduloGLFloat (rows+colm) 2,moduloGLFloat (rows+colm) 2,moduloGLFloat (rows+colm) 2))]++(makeTable' (rows-1) colm rows' (x+1)) else []

