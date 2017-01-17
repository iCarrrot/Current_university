import Graphics.UI.GLUT
import Data.IORef
import Bindings
import System.Random
import Functions

myPureFunction :: Float -> Float
myPureFunction x = x
 
main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  initialDisplayMode $= [DoubleBuffered]
  _window <- createWindow "iTetris v.0.5"
  reshapeCallback $= Just reshape
  angle <- newIORef 1
  size <- newIORef 0.05
  speed <- newIORef 20
  scale <- newIORef 0.5
  pos <- newIORef (0.5-0.55,2-1.05)
  timer <- newIORef (0)
  newBlock <- newIORef 0
  ran <-randomIO :: IO GLfloat
  num <- newIORef (ran)
  table <-newIORef (makeTable (fromIntegral 10) (fromIntegral 20)) 
  licznik <-newIORef 0.5
  keyboardMouseCallback $= Just (keyboardMouse num angle pos table size)
  idleCallback $= Just (idle pos size speed timer newBlock num angle table)
  displayCallback $= display angle pos table num

  
  mainLoop


