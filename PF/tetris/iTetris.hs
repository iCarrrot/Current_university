import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL
import Data.IORef
import Bindings
import System.Random
import Functions
import System.Environment

-- TODO: make readable code

main :: IO ()
main = do
  list <- getArgs
  let speed' =  read (head(list)) :: GLfloat
  (_progName, _args) <- getArgsAndInitialize
  initialDisplayMode $= [DoubleBuffered]

  _window <- createWindow "iTetris v.1.0.1 beta"

  reshapeCallback $= Just reshape

  pause <- newIORef 0.0
  angle <- newIORef 1
  size <- newIORef 0.05
  speed <- newIORef (speedLevel speed')
  score <- newIORef 0
  pos <- newIORef (0.5-0.55,2.1-1.05)
  timer <- newIORef (0)
  newBlock <- newIORef 0
  ran <-randomIO :: IO GLfloat
  ran2 <-randomIO :: IO GLfloat
  num <- newIORef ran
  nextNum <- newIORef ran2
  ifFinish <- newIORef 0
  table <-newIORef (makeTable (fromIntegral 10) (fromIntegral 20)) 
  licznik <-newIORef 0.5

  keyboardMouseCallback $= Just (keyboardMouse 
    ifFinish score pause num nextNum angle pos table size)
  idleCallback $= Just (idle 
    ifFinish pause pos size speed timer newBlock num nextNum angle table score)
  displayCallback $= display ifFinish angle pos table num nextNum score
  
  mainLoop



