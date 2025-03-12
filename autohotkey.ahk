CapsLock:: {
    Send "{Ctrl Down}"
}
CapsLock Up:: {
    Send "{Ctrl Up}"
    ;if (A_PriorKey == "CapsLock" and A_TimeSincePriorHotKey < 300) {
    if (A_TimeSincePriorHotKey < 150) {
        SetCapsLockState !GetKeyState("CapsLock", "T")
    }
}

RShift & W:: {
    Send "{Up}"
}
RShift & A:: {
    Send "{Left}"
}
RShift & S:: {
    Send "{Down}"
}
RShift & D:: {
    Send "{Right}"
}
