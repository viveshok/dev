
import XMonad
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeys)

-- mod1Mask -> left alt (option on mac)
-- mod4Mask -> (command on mac)
myModMask = mod1Mask

myExtraWorkspaces = [(xK_F1, "F1"), (xK_F2, "F2"), (xK_F3, "F3"), (xK_F4, "F4"), (xK_F5, "F5"), (xK_F6, "F6"),
                     (xK_F7, "F7"), (xK_F8, "F8"), (xK_F9, "F9"), (xK_F10, "F10"), (xK_F11, "F11"), (xK_F12, "F12")]

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] ++ (map snd myExtraWorkspaces)

myAdditionalKeys =
    [
        ((myModMask, key), (windows $ W.greedyView ws))
        | (key, ws) <- myExtraWorkspaces
    ] ++ [
        ((myModMask .|. shiftMask, key), (windows $ W.shift ws))
        | (key, ws) <- myExtraWorkspaces
    ]

main = do
    xmonad $ defaultConfig { startupHook = setWMName "LG3D",
                             terminal = "xterm",
                             workspaces = myWorkspaces,
                             modMask = myModMask,
			     borderWidth = 2
                           } `additionalKeys` myAdditionalKeys

