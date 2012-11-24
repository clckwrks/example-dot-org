{-# LANGUAGE FlexibleContexts, OverloadedStrings #-}
module Main where

import Clckwrks            (ClckwrksConfig(..), ClckState, plugins)
import Clckwrks.Server     (simpleClckwrks)
import Clckwrks.Plugin     (clckPlugin)
import BootstrapTheme      (theme)
import Data.Text           (Text)
import Web.Plugins.Core    (initPlugin, setTheme)

clckwrksConfig :: ClckwrksConfig
clckwrksConfig = ClckwrksConfig
    { clckHostname        = "localhost"
    , clckHidePort        = False
    , clckPort            = 8000
    , clckJQueryPath      = ""
    , clckJQueryUIPath    = ""
    , clckJSTreePath      = ""
    , clckJSON2Path       = ""
    , clckStaticDir       = "../clckwrks/static"
    , clckTopDir          = Nothing
    , clckEnableAnalytics = False
    , clckInitHook        = initHook "http://localhost:8000"
    }

main :: IO ()
main = simpleClckwrks clckwrksConfig

initHook :: Text
         -> ClckState
         -> ClckwrksConfig
         -> IO (ClckState, ClckwrksConfig)
initHook baseURI clckState cc =
    do let p = plugins clckState
       _mError <- initPlugin p baseURI clckPlugin
       setTheme p (Just theme)
       return (clckState, cc)
