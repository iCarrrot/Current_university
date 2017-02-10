module Display (idle, display) where
 
import Graphics.UI.GLUT
import Control.Monad
import Data.IORef
import Square
import Points
import System.Random
import Functions
 
display :: IORef GLfloat ->IORef GLfloat -> IORef (GLfloat, GLfloat) 
  -> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] -> IORef GLfloat
  ->IORef GLfloat-> IORef GLfloat-> DisplayCallback

display ifFinish angle pos table ran nextRan score= do 


  clear [ColorBuffer]
  loadIdentity 


  (x',y') <- get pos
  table'<-get table
  num <- get ran
  angle' <- get angle
  nextNum <- get nextRan
  score' <- get score
  ifFinish' <- get ifFinish

  --
  if ifFinish' < 1 
    then 
      do 
        --wyświetlenie ramki i napisu "SCORE"
        preservingMatrix $ do
          color $ Color3 0 0 (0.3::GLfloat)
          board (0.03::GLfloat)
          color $ Color3 1 0.4392 (0::GLfloat)
          
          translate $ Vector3 0.6 0.2 (0::GLfloat)
          scale 0.0008 0.0008 (1::GLfloat)
          renderString Roman "SCORE:"

        --Wyświetlenie wyniku
        preservingMatrix $ do

          color $ Color3 1 0.4392 (0::GLfloat) 
          translate $ Vector3 0.6 0 (0::GLfloat)
          scale 0.001 0.001 (1::GLfloat)
          renderString Roman $ dropLastTwo $ show score'

        --Wyświetlenie następnego klocka
        forM_ (block (getBlockId nextNum) (ifLongBlock nextNum) 0.05 1 ) $ 
          \(x,y,z,r,g,b) 
          -> preservingMatrix $ do
            color $ Color3 r g b
            translate $ Vector3 x y z
            square (0.046)

        --Wyświetlenie planszy z ułożonymi już klockami
        forM_ (unzipTable table' ) $ \(x,y,z,r,g,b) -> preservingMatrix $ do
            color $ Color3 r g b
            translate $ Vector3 x y z
            square (0.047)
            color $ Color3 0 0 (0.3::GLfloat)
            square' (0.050)


        --Wyświetlenie i poruszanie aktualnym klockiem
        translate $ Vector3 x' y' 0
        preservingMatrix $ do
          
          forM_ (block (getBlockId num) (0.0,0.0) 0.05 angle' ) $ 
           \(x,y,z,r,g,b) -> preservingMatrix $ do
            color $ Color3 r g b
            translate $ Vector3 x y z
            square (0.047)
            color $ Color3 0 0 (0::GLfloat)
            square' (0.05)
        
    else

      do   

        preservingMatrix $ do
          color $ Color3 0.3 0 (0.3::GLfloat)
          square 1
          color $ Color3 1 0.4392 (0::GLfloat) 
          translate $ Vector3 (-0.55) 0.6 (0::GLfloat)
          scale 0.003 0.003 (1::GLfloat)
          renderString Roman "GAME"

        preservingMatrix $ do
          color $ Color3 ( (\x->if x>0.5 then 0 else 1) num ) 
            ( (\x->if x>0.5 then 0 else 1) num ) 
            ( (\x->if x>0.5 then 0::GLfloat else 1 ::GLfloat) num )
            
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
          renderString Roman $ dropLastTwo $ show score'

        preservingMatrix $ do
          color $ Color3 0.9 0.5 (1::GLfloat) 
          translate $ Vector3 (-0.55) (-0.9) (0::GLfloat)
          scale 0.0009 0.0009 (1::GLfloat)
          renderString Roman $ "Press F12 to exit" 


        when (ifFinish' <2) (print score')
        ifFinish $~! \x -> 2        
        
      

  swapBuffers
 
idle ::IORef GLfloat ->IORef GLfloat-> IORef (GLfloat,GLfloat) 
  ->IORef GLfloat->IORef GLfloat ->IORef GLfloat -> IORef GLfloat 
  -> IORef GLfloat-> IORef GLfloat->IORef GLfloat
  -> IORef [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))] 
  -> IORef GLfloat-> IdleCallback

idle ifFinish pause p size speed timer newBlock num nextNum angle table score= 
 do


  speed' <- get speed
  size' <- get size
  timer' <- get timer
  p'<-get p
  num' <- get num
  nextNum' <- get nextNum
  angle'<-get angle
  table'<- get table
  ifFinish' <- get ifFinish

  let (newtab,score') = deleteFullRows table'

  
  
  newBlock $~! \x -> let (_,y')=p' in
    if (y'<=(1/10 - 1.05) && moduloGLfloat timer' (2*speed') == fromIntegral 0 ) 
      || ( (checkIfEmptyY (block (getBlockId num') p' (0.05::GLfloat) angle'  )  
        table' (2*size') ) == 1 && moduloGLfloat timer' (2*speed') == fromIntegral 0 )

        then 1 
        else 0

  nb<- get newBlock
  

  table $~! \x -> 
    if ifFinish' <1 then
        if nb==1 
          then updateTable newtab num' p'  angle' 
        else newtab
    else x


  score $~! \x -> if ifFinish' >0 
    then x 
    else x + (5 * score' + nb) * speed'


  ifFinish $~! \x-> if nb >0 
    &&  checkIfEmptyX (block (getBlockId nextNum') (0.5-0.55,1.9-1.05) 
      (0.05::GLfloat) 1) table' (2*size') 0 >0 
      then 
        if x>1 then x else 1
      else 0
  ifFinish' <- get ifFinish

  pause $~! \x -> if x+ifFinish' >0 then 1 else 0
  pause' <- get pause

  p $~! \(x,y) ->
      if (moduloGLfloat timer' speed' == fromIntegral(0) &&( pause' <1) )
        ||( nb==1  )
        then 
          if nb <1 
            then (x,y-size'*2) 
            else (0.5-0.55,1.9-1.05)
        else (x,y) 


  angle  $~! \x -> if nb>0 then 1 else x


  ran <-randomIO :: IO GLfloat

  num $~! \x -> 
    if nb <1 then x else nextNum'

  nextNum $~! \x -> 
    if nb <1 then x else ran

  timer $~! \x-> if ifFinish'>0 
    then x 
    else moduloGLfloat ((1-nb)*timer'+1) speed'

  postRedisplay Nothing
