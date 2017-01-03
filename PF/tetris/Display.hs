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
 
idle :: IORef (GLfloat,GLfloat) ->IORef GLfloat -> IORef GLfloat -> IdleCallback
idle p delta timer = do
  d <- get delta
  t <- get timer
  
  timer $~! (+ 1)

  p $~! \(x,y) -> if y>(-1 )  then 
  		if moduloGLFloat t 10 == fromIntegral(0)  then (x,y- 100 * d) 
  		else (x,y) 
  	else (x,-1) 
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