module Main (main) where

import           Data.Default                         (def)
import           GHC.IO.Handle                        (hFlush)
import qualified Network.Wai                          as W
import qualified Network.Wai.Application.Static       as W
import           Network.Wai.Handler.Warp             as Warp
import           Network.Wai.Middleware.RequestLogger as W
import           System.IO                            (stdout)


port :: Int
port = 8180

main :: IO ()
main = do
    logger <- W.mkRequestLogger def
    putStrLn $ "Serving on localhost:" <> show port
    hFlush stdout
    let app = logger static
    Warp.run port app

static :: W.Application
static = W.staticApp (W.defaultWebAppSettings ".")
