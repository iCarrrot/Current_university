module Square (square,square',board) where
 
import Graphics.UI.GLUT
 
vertex3f :: (GLfloat, GLfloat, GLfloat) -> IO ()
vertex3f (x, y, z) = vertex $ Vertex3 x y z
 

--kwadrat wypełniony w środku
square :: GLfloat -> IO ()
square w = renderPrimitive Quads $ mapM_ vertex3f
  [ ( w, w, 0), ( w, -w,0), ( -w,-w,0), ( -w,w, 0)]

--tylko obwód kwadratu
square' :: GLfloat -> IO ()
square' w = renderPrimitive LineLoop $ mapM_ vertex3f
  [ ( w, w, 0), ( w, -w,0), ( -w,-w,0), ( -w,w, 0)]

--brzegi planszy, g->grubość brzegu
board:: GLfloat -> IO ()
board g= renderPrimitive Quads $ mapM_ vertex3f
    [(-0.5,-1,0),(-0.5-g,-1,0),(-0.5-g,1,0),(-0.5,1,0),
    (0.5,-1,0),(0.5+g,-1,0),(0.5+g,1,0),(0.5,1,0)]