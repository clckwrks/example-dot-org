{-# LANGUAGE FlexibleContexts, PackageImports, OverloadedStrings #-}
module Main where

import Clckwrks            (ClckwrksConfig(..), ClckState, plugins)
import Clckwrks.GetOpts    (parseArgs, clckwrksOpts)
import Clckwrks.Server     (simpleClckwrks)
import Clckwrks.Plugin     (clckPlugin)
import Data.Text           (Text)
import Web.Plugins.Core    (initPlugin, setTheme)
import System.Environment  (getArgs)
-- we use 'PackageImports' because the 'Theme' module is supplied by multiple packages
import "clckwrks-theme-bootstrap" Theme (theme)

------------------------------------------------------------------------------
-- ClckwrksConfig
------------------------------------------------------------------------------

-- | default configuration. Most of these options can be overridden on
-- the command-line accept for 'clckInitHook'.
clckwrksConfig :: ClckwrksConfig
clckwrksConfig = ClckwrksConfig
    { clckHostname        = "localhost"  -- hostname of the server
    , clckHidePort        = False        -- should the port number be used in generated URLs
    , clckPort            = 8000         -- port to listen on
    , clckTLS             = Nothing      -- disable TLS by default
    , clckJQueryPath      = "../jquery"  -- directory containing 'jquery.js'
    , clckJQueryUIPath    = ""           -- directory containing 'jquery.js'
    , clckJSTreePath      = "../jstree"  -- directory containing 'jquery.jstree.js'
    , clckJSON2Path       = "../json2"   -- directory containing 'json2.js'
    , clckTopDir          = Nothing      -- directory to store database, uploads, and other files
    , clckEnableAnalytics = False        -- enable Google Analytics
    , clckInitHook        = initHook     -- init hook that loads theme and plugins
    }

------------------------------------------------------------------------------
-- initHook
------------------------------------------------------------------------------

-- | This 'initHook' is used as the 'clckInitHook' field in
-- 'ClckwrksConfig'.
--
-- It will be called automatically by 'simpleClckwrks'. This hook
-- provides an opportunity to explicitly load a theme and some
-- plugins.
--
-- Note that the we generally always init 'clckPlugin' here.
initHook :: Text           -- ^ baseURI, e.g. http://example.org
         -> ClckState      -- ^ current 'ClckState'
         -> ClckwrksConfig -- ^ the 'ClckwrksConfig'
         -> IO (ClckState, ClckwrksConfig)
initHook baseURI clckState cc =
    do let p = plugins clckState
       _mError <- initPlugin p "" clckPlugin
       setTheme p (Just theme)
       return (clckState, cc)

------------------------------------------------------------------------------
-- main
------------------------------------------------------------------------------

main :: IO ()
main =
    do args <- getArgs
       f    <- parseArgs (clckwrksOpts clckwrksConfig) args
       simpleClckwrks =<< f clckwrksConfig
