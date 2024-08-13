module Main (main) where



-- |-----------------------------------------------------------------------------
-- | IMPORTS

import System.Exit
import System.IO

import Text.Printf

import Data.Monoid
import Control.Monad

import XMonad
import XMonad.Config.Desktop

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.InsertPosition

-- Actions
import XMonad.Actions.DynamicProjects
import XMonad.Actions.UpdatePointer
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS

-- Layouts
import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.Circle
import XMonad.Layout.Column
import XMonad.Layout.Fullscreen
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Named
import XMonad.Layout.IfMax
import XMonad.Layout.DwmStyle
import XMonad.Layout.LayoutModifier (ModifiedLayout)


-- Prompt
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell

-- Utilities
import XMonad.Util.EZConfig
import XMonad.Util.Font
import XMonad.Util.SpawnOnce
import XMonad.Util.Run

-- StackSet
import XMonad.StackSet as W



-- |-----------------------------------------------------------------------------
-- | MAIN

main :: IO ()
main = do
  xmonad
    . docks
    . ewmh
    =<<  myStatusBar (myConfig `additionalKeysP` myKeybindings)



-- |-----------------------------------------------------------------------------
-- | CONFIG

myConfig = ewmh $ def {
  -- Basic stuff
  terminal           = shell,
  focusFollowsMouse  = True,
  modMask            = mod4Mask,

  -- Theming
  normalBorderColor  = myBorderColor,
  focusedBorderColor = myFocusedBorderColor,
  borderWidth        = myBorderWidth,

  -- hooks, layouts
  layoutHook         = myLayoutHook,
  manageHook         = myManageHook,
  logHook            = updatePointer (0.95,0.95) (0,0),
  startupHook        = setWMName "XMonad"
                       -- Launch startup programs by alias here
                       >> spawnOnce fixScreens
                       >> spawnOnce cursor
                       >> spawnOnce inputMethod
  }



-- |-----------------------------------------------------------------------------
-- | LAYOUT
-- |
-- | This layout configuration uses 4 primary layouts: 'ThreeColMid' (suitable
-- | for ultrawide displays), 'ResizableTall', 'BinarySpacePartition', and 'Grid'.
-- | Portrait-mode variants of 'tall' and 'threeColumn' are also provided.
-- |
-- | ThreeColMid and ResizableTall both come with mirrored, reflected variants
-- | which put the master pane at the bottom of the screen (in ThreeColMid this
-- | is only true for the 2-window case), suitable for ultrawide displays
-- | rotated to a portrait orientation.
-- |
-- | You can also use 'M-<Esc>' to toggle between the current layout and fullscreen,
-- | and 'M-b' to toggle xmobar visibility.

myLayoutHook = smartBorders . avoidStruts $ desktopLayoutModifiers $ toggleLayouts (noBorders Full) myLayouts
  where
    myLayouts =
          tall
      ||| threeColumn
      ||| bsp
      ||| grid

full = named "Fullscreen"
       $ noBorders (fullscreenFull Full)

tall = named "Tall"
       $ reflectHoriz
       $ IfMax 1 full
       $ ResizableTall 1 (1/100) (3/5) []

vertTall = named "VertTall"
           $ Mirror tall

threeColumn = named "ThreeCol"
              $ reflectHoriz
              $ IfMax 1 full
              $ (ThreeColMid 1 (3/100) (1/2))

vertThreeColumn = named "VertThreeCol"
                  $ Mirror threeColumn

bsp = named "Binary"
      $ IfMax 1 full
      $ reflectVert
      $ Mirror emptyBSP

grid = named "Grid"
       $ reflectVert
       $ Grid



-- |-----------------------------------------------------------------------------
-- | PROMPT

myPrompt :: XPConfig
myPrompt = def
   { position          = Bottom
   , alwaysHighlight   = True
   , fgColor           = myPromptFgColor
   , bgColor           = myPromptBgColor
   , font              = promptFont
   , promptBorderWidth = 0
   , height            = 20
   , defaultText       = " "
   , historySize       = 5
   , maxComplRows      = Just 1
   }



-- |-----------------------------------------------------------------------------
-- | XMOBAR

myStatusBar = statusBar "xmobar" myPP strutsToggle
  where
    myPP = def
      { ppCurrent = xmobarColor myCurrentColor ""
      , ppVisible = xmobarColor myVisibleColor ""
      , ppHidden = xmobarColor myHiddenColor ""
      , ppHiddenNoWindows = xmobarColor myEmptyColor ""
      , ppUrgent = xmobarColor myUrgentColor "" . xmobarStrip
      , ppLayout = xmobarColor myLayoutColor ""
      , ppWsSep = "  "
      , ppSep = xmobarColor mySepColor "" "   |   "
      , ppTitle = xmobarColor myTitleColor "" . shorten 120 . trim
      }
    strutsToggle XConfig {modMask = modm} = (modm, xK_b)



-- |-----------------------------------------------------------------------------
-- | WINDOW BEHAVIOR
-- |
-- | Use the "xprop WM_CLASS" tool to get strings for the className matches.

myManageHook :: ManageHook
myManageHook = composeOne
  [ isFullscreen                                          -?> doFullFloat
  , title    =? "Screen Sharing Tracker"                  -?> doFloatAt 0.4 0 -- jitsi-meet-electron pops this up while screen sharing
  , isDialog <&&> className =? ".blueman-applet-wrapped"  -?> doFloatAt 0.4 0 -- bluetooth connections
  , isDialog                                              -?> doCenterFloat
  , isDialog <&&> className =? "Firefox"                  -?> doCenterFloat
  , isInProperty
      "_NET_WM_WINDOW_TYPE"
      "_NET_WM_WINDOW_TYPE_SPLASH"
    -?> doCenterFloat
  , transience
  ]
  <+> manageDocks



-- |-----------------------------------------------------------------------------
-- | KEYBINDINGS

myKeybindings :: [(String, X ())]
myKeybindings =
  [
  -- Layouts
    ("M-<Space>"     , sendMessage NextLayout)
  , ("M-p"           , spawn launcher)
  , ("M-<Esc>"       , sendMessage (Toggle "Full"))
  , ("M-h"           , sendMessage Expand)
  , ("M-l"           , sendMessage Shrink)

  -- Applications
  , ("M-S-e"         , spawn Main.emacs)
  , ("M-S-f"         , spawn browser)
  , ("M-S-<Return>"  , spawn shell)

  -- Prompt
  , ("M-S-p"         , shellPrompt myPrompt)

  -- Session
  , ("M-S-q"         , confirmPrompt myPrompt "exit" (io exitSuccess))
  , ("M-S-l"         , spawn suspend)
  , ("M-q"           , broadcastMessage ReleaseResources
                       >> restart "xmonad" True)
  ]



-- |-----------------------------------------------------------------------------
-- | ALIASES

fixScreens :: String
fixScreens = "./.screenlayout/new.sh"

cursor :: String
cursor = "xsetroot -cursor_name left_ptr"

inputMethod :: String
inputMethod = "fcitx"

emacs :: String
emacs = "emacsclient -nc"

browser :: String
browser = "firefox"

launcher :: String
launcher = "rofi -combi-modi run,drun -show combi -modi combi"
-- launcher = "hmenu -f .config/hmenu/history -- -i -f -nb '#282A36' -nf '#BBBBBB' -sb '#8BE9FD' -sf '#000000' -fn 'Inconsolata Regular-10'"

suspend :: String
suspend = "systemctl suspend"

shell :: String
shell = "kitty"


-- |-----------------------------------------------------------------------------
-- | Theme

-- Font definitions
mkSansMono :: String -> String
mkSansMono size = "Fira Sans Mono:antialias=true:size=" ++ size

mkWQYZH :: String -> String
mkWQYZH size = "WenQuanYi Zen Hei:antialias=true:size=" ++ size

boldFont :: String -> String
boldFont font = font ++ ":bold"

combineFonts :: String -> String -> String
combineFonts f1 f2 = f1 ++ "," ++ f2

mkXmobarFontString :: String -> String
mkXmobarFontString size =  "xft:" ++ combineFonts (boldFont $ mkSansMono size) (boldFont $ mkWQYZH size)

xmobarFont :: String
xmobarFont =  mkXmobarFontString "16"

promptFont :: String
promptFont = mkXmobarFontString "10"

-- Color definitions
myPromptBgColor         = "#2e3440" -- nord0
myPromptFgColor         = "#eceff4" -- nord6
myBorderColor           = "#40464b" -- dark gray
myFocusedBorderColor    = "#839cad" -- light gray
myCurrentColor          = "#bf616a" -- nord11
myEmptyColor            = "#4c4c4c" -- dark gray but lighter than xmobar bg
myHiddenColor           = "#8fbcbb" -- nord7
myLayoutColor           = "#5e81ac" -- nord10
myUrgentColor           = "#bf616a" -- nord11
myTitleColor            = "#eceff4" -- nord6
mySepColor              = "#81a1c1" -- nord10
myVisibleColor          = "#ebcb8b" -- nord13

-- Window borders
myBorderWidth = 2
