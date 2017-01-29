module Display (idle, display) where
 
import Graphics.UI.GLUT
import Control.Monad
import Data.IORef
import Cube
import Square
import Points
import System.Random
import Functions
 
display :: IORef GLfloat ->IORef GLfloat -> IORef (GLfloat, GLfloat) -> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] -> IORef GLfloat->IORef GLfloat-> IORef GLfloat-> DisplayCallback
display finish angle pos table ran nextRan score= do 
  clear [ColorBuffer]
  loadIdentity
  (x',y') <- get pos
  table'<-get table
  num <- get ran
  angle' <- get angle
  nextNum <- get nextRan
  score' <- get score
  finish' <- get finish
  --
  if finish' > 0 
    then 
      do 
        preservingMatrix $ do
          color $ Color3 0.3 0 (0.3::GLfloat)
          square 1
          color $ Color3 1 0.4392 (0::GLfloat) 
          translate $ Vector3 (-0.55) 0.6 (0::GLfloat)
          scale 0.003 0.003 (1::GLfloat)
          renderString Roman "GAME"

        ran <-randomIO :: IO GLfloat
        ran2 <-randomIO :: IO GLfloat
        preservingMatrix $ do
          color $ Color3 ran (ran2*4) (num*2::GLfloat) 
          translate $ Vector3 (-0.55) (0.2) (0::GLfloat)
          scale 0.003 0.003 (1::GLfloat)
          renderString Roman "OVER"

        preservingMatrix $ do
          color $ Color3 0.5 0.5 (1::GLfloat) 
          translate $ Vector3 (-0.7) (-0.2) (0::GLfloat)
          scale 0.0018 0.0018 (1::GLfloat)
          renderString Roman $ "Your score is" 

        preservingMatrix $ do
          color $ Color3 1 0.4392 (0::GLfloat) 
          translate $ Vector3 ( -0.3 ) (-0.7) (0::GLfloat)
          scale 0.003 0.003 (1::GLfloat)
          renderString Roman $ getInt $ show score'
       -- leaveMainLoop
        preservingMatrix $ do
          color $ Color3 0.9 0.5 (1::GLfloat) 
          translate $ Vector3 (-0.55) (-0.9) (0::GLfloat)
          scale 0.0009 0.0009 (1::GLfloat)
          renderString Roman $ "Press F12 to exit" 


        when (finish' <2) (print score')
        finish $~! \x -> 2
    else
      do
                   

        preservingMatrix $ do
          color $ Color3 0 0 (0.3::GLfloat)
          plansza (0.03::GLfloat)
          color $ Color3 1 0.4392 (0::GLfloat)
          
          translate $ Vector3 0.6 0.2 (0::GLfloat)
          scale 0.0008 0.0008 (1::GLfloat)
          renderString Roman "SCORE:"

        preservingMatrix $ do
          color $ Color3 1 0.4392 (0::GLfloat) 
          translate $ Vector3 0.6 0 (0::GLfloat)
          scale 0.001 0.001 (1::GLfloat)
          renderString Roman $ getInt $ show score'


        forM_ (block (randomBlock nextNum) (1.3-0.55,1.5-1.05) 0.05 1 ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
          color $ Color3 r g b
          translate $ Vector3 x y z
          square (0.046)


        forM_ (unzipper table' ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
            color $ Color3 r g b
            translate $ Vector3 x y z
            square (0.047)
            color $ Color3 0 0 (0.3::GLfloat)
            --scale 0.001 0.001 (1::GLfloat)
            square' (0.050)



        translate $ Vector3 x' y' 0
        preservingMatrix $ do
          
          forM_ (block (randomBlock num) (0.0,0.0) 0.05 angle' ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
            color $ Color3 r g b
            translate $ Vector3 x y z
            square (0.047)
            color $ Color3 0 0 (0::GLfloat)
            square' (0.05)
      

  swapBuffers
 
idle ::IORef GLfloat ->IORef GLfloat-> IORef (GLfloat,GLfloat) ->IORef GLfloat->IORef GLfloat ->IORef GLfloat -> IORef GLfloat -> IORef GLfloat-> IORef GLfloat->IORef GLfloat-> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] -> IORef GLfloat-> IdleCallback

idle finish pause p size speed timer newBlock num nextNum angle table score= do


  sp <- get speed
  si <- get size
  t <- get timer
  p'<-get p
  num' <- get num
  nextNum' <- get nextNum
  angle'<-get angle
  tb<- get table
  fin <- get finish
  timer $~! \x-> if fin>0 then x else moduloGLFloat (t+1) sp
  
  newBlock $~! \x -> let (_,y')=p' in
    if ((y'<=(1/10 - 1.05)) && (moduloGLFloat t sp == fromIntegral(0))) ||  (checkerY (block (randomBlock num') p' (0.05::GLfloat) angle'  )  tb (2*si) )==1 then 1 else 0

  nb<- get newBlock
  
  let (newtab,score')=deleter tb in
    do 
      table $~! \x -> 
        if fin <1 then
            if nb==1 
              then updater newtab num' p'  angle' 
            else newtab
        else x
      score $~! \x -> if fin >0 then x else x+ (5* score' +nb)*sp

  finish $~! \x-> if nb >0 &&  checkerX (block (randomBlock nextNum') (0.5-0.55,1.9-1.05) (0.05::GLfloat) 1) tb (2*si) 0 >0 
      then 
        if x>1 then x else 1
      else 0
  finish' <- get finish

  pause $~! \x -> if x+finish' >0 then 1 else 0
  pause' <- get pause

  p $~! \(x,y) ->
      if (moduloGLFloat t sp == fromIntegral(0) &&( pause' <1) )||( nb==1  )then 
        if nb <1 then (x,y-si*2) else (0.5-0.55,1.9-1.05)
      else (x,y) 

  angle  $~! \x -> if nb>0 then 1 else x



  ran <-randomIO :: IO GLfloat

  num $~! \x -> 
    if nb <1 then x else nextNum'

  nextNum $~! \x -> 
    if nb <1 then x else ran
  postRedisplay Nothing
