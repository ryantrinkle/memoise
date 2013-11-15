import Snap

site :: Snap ()
site = writeText "Hello, world!"

main :: IO ()
main = quickHttpServe site
