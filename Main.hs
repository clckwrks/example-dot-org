{-# LANGUAGE FlexibleContexts, OverloadedStrings #-}
module Main where

import Clckwrks.URL
import Clckwrks.Admin.Template
import Clckwrks.Monad
import Clckwrks.Server
import Clckwrks.Plugin
import Control.Applicative ((<$>))
import Control.Monad.Trans
import BootstrapTheme
import qualified Data.Map as Map
import qualified Data.Text as Text
import Happstack.Server
import Web.Plugin.Core

clckwrksConfig :: ClckwrksConfig
clckwrksConfig = ClckwrksConfig
    { clckHostname        = "localhost"
    , clckHidePort        = False
    , clckPort            = 8000
    , clckJQueryPath      = ""
    , clckJQueryUIPath    = ""
    , clckJSTreePath      = ""
    , clckJSON2Path       = ""
    , clckThemeDir        = ""
    , clckPluginDir       = Map.empty
    , clckStaticDir       = "../clckwrks/static"
    , clckTopDir          = Nothing
    , clckEnableAnalytics = False
    , clckInitHook        = initHook
    }

main :: IO ()
main = simpleClckwrks clckwrksConfig

initHook :: ClckState
         -> ClckwrksConfig
         -> IO (ClckState, ClckwrksConfig)
initHook clckState cc =
    do let p = plugins clckState
       initPlugin p "" clckPlugin
       setTheme p (Just theme)
       return (clckState, cc)
