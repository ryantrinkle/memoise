import Snap
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple
import Snap.Util.FileServe
import Snap.Extras.CoreUtils
import Snap.Extras.TextUtils
import Control.Lens
import Data.Text
import Data.Text.Encoding
import Data.Monoid
import Heist
import Heist.Interpreted
import Network.URI hiding (query)

data Memoise
  = Memoise { _heist :: Snaplet (Heist Memoise)
            , _db :: Snaplet Postgres
            , _mainTextboxContents :: Maybe Text
            }
makeLenses ''Memoise

instance HasHeist Memoise where
  heistLens = subSnaplet heist

instance HasPostgres (Handler Memoise Memoise) where
  getPostgresState = with db get

canonicalizeUrl :: Text -> Maybe URI
canonicalizeUrl rawUrl =
  let url = unpack rawUrl
      url' = if isAbsoluteURI url
             then url
             else "http://" <> url
  in parseURI $ normalizeCase $ normalizePathSegments $ normalizeEscape url'

getUrlId :: URI -> Handler Memoise Memoise Integer
getUrlId uri = do
  let url = showT uri
  existingResults <- query "SELECT id FROM urls WHERE url = ?" (Only url)
  case existingResults of
    (Only urlId) : _ -> return urlId
    [] -> do
      [Only urlId] <- query "INSERT INTO urls (url) VALUES (?) RETURNING (id)" (Only url)
      return urlId

indexHandler :: Handler Memoise Memoise ()
indexHandler = do
  mUrl <- getParam "url"
  case mUrl of
    Just url -> do
      case canonicalizeUrl (decodeUtf8 url) of
        Just uri -> do
          urlId <- getUrlId uri
          mainTextboxContents .= Just ("http://memoi.se/" <> showT urlId)
        Nothing -> mainTextboxContents .= Just "Invalid URL"
      render "index"
    Nothing -> render "index"

redirectHandler :: Handler Memoise Memoise ()
redirectHandler = do
  mUrlId :: Maybe Integer <- readMayParam "urlId"
  case mUrlId of
    Nothing -> redirect "/"
    Just urlId -> do
      results <- query "SELECT url FROM urls WHERE id = ?" (Only urlId)
      case results of
        (Only url) : _ -> redirect url
        [] -> redirect "/"

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
  d <- nestSnaplet "db" db pgsInit
  addRoutes [ ("static", serveDirectory "static")
            , (":urlId", redirectHandler)
            , ("", indexHandler)
            ]
  return $ Memoise { _heist = h
                   , _db = d
                   , _mainTextboxContents = Nothing
                   }

main :: IO ()
main = do
  (_, site, _) <- runSnaplet Nothing memoiseInit
  quickHttpServe site
