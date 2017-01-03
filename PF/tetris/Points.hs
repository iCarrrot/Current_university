module Points (block,points,moduloGLFloat) where
 
import Graphics.Rendering.OpenGL
 
points :: Int -> [(GLfloat,GLfloat,GLfloat)]
points n = [ (sin (2*pi*k/n'), cos (2*pi*k/n'), 0) | k <- [1..n'] ]
   where n' = fromIntegral n
block:: Char->(GLfloat,GLfloat)->GLfloat->GLfloat->[(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]



block typ (x,y) size rotate
    |typ=='I' =
        if (moduloGLFloat rotate 2) == 0 
            then  [(x,y,0,1,0,0),(x,y-size,0,1,0,0),(x,y-size-size,0,1,0,0),(x,y-size-size-size,0,1,0,0)] 
            else  let x'=y in let y'=x in  [(x',y',0,1,0,0),(x',y'-size,0,1,0,0),(x',y'-size-size,0,1,0,0),(x',y'-size-size-size,0,1,0,0)] 
    |typ=='T' = [(x,y,0,0.5,0.5,0.5),(x-size,y,0,0.5,0.5,0.5),(x+size,y,0,0.5,0.5,0.5),(x,y-size,0,0.5,0.5,0.5)] 
    |typ=='O' = [(x,y,0,0,1,1),(x+size,y,0,0,1,1),(x,y-size,0,0,1,1),(x+size,y-size,0,0,1,1)] 
    |typ=='L' = [(x,y,0,1,1,0),(x,y-size,0,1,1,0),(x,y-size-size,0,1,1,0),(x+size,y-size-size,0,1,1,0)]
    |typ=='J' = [(x,y,0,1,0,1),(x,y-size,0,1,0,1),(x,y-size-size,0,1,0,1),(x-size,y-size-size,0,1,0,1)]
    |typ=='S' = [(x,y,0,0,0,1),(x+size,y,0,0,0,1),(x,y-size,0,0,0,1),(x-size,y-size,0,0,0,1)] 
    |typ=='Z' = [(x,y,0,0,1,0),(x-size,y,0,0,1,0),(x,y-size,0,0,1,0),(x+size,y-size,0,0,1,0)]
    |otherwise = [(x,y,0,1,1,1),(x-size,y,0,1,1,1),(x,y-size,0,1,1,1),(x+size,y-size,0,1,1,1),(x+size+size,y-size,0,1,1,1)]




moduloGLFloat :: GLfloat-> GLfloat->GLfloat
moduloGLFloat m1 m2=if m1>=m2 then moduloGLFloat (m1-m2) m2 else m1