import Graphics.UI.GLUT
import Data.IORef
import Bindings
import System.Random

myPureFunction :: Float -> Float
myPureFunction x = x
 
main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  initialDisplayMode $= [DoubleBuffered]
  _window <- createWindow "iTetris"
  reshapeCallback $= Just reshape
  angle <- newIORef 1
  size <- newIORef 0.1
  speed <- newIORef 10
  scale <- newIORef 0.5
  pos <- newIORef (0, 1)
  timer <- newIORef (0)
  newBlock <- newIORef 0
  ran <-randomIO :: IO GLfloat
  num <- newIORef (ran)
  table <-newIORef (makeTable (fromIntegral 10) (fromIntegral 20)) 
  licznik <-newIORef 0.5
  keyboardMouseCallback $= Just (keyboardMouse angle pos)
  idleCallback $= Just (idle pos size speed timer newBlock num)
  displayCallback $= display angle pos table num
  
  mainLoop


