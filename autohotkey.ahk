#SingleInstance Force

; 短按CapsLock 长按Ctrl
*CapsLock:: {
    if KeyWait("CapsLock", "T" . 0.15) {
        SetCapsLockState !GetKeyState("CapsLock", "T")
    } else {
        Send "{Ctrl Down}"
        KeyWait("CapsLock")
        Send "{Ctrl Up}"
    }
}

; 方向键
RShift & W:: Send "{Up}"
RShift & A:: Send "{Left}"
RShift & S:: Send "{Down}"
RShift & D:: Send "{Right}"

; 桌面切换
^#H::Send "^#{Left}"
^#L::Send "^#{Right}"
