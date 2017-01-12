module Display (idle, display) where
 
import Graphics.UI.GLUT
import Control.Monad
import Data.IORef
import Cube
import Square
import Points
import System.Random
 
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
      square 0.1


  translate $ Vector3 x' y' 0
  preservingMatrix $ do
    

    scale 0.5 0.5 (0.5::GLfloat)

    forM_ (block (randomBlock num) (0.0,0.8) 0.2 angle' ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
      color $ Color3 r g b
      translate $ Vector3 x y z
      square 0.1

  swapBuffers
 
idle :: IORef (GLfloat,GLfloat) ->IORef GLfloat->IORef GLfloat ->IORef GLfloat -> IORef GLfloat -> IORef GLfloat -> IdleCallback
idle p size speed timer newBlock num = do
  sp <- get speed
  si <- get size
  t <- get timer
  p'<-get p
  
  timer $~! \x-> moduloGLFloat (t+1) sp
  
  newBlock $~! \x -> let (_,y')=p' in 
  	if y'>=(-1) then 0 else 1

  nb<- get newBlock
  p $~! \(x,y) ->
  		if moduloGLFloat t sp == fromIntegral(0)  then 
  			if nb <1 then (x,y-si) else (0,0.8)
  		else (x,y) 

  ran <-randomIO :: IO GLfloat
  

  num $~! \x -> 
  	if nb <1 then x else ran
  postRedisplay Nothing

unzipper :: [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]->[(GLfloat,GLfloat,GLfloat, GLfloat,GLfloat,GLfloat)]
unzipper [] = []
unzipper ( ((x,y),(r,g,b)) :as) = (((x/5 -1.1)*0.8),(y/5 - 1.1)*0.8,0.0::GLfloat,r,g,b) : (unzipper as)



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