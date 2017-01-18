module Display (idle, display) where
 
import Graphics.UI.GLUT
import Control.Monad
import Data.IORef
import Cube
import Square
import Points
import System.Random
import Functions
 
display :: IORef GLfloat -> IORef (GLfloat, GLfloat) -> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] -> IORef GLfloat-> DisplayCallback
display angle pos table ran= do 
  clear [ColorBuffer]
  loadIdentity
  (x',y') <- get pos
  table'<-get table
  num <- get ran
  angle' <- get angle
  forM_ (unzipper table' ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
      color $ Color3 r g b
      translate $ Vector3 x y z
      square (0.05)


  translate $ Vector3 x' y' 0
  preservingMatrix $ do
    

  forM_ (block (randomBlock num) (0.0,0.0) 0.05 angle' ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
    color $ Color3 r g b
    translate $ Vector3 x y z
    square (0.05)

  swapBuffers
 
idle ::IORef GLfloat-> IORef (GLfloat,GLfloat) ->IORef GLfloat->IORef GLfloat ->IORef GLfloat -> IORef GLfloat -> IORef GLfloat-> IORef GLfloat-> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] -> IdleCallback

idle pause' p size speed timer newBlock num angle table= do
  sp <- get speed
  si <- get size
  t <- get timer
  p'<-get p
  num' <- get num
  angle'<-get angle
  tb<- get table
  timer $~! \x-> moduloGLFloat (t+1) sp
  
  newBlock $~! \x -> let (_,y')=p' in
    if ((y'<=(1/10 - 1.05)) && (moduloGLFloat t sp == fromIntegral(0))) ||  (checkerY (block (randomBlock num') p' (0.05::GLfloat) angle'  )  tb si )==1 then 1 else 0

  nb<- get newBlock
  --print p'
 
  --if nb == 1 then print (updater tb num' p'  angle' ) else print (block (randomBlock num') p' (0.05::GLfloat) angle' ) 
  table $~! \x -> if nb==1 then 
    updater tb num' p'  angle' 
    else x
  pause <- get pause'
  p $~! \(x,y) ->
      if (moduloGLFloat t sp == fromIntegral(0) &&( pause <1) )||( nb==1  )then 
        if nb <1 then (x,y-si*2) else (0.5-0.55,2-1.05)
      else (x,y) 

    



  ran <-randomIO :: IO GLfloat
  num $~! \x -> 
    if nb <1 then x else ran
  postRedisplay Nothing
