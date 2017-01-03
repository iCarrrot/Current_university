module Square where
 
import Graphics.UI.GLUT
 
vertex3f :: (GLfloat, GLfloat, GLfloat) -> IO ()
vertex3f (x, y, z) = vertex $ Vertex3 x y z
 
square :: GLfloat -> IO ()
square w = renderPrimitive Quads $ mapM_ vertex3f
  [ ( w, w, 0), ( w, -w,0), ( -w,-w,0), ( -w,w, 0)]