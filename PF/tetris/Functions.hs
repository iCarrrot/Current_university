module Functions (countScore,speedLevel, dropLastTwo, deleteFullRows, 
  unzipTable,updateTable, checkIfEmptyY, checkIfEmptyX,moduloGLfloat, 
  getBlockId, blockSize, makeTable, ifLongBlock) where

import Graphics.Rendering.OpenGL 
import Data.IORef 
import System.Random 
import Points



--init functions

makeTable :: GLfloat ->GLfloat 
  -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable rows colm = makeTable' rows colm rows 0


makeTable' :: GLfloat -> GLfloat -> GLfloat-> GLfloat 
  -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable' 0 colm rows' x = 
  if colm>1 
    then [((rows'/10 -0.55,(colm-1)/10 - 1.05),(0,0,0))]
      ++(makeTable' (rows'-1) (colm-1) rows' x) 
    else []
makeTable' rows colm rows' x = if colm>0 
  then [((rows/10 -0.55,colm/10 - 1.05),(0,0,0))]
    ++(makeTable' (rows-1) colm rows' (x+1)) 
  else []

unzipTable :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
  ->[(GLfloat,GLfloat,GLfloat, GLfloat,GLfloat,GLfloat)]
unzipTable [] = []
unzipTable ( ((x,y),(r,g,b)) :as) = (x,y,0.0::GLfloat,r,g,b) : (unzipTable as)

speedLevel:: GLfloat -> GLfloat
speedLevel speed 
  |speed == 1 = 45.0
  |speed == 2 = 37.0
  |speed == 3 = 30.0
  |speed == 4 = 24.0
  |speed == 5 = 19.0
  |speed == 6 = 15.0
  |speed == 7 = 12.0
  |speed == 8 = 9.0
  |speed == 9 = 7.0
  |speed == 10 = 5.0
  |otherwise = 1.0


-- Checking functions

checkIfEmptyY :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
  ->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat ->GLfloat

checkIfEmptyY [] table size= 0
checkIfEmptyY ((x,y,z,r,g,b):list) table size
  |checkOne (x,y-size,z,r,g,b) table size == 1 =1
  |checkOne (x,y-size,z,r,g,b) table size == (-1) =(-1)
  |otherwise = checkIfEmptyY list table size


checkIfEmptyX :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
  ->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->GLfloat->GLfloat

checkIfEmptyX [] table _ _= 0
checkIfEmptyX ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table) mult size
  |checkOne (x+mult*size,y,z,r,g,b) table size == 1 =1
  |checkOne (x+mult*size,y,z,r,g,b) table size == (-1) =(-1)
  |otherwise = checkIfEmptyX list table  mult size


checkIfFull :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
  ->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat ->GLfloat

checkIfFull [] table size= 1
checkIfFull ((x,y,z,r,g,b):list) table size
  |checkOne (x,y,z,r,g,b) table size == 1 =checkIfFull list table size
  |checkOne (x,y,z,r,g,b) table size == (-1) =(-1)
  |otherwise = 0

checkOne :: (GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat) 
  -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->GLfloat->GLfloat

checkOne (x,y,n3,n4,n5,n6) [] size  
  |x<0.45||x>0.45 = 0
  |y>0.95 = 0  
  |otherwise =(-1)
checkOne (x,y,n1,n2,n3,n4) (((x1,y1),(r1,g1,b1)):table) size
  |absGLfloat (x-x1) < 0.04 && absGLfloat (y-y1) < 0.04 && r1+g1+b1>0 
    && r1+g1+b1<3 = 1 
  |absGLfloat (x-x1) < 0.04 && absGLfloat (y-y1) < 0.04 && (r1+g1+b1<0.4 
    || r1+g1+b1>2.6 ) = 0 
  
  |otherwise = checkOne (x,y,n1,n2,n3,n4) table size



-- functions to delete rows and update table

emptyRow::GLfloat-> [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]

emptyRow y = emptyRow' 1 y 
emptyRow'::GLfloat->GLfloat
  -> [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]

emptyRow' x y =
      if x<=10 
        then [(x/10 -0.55,y/10-1.05,0,0,0,0)] ++ (emptyRow' (x+1) y)
        else []

deleteFullRows ::[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
  ->([((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))],GLfloat)
deleteFullRows table = deleteFullRows' 1 table 0

deleteFullRows' :: GLfloat->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
  ->GLfloat->([((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))],GLfloat)

deleteFullRows' y table score
  |y> 20 =(table,score)
  |otherwise = if checkIfFull (emptyRow y) table (0.05::GLfloat) ==1 
      then deleteFullRows' (y+1) (updateTable'' table y) (score+1)
      else deleteFullRows' (y+1) table score


updateTable :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]-> GLfloat
  -> (GLfloat,GLfloat)->GLfloat
  -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]

updateTable table random (x,y) angle =
  let typ = getBlockId random in
    let list = block typ (x,y) (0.05::GLfloat) angle in 
      updateTable' list table

updateTable' :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
                  ->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
                  ->[((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
  
updateTable' [] table = reverse table
updateTable' ((x,y,z,r,g,b):list) (((x1,y1),(r1,g1,b1)):table)
    |absGLfloat (x-x1) < 0.05 && absGLfloat (y-y1) < 0.05 = 
      (updateTable' list (table ++ [((x1,y1),(r,g,b))]))
    |otherwise =  
       updateTable'  ((x,y,z,r,g,b):list) (table ++ [((x1,y1),(r1,g1,b1))] )

updateTable'' :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] -> GLfloat 
  -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]

updateTable'' [] y = []
updateTable'' (((x1,y1),(r1,g1,b1)):table) y
  |absGLfloat( y1- (y/10 - 1.05)) < 0.04 =  
    (updateTable'' table y)++[((x1,0.95),(0,0,0))]
  |y1<y/10 - 1.05 = (updateTable'' table y)++[((x1,y1),(r1,g1,b1))]
  |y1>y/10 - 1.05 = (updateTable'' table y)++[((x1,y1-0.1),(r1,g1,b1))]
  |otherwise = (updateTable'' table y)++[((x1,y1),(0.7,0.1,0.6))]





--blocks functions
ifLongBlock :: GLfloat -> (GLfloat,GLfloat)
ifLongBlock num = 
  if num<=0.14 
    then (1.37-0.55::GLfloat,1.5-1.05::GLfloat)
    else (1.3-0.55::GLfloat,1.5-1.05::GLfloat)

getBlockId :: GLfloat -> Char 

getBlockId x
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


-- other functions

dropLastTwo::String->String
dropLastTwo x = take (length x - 2) x 


countScore :: GLfloat -> GLfloat
countScore x 
  |x==0 = 0
  |x==1 = 5
  |x==2 = 25
  |x==3 = 125
  |x==4 = 625
  |otherwise = 100000




--GLfloat functions



absGLfloat :: GLfloat->GLfloat
absGLfloat x 
  |x<0 =(-x)
  |otherwise = x

moduloGLfloat :: GLfloat-> GLfloat->GLfloat
moduloGLfloat m1 m2=if m1>=m2 then moduloGLfloat (m1-m2) m2 else m1











-- Debug functions

printTable:: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
  ->[(GLfloat,GLfloat,Char)]
printTable [] = []
printTable (((x,y),(r,g,b)):table) =
  (x*10 +5.5,y*10+10.5,reverseBlock r g b):printTable table



printBlock :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
  ->[(GLfloat,GLfloat,Char)]
printBlock [] = []
printBlock ((x,y,z,r,g,b):rest)=
  (x*10 +5.5,y*10+10.5,reverseBlock r g b):printBlock rest

printBlock' :: [(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]
  ->[(GLfloat,GLfloat,Char)]
printBlock' [] = []
printBlock' ((x,y,z,r,g,b):rest)=
  (x,y,reverseBlock r g b):printBlock' rest


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
