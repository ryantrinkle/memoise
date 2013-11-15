import Snap
import Snap.Snaplet.Heist
import Snap.Util.FileServe
import Control.Lens

data Memoise
  = Memoise { _heist :: Snaplet (Heist Memoise)
            }
makeLenses ''Memoise

instance HasHeist Memoise where
  heistLens = subSnaplet heist

indexHandler :: Handler Memoise Memoise ()
indexHandler = render "index"

memoiseInit :: SnapletInit Memoise Memoise
memoiseInit = makeSnaplet "memoise" "The world's laziest hyperlink shortener" Nothing $ do
  h <- nestSnaplet "heist" heist $ heistInit "templates"
  addRoutes [ ("static", serveDirectory "static")
            , ("", indexHandler)
            ]
  return $ Memoise { _heist = h
                   }

main :: IO ()
main = do
  (_, site, _) <- runSnaplet Nothing memoiseInit
  quickHttpServe site
