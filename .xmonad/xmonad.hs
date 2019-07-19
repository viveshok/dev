
import XMonad
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeys)

-- mod1Mask -> left alt (option on mac)
-- mod4Mask -> (command on mac)
myModMask = mod1Mask

myExtraWorkspaces = [(xK_0, "0"), (xK_minus, "-"), (xK_equal, "=")]
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

