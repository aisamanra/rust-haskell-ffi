{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign
import Foreign.C.Types
import Foreign.ForeignPtr

-- Wrapping the fact.rs module...
foreign import ccall "fact"
  c_fact :: CULong -> CULong

fact :: Int -> Int
fact = fromIntegral . c_fact . fromIntegral

-- A little bit more work to wrap the point.rs module; I also
-- don't bother to write a proper representation for the
-- underlying Point, which ought to be an instance of Storable
-- if we want to manipulate it in Rust-land or do pointer
-- arithmetic.
type Point = ForeignPtr PointRepr
data PointRepr

foreign import ccall safe "mk_point"
  mk_point :: CULong -> CULong -> IO (Ptr PointRepr)

foreign import ccall safe "add_point"
  add_point :: Ptr PointRepr -> Ptr PointRepr -> IO ()

foreign import ccall safe "print_point"
  print_point :: Ptr PointRepr -> IO ()

foreign import ccall safe "&free_point"
  free_point :: FunPtr (Ptr PointRepr -> IO ())

-- We use the free_point function as a finalizer when we
-- create a point; this lets the Haskell GC take over for
-- us.
mkPoint :: Int -> Int -> IO Point
mkPoint x y = do
  ptr <- mk_point (fromIntegral x) (fromIntegral y)
  newForeignPtr free_point ptr

-- This modifies the first point in-place.
addPoint :: Point -> Point -> IO ()
addPoint x y = withForeignPtr x (\ x' ->
               withForeignPtr y (\ y' ->
                 add_point x' y'))

-- This prints its argument
printPoint :: Point -> IO ()
printPoint p = withForeignPtr p print_point

-- Testing the point functions; we don't need to free
-- explicitly because GHC should call our finalizer
points :: IO ()
points = do
  a <- mkPoint 2 3
  b <- mkPoint 1 1
  addPoint a b
  printPoint a

-- And here we go!
main :: IO ()
main = do
  putStr "fact(5) = "
  print (fact 5)
  points
