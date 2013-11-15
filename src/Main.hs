import Snap

-- | The Memoise type identifies our application and holds anything our snaplet needs to function.
data Memoise
  = Memoise { } -- Right now, our application has no state variables.  Later, this will contain things like snaplets and state variables that our app needs.

-- | The indexHandler will be invoked whenever someone accesses the root URL, "/".
indexHandler :: Handler Memoise Memoise ()
indexHandler = writeText "Hello, world!"

-- | Build a new Memoise snaplet.
memoiseInit :: SnapletInit Memoise Memoise
memoiseInit = makeSnaplet "memoise" "The world's laziest hyperlink shortener" Nothing $ do
  addRoutes [("", indexHandler)]
  return $ Memoise { }

main :: IO ()
main = do
  (_, site, _) <- runSnaplet Nothing memoiseInit -- Initialize a Memoise snaplet
  quickHttpServe site -- Start the Snap server
