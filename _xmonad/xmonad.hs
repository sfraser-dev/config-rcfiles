-- xmon.hs.template (Example config file) from
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive/Template_xmonad.hs_%280.9%29

--Minimal XFCE config for xmonad. Using this as a base
-- and then addding in all the other commands from the
-- large config template above
-- http://www.haskell.org/haskellwiki/Xmonad/Using_xmonad_in_XFCE#Using_XMonad.Config.Xfce

-- Xmobar from
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive/John_Goerzen%27s_Configuration
-- Note: if I put lowerOnStart = True, then xmobar wouldn't come up (I am running xmobar 0.14, 0.9+ is being mentioned, 
-- I am having trouble with Run StdinReader, it can be run, but when I put it in the template it complains and doesn't load xmobar)
-- So I also used another config file (from Ubuntu user) that didn't have StdinReader.
-- Can start xmobar in here (at bottom, after "main = do") or
-- in .xinitrc before starting xfce:
-- /usr/bin/xmobar /home/stew/.xmobarrc
-- Note: I got xmobar from ubuntu software center, I got
-- xmonad from ubuntu software center
-- Nice: Align xmobar to the right, 75% width. Can then set the xfce panel left aligned @25% width, both along the top.
-- Xfce save session on logout, have xfce app menu, visable workspaces as well as status indicators and launchers.

-- In xfce example file
import XMonad
import qualified Data.Map as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
-- In generic template file
import System.Exit
import qualified XMonad.StackSet as W
import XMonad.Layout.Maximize
-- Adding my own
import XMonad.Layout.Spiral
import XMonad.Layout.SimpleFloat
import XMonad.Util.Run(spawnPipe) -- For starting xmobar 
import System.IO

import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.SimpleFloat
 
 
--myTerminal = "terminator"
myTerminal = "xfce4-terminal"
myModMask = mod4Mask
 
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [
      -- toggle struts (panels) in view / hidder
      ((modMask, xK_b), sendMessage ToggleStruts)
    , ((modMask .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    -- Restart xmonad
    , ((modMask , xK_q ), restart "xmonad" True)
    -- launch a terminal
    , ((modMask .|. shiftMask, xK_Return), spawn myTerminal)


    , ((controlMask .|. mod1Mask, xK_f ), spawn "firefox")
    , ((controlMask .|. mod1Mask, xK_m ), spawn "midori")
    , ((controlMask .|. mod1Mask, xK_g ), spawn "chromium-browser")
    , ((controlMask .|. mod1Mask, xK_x ), spawn "xmenud.py")
    , ((controlMask .|. mod1Mask, xK_h ), spawn "thunar")
    , ((controlMask .|. mod1Mask, xK_t ), spawn "xfce4-terminal")
    , ((controlMask .|. mod1Mask, xK_v ), spawn "terminator")
    , ((controlMask .|. mod1Mask, xK_w ), spawn "terminator -p light")
    , ((controlMask .|. mod1Mask, xK_l ), spawn "xscreensaver-command -lock")
    , ((controlMask .|. mod1Mask, xK_e ), spawn "gedit")
    , ((mod4Mask.|. mod1Mask, xK_e ), spawn "gvim")
    , ((controlMask .|. mod1Mask, xK_c ), spawn "speedcrunch")
    

    -- launch gmrun (using _r wasn't working
    -- conflicts with Xinerama screen switch?
    -- launch dmenu
    , ((modMask, xK_p ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    --, ((modMask .|. shiftMask, xK_p ), spawn "gmrun")
    , ((modMask .|. shiftMask, xK_p ), spawn "gmrun")

    -- close focused window
    , ((modMask .|. shiftMask, xK_c ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask, xK_space ), sendMessage NextLayout)

    -- Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask, xK_n ), refresh)

    -- Move focus to the next window
    , ((modMask, xK_Tab ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask, xK_j ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask, xK_k ), windows W.focusUp )

    -- Move focus to the master window
    , ((modMask .|. shiftMask, xK_m ), windows W.focusMaster )

    -- Maximize the focused window temporarily
    , ((modMask, xK_m ), withFocused $ sendMessage . maximizeRestore)

    -- Swap the focused window and the master window
    , ((modMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )

    -- Shrink the master area
    , ((modMask, xK_h ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask, xK_l ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask, xK_t ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modMask , xK_b ),

    -- Quit xmonad
    --, ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    --, ((modMask .|. shiftMask, xK_q ), spawn "xfce4-session-logout")
    , ((modMask .|. shiftMask, xK_q ), spawn "sudo pkill X")

    -- Restart xmonad
    , ((modMask , xK_q ), restart "xmonad" True)

    -- to hide/unhide the panel
    , ((modMask , xK_b), sendMessage ToggleStruts)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
        --, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    -- or use alt key (mod1Mask instead of modMask (windows key), easier when using terminator
    [((m .|. mod1Mask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
        --, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    -- or use alt key (mod1Mask instead of modMask (windows key), easier when using terminator
    [((m .|. mod1Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--myLayout = tiled ||| Mirror tiled ||| Full ||| spiral (6/7)
myLayout = tiled ||| Mirror tiled ||| Full ||| simpleFloat
--myLayout = tiled ||| simpleFloat ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    -- Testing and working with terminator
    --, className =? "Terminator"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = M.empty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
--myLogHook = return ()
--myLogHook = M.empty

myLogHook dest = dynamicLogWithPP defaultPP { ppOutput = hPutStrLn dest
                                           ,ppVisible = wrap "(" ")"
                                            }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
--myStartupHook = return ()
myStartupHook = M.empty


main = do 
        xmproc <- spawnPipe "/usr/bin/xmobar /home/stewart/.xmobarrc"
        xmonad defaultConfig
              { 
                modMask    = myModMask
              , keys       = myKeys
              --, manageHook = manageDocks <+> manageHook defaultConfig
              , manageHook = manageDocks <+> myManageHook
              --, layoutHook = avoidStruts $ layoutHook defaultConfig
              , layoutHook = avoidStruts $ myLayout
	          , mouseBindings = myMouseBindings
              -- As stated in Event handling section,
              -- using ewmhDesktopsXXXX for XFCE
              -- EwmhDesktop (this was in xmond.hs.xfce)
              , handleEventHook = ewmhDesktopsEventHook
              , startupHook = ewmhDesktopsStartup
              --, logHook    = ewmhDesktopsLogHook
              , logHook    = myLogHook xmproc
              }
