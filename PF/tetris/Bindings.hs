module Bindings (idle, display, reshape, keyboardMouse, makeTable) where
 
import Graphics.UI.GLUT
import Data.IORef
import Display
import Points
 
reshape :: ReshapeCallback
reshape size = do 
  viewport $= (Position 0 0, size)
 
keyboardMouse :: IORef GLfloat -> IORef (GLfloat, GLfloat) ->KeyboardMouseCallback
keyboardMouse a p key Down _ _ = case key of
  (SpecialKey KeyLeft ) -> p $~! \(x,y) -> if x>(-1) then (x-0.1,y) else (-1,y)
  (SpecialKey KeyRight) -> p $~! \(x,y) -> if x<1 then(x+0.1,y) else (1,y)
  (SpecialKey KeyUp   ) -> a $~! \x-> moduloGLFloat x+1 4
  (SpecialKey KeyDown ) -> p $~! \(x,y) -> if y>(-1) then(x,y-0.1) else (x,-1)
  _ -> return ()
keyboardMouse _ _ _ _ _ _ = return ()


makeTable :: GLfloat ->GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable rows colm = makeTable' rows colm rows

makeTable' :: GLfloat -> GLfloat -> GLfloat -> [((GLfloat,GLfloat),(GLfloat,GLfloat,GLfloat))]
makeTable' 0 colm rows'=if colm>1 then [((rows',colm-1),(4*colm/40,(11-colm)/11,1))]++(makeTable' (rows'-1) (colm-1) rows') else []
makeTable' rows colm rows' = if colm>0 then [((rows,colm),(4*rows/40,(11-rows)/11,1))]++(makeTable' (rows-1) colm rows') else []

