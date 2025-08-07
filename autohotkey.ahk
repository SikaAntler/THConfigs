#SingleInstance Force

; 短按CapsLock 长按Ctrl
CapsLock:: Send "{Ctrl Down}"
CapsLock Up:: {
    Send "{Ctrl Up}"
    ;if (A_PriorKey == "CapsLock" and A_TimeSincePriorHotKey < 300) {
    if (A_TimeSincePriorHotKey < 150) {
        SetCapsLockState !GetKeyState("CapsLock", "T")
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
