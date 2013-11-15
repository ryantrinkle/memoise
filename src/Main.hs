import Snap
import Snap.Snaplet.Heist
import Snap.Util.FileServe
import Control.Lens
import Data.Text
import Data.Text.Encoding
import Data.Monoid
import Heist
import Heist.Interpreted

data Memoise
  = Memoise { _heist :: Snaplet (Heist Memoise)
            , _mainTextboxContents :: Maybe Text
            }
makeLenses ''Memoise

instance HasHeist Memoise where
  heistLens = subSnaplet heist

indexHandler :: Handler Memoise Memoise ()
indexHandler = do
  mUrl <- getParam "url"
  case mUrl of
    Just url -> do
      mainTextboxContents .= Just "URL Received.  What next?"
      render "index"
    Nothing -> render "index"

mainTextboxAttributeSplice :: AttrSplice (Handler Memoise Memoise)
mainTextboxAttributeSplice _ = do
  mContents <- lift $ use mainTextboxContents
  case mContents of
    Just contents -> return [("value", contents)]
    Nothing -> return []

memoiseInit :: SnapletInit Memoise Memoise
memoiseInit = makeSnaplet "memoise" "The world's laziest hyperlink shortener" Nothing $ do
  h <- nestSnaplet "heist" heist $ heistInit "templates"
  modifyHeistState $ bindAttributeSplices [("main-textbox", mainTextboxAttributeSplice)]
  addRoutes [ ("static", serveDirectory "static")
            , ("", indexHandler)
            ]
  return $ Memoise { _heist = h
                   , _mainTextboxContents = Nothing
                   }

main :: IO ()
main = do
  (_, site, _) <- runSnaplet Nothing memoiseInit
  quickHttpServe site
