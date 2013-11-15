import Snap

site = writeText "Hello, world!"

main = quickHttpServe site
