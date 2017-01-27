module Square (square,square',plansza) where
 
import Graphics.UI.GLUT
 
vertex3f :: (GLfloat, GLfloat, GLfloat) -> IO ()
vertex3f (x, y, z) = vertex $ Vertex3 x y z
 
square :: GLfloat -> IO ()
square w = renderPrimitive Quads $ mapM_ vertex3f
  [ ( w, w, 0), ( w, -w,0), ( -w,-w,0), ( -w,w, 0)]

  
square' :: GLfloat -> IO ()
square' w = renderPrimitive LineLoop $ mapM_ vertex3f
  [ ( w, w, 0), ( w, -w,0), ( -w,-w,0), ( -w,w, 0)]

plansza:: GLfloat -> IO ()
plansza g= renderPrimitive Quads $ mapM_ vertex3f
	[(-0.5,-1,0),(-0.5-g,-1,0),(-0.5-g,1,0),(-0.5,1,0),(0.5,-1,0),(0.5+g,-1,0),(0.5+g,1,0),(0.5,1,0)]