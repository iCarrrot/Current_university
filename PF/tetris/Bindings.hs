module Bindings (idle, display, reshape, keyboardMouse) where
 
import Graphics.UI.GLUT
import Data.IORef
import Display
import Functions
import Points
import Control.Monad
 
reshape :: ReshapeCallback
reshape (Size w h) = do 
  viewport $= (Position 0 0, (Size h h ))
 
keyboardMouse :: IORef GLfloat ->IORef GLfloat ->IORef GLfloat ->IORef GLfloat 
  ->IORef GLfloat ->IORef GLfloat -> IORef (GLfloat, GLfloat)  
    -> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] 
      ->IORef GLfloat->KeyboardMouseCallback
keyboardMouse ifFinish score pause blockNumber nextRan angle position table 
  size key Down _ _ =  
  case key of
    (SpecialKey KeyLeft ) -> do

      angle' <- get angle
      blockNumber' <- get blockNumber
      position' <- get position
      size' <- get size
      table' <- get table
      let (left,right)=blockSize blockNumber' angle' in 
        let size2 = 2*size' in
        let (left',right')=blockSize blockNumber' (moduloGLfloat (angle'+1) 4) 
        in
          position $~! \(x,y) -> 
          if checkIfEmptyX (block (getBlockId blockNumber') position' 
            (0.05::GLfloat) angle') table' (-1::GLfloat) size2 >(0.1)
            then (x,y)
            else
              if (x> size2*left -0.35)
              then (x-size2,y) 
              else ( size2*left-0.45,y)

    (SpecialKey KeyRight) -> do

      angle' <- get angle
      blockNumber' <- get blockNumber
      position' <- get position
      size' <- get size
      table' <- get table
      let (left,right)=blockSize blockNumber' angle' in 
        let size2 = 2*size' in
        let (left',right')=blockSize blockNumber' (moduloGLfloat (angle'+1) 4) 
        in
          position $~! \(x,y) -> 
          if checkIfEmptyX (block (getBlockId blockNumber') position' 
            (0.05::GLfloat) angle') table' (1::GLfloat) size2 > (0.1)
            then (x,y)
            else
              if x<  0.35 - size2*right 
              then(x+size2,y) 
              else (0.45 - size2*right,y)

    (SpecialKey KeyUp   ) -> do 

      angle' <- get angle
      blockNumber' <- get blockNumber
      position' <- get position
      size' <- get size
      table' <- get table
      if checkIfEmptyX (block (getBlockId blockNumber') position' 
        (0.05::GLfloat) (moduloGLfloat (angle'+1) 4) ) table' (0::GLfloat) 
        (2*size') <(0.5)
        then do
          angle $~! \x-> (moduloGLfloat (x+1) 4)
          let (left,right)=blockSize blockNumber' angle' in 
            let size2 = 2*size' in
            let 
            (left',right') = blockSize blockNumber' (moduloGLfloat (angle'+1) 4) 
              in 
                let (posX,posY)=position' in            
                  position $~! \(x,y)->
                          if posX <  size2*left'-0.45
                          then ( size2*left'-0.45,y)
                          else  
                              if  posX >0.45 - size2*right'
                              then (0.45 - size2*right',y)
                              else (x,y)
        else do
          angle $~! \x->x
          position $~! \x->x

    (SpecialKey KeyDown ) -> do
      size' <- get size
      position' <- get position
      angle'' <- get angle
      blockNumber' <- get blockNumber
      table' <- get table
      let size2 = 2*size' in
        position $~! \(x,y) ->if (checkIfEmptyY (block 
          (getBlockId blockNumber') position' (0.05::GLfloat) angle''  )  
          table' (2*size') )==1 
          then (x,y) 
          else
            if y>(-0.95+size2) 
              then(x,y-size2) 
              else (x,-0.95)
    (Char ' ') -> pause $~! \x-> if x <1 then 1 else 0
    (SpecialKey KeyF12) -> do 
      ifFinish' <- get ifFinish
      when (ifFinish' > 1) leaveMainLoop
    _ -> return ()
keyboardMouse _ _ _ _ _ _ _ _ _ _ _ _ _ = return ()

