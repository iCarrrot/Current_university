module Bindings (idle, display, reshape, keyboardMouse) where
 
import Graphics.UI.GLUT
import Data.IORef
import Display
import Functions
import Points
 
reshape :: ReshapeCallback
reshape size = do 
  viewport $= (Position 0 0, size)
 
keyboardMouse :: IORef GLfloat ->IORef GLfloat ->IORef GLfloat ->IORef GLfloat ->IORef GLfloat ->IORef GLfloat -> IORef (GLfloat, GLfloat)  -> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] ->IORef GLfloat->KeyboardMouseCallback
keyboardMouse finish score pause ran nextRan a p tab s key Down _ _ =  
  case key of
    (SpecialKey KeyLeft ) -> do
                            angle <- get a
                            num <- get ran
                            pos <- get p
                            size' <- get s
                            table <- get tab
                            let (left,right)=blockSize num angle in 
                              let size = 2*size' in
                              let (left',right')=blockSize num (moduloGLFloat (angle+1) 4) in
                                p $~! \(x,y) -> if checkerX (block (randomBlock num) pos (0.05::GLfloat) angle) table (-1::GLfloat) size >(0.1)
                                  then (x,y)
                                  else
                                    if (x> size*left -0.35)
                                    then (x-size,y) 
                                    else ( size*left-0.45,y)

    (SpecialKey KeyRight) -> do
                            angle <- get a
                            num <- get ran
                            pos <- get p
                            size' <- get s
                            table <- get tab
                           -- print (printTable table)
                            let (left,right)=blockSize num angle in 
                              let size = 2*size' in
                              let (left',right')=blockSize num (moduloGLFloat (angle+1) 4) in
                                p $~! \(x,y) -> if checkerX (block (randomBlock num) pos (0.05::GLfloat) angle) table (1::GLfloat) size >(0.1)
                                  then (x,y)
                                  else
                                    if x<  0.35 - size*right 
                                    then(x+size,y) 
                                    else (0.45 - size*right,y)
    (SpecialKey KeyUp   ) -> do 
                            angle <- get a
                            num <- get ran
                            pos <- get p
                            size' <- get s
                            a $~! \x-> (moduloGLFloat (x+1) 4)
                            let (left,right)=blockSize num angle in 
                                let size = 2*size' in
                                let (left',right')=blockSize num (moduloGLFloat (angle+1) 4) in 
                                let (posX,posY)=pos in            
                                  p $~! \(x,y)->
                                          if posX <  size*left'-0.45
                                          then ( size*left'-0.45,y)
                                          else  
                                              if  posX >0.45 - size*right'
                                              then (0.45 - size*right',y)
                                              else (x,y)
    (SpecialKey KeyDown ) -> do
                            size' <- get s
                            let size = 2*size' in
                              p $~! \(x,y) -> if y>(-0.95+size) then(x,y-size) else (x,-0.95)
                             -- print (blok)
    --(Char 'c') -> tab $~! \x -> makeTable (fromIntegral 10) (fromIntegral 20)
    (Char 'p') -> pause $~! \x-> if x <1 then 1 else 0
    _ -> return ()
keyboardMouse _ _ _ _ _ _ _ _ _ _ _ _ _ = return ()

