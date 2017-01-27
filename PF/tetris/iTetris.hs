import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL
import Data.IORef
import Bindings
import System.Random
import Functions
import System.Environment

-- TODO: speed, keyUp, keyDown

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
  speed <- newIORef (100/speed')
  score <- newIORef 0
  pos <- newIORef (0.5-0.55,1.9-1.05)
  timer <- newIORef (0)
  newBlock <- newIORef 0
  ran <-randomIO :: IO GLfloat
  ran2 <-randomIO :: IO GLfloat
  num <- newIORef ran
  nextNum <- newIORef ran2
  finish <- newIORef 0

  table <-newIORef (makeTable (fromIntegral 10) (fromIntegral 20)) 
  licznik <-newIORef 0.5
  keyboardMouseCallback $= Just (keyboardMouse finish score pause num nextNum angle pos table size)
  idleCallback $= Just (idle finish pause pos size speed timer newBlock num nextNum angle table score)
  displayCallback $= display finish angle pos table num nextNum score
  mainLoop



