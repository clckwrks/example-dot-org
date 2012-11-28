{-# LANGUAGE FlexibleContexts, OverloadedStrings #-}
module Main where

import Clckwrks            (ClckwrksConfig(..), ClckState, plugins)
import Clckwrks.GetOpts    (parseArgs)
import Clckwrks.Server     (simpleClckwrks)
import Clckwrks.Plugin     (clckPlugin)
import BootstrapTheme      (theme)
import Data.Text           (Text)
import Web.Plugins.Core    (initPlugin, setTheme)
import System.Environment  (getArgs)

------------------------------------------------------------------------------
-- ClckwrksConfig
------------------------------------------------------------------------------

-- | default configuration. Most of these options can be overridden on
-- the command-line accept for 'clckInitHook'.
clckwrksConfig :: ClckwrksConfig
clckwrksConfig = ClckwrksConfig
    { clckHostname        = "localhost"
    , clckHidePort        = False
    , clckPort            = 8000
    , clckJQueryPath      = ""
    , clckJQueryUIPath    = ""
    , clckJSTreePath      = ""
    , clckJSON2Path       = ""
    , clckTopDir          = Nothing
    , clckEnableAnalytics = False
    , clckInitHook        = initHook
    }

------------------------------------------------------------------------------
-- ClckwrksConfig
------------------------------------------------------------------------------

initHook :: Text
         -> ClckState
         -> ClckwrksConfig
         -> IO (ClckState, ClckwrksConfig)
initHook baseURI clckState cc =
    do let p = plugins clckState
       _mError <- initPlugin p baseURI clckPlugin
       setTheme p (Just theme)
       return (clckState, cc)


------------------------------------------------------------------------------
-- main
------------------------------------------------------------------------------

main :: IO ()
main = simpleClckwrks clckwrksConfig

