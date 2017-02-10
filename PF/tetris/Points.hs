module Points (block) where
 
import Graphics.Rendering.OpenGL

 
block:: Char->(GLfloat,GLfloat)->GLfloat->GLfloat
    ->[(GLfloat,GLfloat,GLfloat,GLfloat,GLfloat,GLfloat)]



block typ (x,y) size' rotate 
    |typ=='I' =
        if (moduloGLFloat rotate 2) == 0 
            then  [(x,y,0,1,0,0),(x,y+size,0,1,0,0),(x,y+size+size,0,1,0,0),
                (x,y+size+size+size,0,1,0,0)] 
            else  [(x,y,0,1,0,0),(x-size,y,0,1,0,0),(x+size,y,0,1,0,0),
                (x-size-size,y,0,1,0,0)] 

    |typ=='T' = case rotate of 
        1 -> [(x,y,0,0.5,0.5,0.5),(x-size,y+size,0,0.5,0.5,0.5),
            (x+size,y+size,0,0.5,0.5,0.5),(x,y+size,0,0.5,0.5,0.5)] 
        2 -> [(x,y,0,0.5,0.5,0.5),(x-size,y+size,0,0.5,0.5,0.5),
            (x,y+size,0,0.5,0.5,0.5),(x,y+size+size,0,0.5,0.5,0.5)] 
        3 -> [(x,y,0,0.5,0.5,0.5),(x-size,y,0,0.5,0.5,0.5),
            (x+size,y,0,0.5,0.5,0.5),(x,y+size,0,0.5,0.5,0.5)] 
        otherwise -> [(x,y,0,0.5,0.5,0.5),(x+size,y+size,0,0.5,0.5,0.5),
            (x,y+size,0,0.5,0.5,0.5),(x,y+size+size,0,0.5,0.5,0.5)]    

    |typ=='O' = [(x,y,0,0,1,1),(x+size,y,0,0,1,1),(x,y+size,0,0,1,1),
        (x+size,y+size,0,0,1,1)] 

    |typ=='L' = case rotate of  
        1 ->[(x-size,y,0,1,1,0),(x-size,y+size,0,1,1,0),(x,y+size,0,1,1,0),
            (x+size,y+size,0,1,1,0)]
        2 -> [(x,y,0,1,1,0),(x,y+size,0,1,1,0),(x,y+size+size,0,1,1,0),
            (x-size,y+size+size,0,1,1,0)]
        3 -> [(x+size,y +size ,0,1,1,0),(x-size,y,0,1,1,0),(x,y,0,1,1,0),
            (x+size,y,0,1,1,0)]
        otherwise -> [(x,y,0,1,1,0),(x,y+size,0,1,1,0),(x,y+size+size,0,1,1,0),
            (x+size,y,0,1,1,0)]
    
    |typ=='J' = case rotate of 
        1 -> [(x+size,y,0,1,0,1),(x+size,y+size,0,1,0,1),(x,y+size,0,1,0,1),
            (x-size,y+size,0,1,0,1)]
        2 -> [(x,y,0,1,0,1),(x,y+size,0,1,0,1),(x,y+size+size,0,1,0,1),
            (x-size,y,0,1,0,1)]
        3 -> [(x,y,0,1,0,1),(x-size,y+size,0,1,0,1),(x+size,y,0,1,0,1),
            (x-size,y,0,1,0,1)]
        otherwise -> [(x,y,0,1,0,1),(x,y+size,0,1,0,1),(x,y+size+size,0,1,0,1),
            (x+size,y+size+size,0,1,0,1)]
         
    
    |typ=='S' = case (moduloGLFloat rotate 2) of 
        1 -> [(x,y,0,0,0,1),(x-size,y,0,0,0,1),(x,y+size,0,0,0,1),
            (x+size,y+size,0,0,0,1)]
        otherwise -> [(x,y,0,0,0,1),(x-size,y+size,0,0,0,1),(x,y+size,0,0,0,1),
            (x-size,y+size+size,0,0,0,1)]
    
    |typ=='Z' = case (moduloGLFloat rotate 2) of 
        1 -> [(x,y,0,0,1,0),(x+size,y,0,0,1,0),(x,y+size,0,0,1,0),
            (x-size,y+size,0,0,1,0)]
        otherwise -> [(x,y,0,0,1,0),(x+size,y+size,0,0,1,0),(x,y+size,0,0,1,0),
            (x+size,y+size+size,0,0,1,0)]
    
    |otherwise = [(x,y,0,0.5,0.8,0.1),(x-size,y,0,0.5,0.8,0.1),
        (x,y-size,0,0.5,0.8,0.1),(x+size,y-size,0,0.5,0.8,0.1),
            (x+size+size,y-size,0,0.5,0.8,0.1)]

    where size = size' * 2

moduloGLFloat :: GLfloat-> GLfloat->GLfloat
moduloGLFloat m1 m2=if m1>=m2 then moduloGLFloat (m1-m2) m2 else m1




