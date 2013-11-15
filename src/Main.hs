import Snap
import Snap.Snaplet.Heist
import Control.Lens

-- | The Memoise type identifies our application and holds anything our snaplet needs to function.
data Memoise
  = Memoise { _heist :: Snaplet (Heist Memoise)
            }
makeLenses ''Memoise

instance HasHeist Memoise where
  heistLens = subSnaplet heist

-- | The indexHandler will be invoked whenever someone accesses the root URL, "/".
indexHandler :: Handler Memoise Memoise ()
indexHandler = render "index"

-- | Build a new Memoise snaplet.
memoiseInit :: SnapletInit Memoise Memoise
memoiseInit = makeSnaplet "memoise" "The world's laziest hyperlink shortener" Nothing $ do
  h <- nestSnaplet "heist" heist $ heistInit "templates"
  addRoutes [("", indexHandler)]
  return $ Memoise { _heist = h
                   }

main :: IO ()
main = do
  (_, site, _) <- runSnaplet Nothing memoiseInit -- Initialize a Memoise snaplet
  quickHttpServe site -- Start the Snap server
