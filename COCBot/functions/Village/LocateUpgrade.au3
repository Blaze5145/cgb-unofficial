Func LocateOneUpgrade($inum)
    Setlog("Upgrade Buildings will not work if Auto Wall Upgrade is used!", $COLOR_RED)
    Local $MsgBox
    While 1
        _CaptureRegion(0, 0, 860, 2)
      If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then
         SetLog("Locate Oops, prep screen 1st", $COLOR_BLUE)
         ZoomOut()
         Collect()
      EndIf
      $MsgBox = MsgBox($MB_CANCELTRYCONTINUE + $MB_TOPMOST, "Locate Upgrade", "Click Continue then click on your building to upgrade. Cancel if not available. Try again to start over.", 0, $frmBot)
      If $MsgBox = 11 Then
         $aUpgrades[$inum][0] = FindPos()[0]
         $aUpgrades[$inum][1] = FindPos()[1]
         If _Sleep(500) Then Return
         If $aUpgrades[$inum][0] >1 or $aUpgrades[$inum][1] >1 then GUICtrlSetImage($picUpgradeStatus[$inum], $hYellowLight)  ; Set GUI Status to Yellow showing ready for upgrade
      ElseIf $MsgBox = 10 Then
         ContinueLoop
      Else
         ExitLoop
      EndIf
      ClickP($TopLeftClient,2) ;Click Away to close windows
      ExitLoop
    WEnd
EndFunc ;==>> LocateOneUpgrade

Func CheckUpgrades()  ; Valdiate and determine the cost and type of the upgrade and change GUI boxes/pics to match

Local $MsgBox

$MsgBox = MsgBox($IDOK + $MB_ICONWARNING + $MB_TOPMOST, "Notice", "Keep Mouse OUT of BlueStacks Window While I Check Your Upgrades, Thanks!!", 0, $frmBot)
If _Sleep(1000) Then Return
If Not $MsgBox = 1 Then
    Setlog("Something weird happened in getting upgrade values, try again", $COLOR_RED)
    Return False
EndIf

For $iz = 0 to 3
    If $aUpgrades[$iz][0] <= 0 or $aUpgrades[$iz][1] <= 0  Then
        GUICtrlSetImage($picUpgradeStatus[$iz], $hRedLight) ; change indicator back to red showing location invalid
        GUICtrlSetState($chkbxUpgrade[$iz],$GUI_UNCHECKED) ; Change upgrade selection box to unchecked
        ContinueLoop
    EndIf

    If UpgradeValue($iz, $aUpgrades) = False then
        Setlog("Locate Upgrade #" & $iz + 1 & " Value Error, try again", $COLOR_RED)
        GUICtrlSetImage($picUpgradeStatus[$iz], $hRedLight) ; change indicator back to red showing location invalid
        GUICtrlSetData($txtUpgradeX[$iz], "")  ; Set GUI X Position to empty
        GUICtrlSetData($txtUpgradeY[$iz], "")  ; Set GUI Y Position to empty
        GUICtrlSetImage ($picUpgradeType[$iz], $hUpTypeBlank)
        ContinueLoop
    EndIf

    Switch $aUpgrades[$iz][3]  ;Set GUI Upgrade Type to match $aUpgrades variable
    Case "Gold"
        GUICtrlSetImage ($picUpgradeType[$iz], $hUpTypeGold)
    Case "Elixir"
        GUICtrlSetImage ($picUpgradeType[$iz], $hUpTypeElixir)
    Case "Dark"
        GUICtrlSetImage ($picUpgradeType[$iz], $hUpTypeDark)
    Case Else
        GUICtrlSetImage ($picUpgradeType[$iz], $hUpTypeBlank)
    EndSwitch
    GUICtrlSetState($chkWalls,$GUI_UNCHECKED) ; Turn off upgrade walls
    GUICtrlSetData($txtUpgradeX[$iz], $aUpgrades[$iz][0])  ; Set GUI X Position to match $aUpgrades variable
    GUICtrlSetData($txtUpgradeY[$iz], $aUpgrades[$iz][1])  ; Set GUI Y Position to match $aUpgrades variable
Next

    EndFunc  ;==>> CheckUpgrades

Func UpgradeValue($inum, ByRef $Upgrade) ;function to find the value and type of the upgrade.
    Local $inputbox, $iLoot
    Local $bOopsFlag = False

    If $Upgrade[$inum][0] <= 0 or $Upgrade[$inum][1] <= 0  Then return False
    $Upgrade[$inum][2] = 0 ; Clear previous upgrade value if run before
    $Upgrade[$inum][3] = "" ; Clear previous loot type if run before

    ClickP($TopLeftClient,2) ;Click Away to close windows
    SetLog("-$Upgrade #" & $inum + 1 & " Location =  " & "(" & $Upgrade[$inum][0] & "," & $Upgrade[$inum][1] & ")", $COLOR_PURPLE) ;Debug
    If _Sleep(500) Then Return

    Click($Upgrade[$inum][0], $Upgrade[$inum][1]) ;Select upgrade trained
    If _Sleep(800) Then Return

    Local $offColors[2][3] = [[0x854833, 35, 33], [0x2B2D1F, 76, 0]] ; 2nd pixel brown hammer, 3th pixel edge of button
    Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 615, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; Look for first white pixel of button
    If IsArray($ButtonPixel) = 0 Then ; If its not normal upgrade, then try to find Hero upgrade button
        Local $offColors[3][3] = [[0x854833, 35, 33], [0x000000, 66, 11], [0x2B2D1F, 76, 0]] ; 2nd pixel brown hammer, 3rd pixel black, 4th pixel edge of button
        Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 615, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; first white pixel of button
    EndIf

    If IsArray($ButtonPixel) Then
        ;Setlog("ButtonPixel = " & $ButtonPixel[0] &", " & $ButtonPixel[1], $COLOR_PURPLE)  ;Debug
        Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20) ; Click Upgrade Button
        If _Sleep(1000) Then Return

        _CaptureRegion()

        Select  ;Ensure the right upgrade window is open!
        Case _ColorCheck(_GetPixelColor(685, 150), Hex(0xE1090E, 6), 20) ; Check if the building Upgrade window is open
            If _ColorCheck(_GetPixelColor(351, 485), Hex(0xE0403D, 6), 20) Then  ; Check if upgrade requires upgrade to TH and can not be completed
                Setlog("Selection #" & $inum & " upgrade not available, need TH upgrade - Skipped!", $COLOR_RED)
                $Upgrade[$inum][0] = -1 ; Clear upgrade location value as it is invalid
                $Upgrade[$inum][1] = -1 ; Clear upgrade location value as it  is invalid
                $Upgrade[$inum][2] = 0 ; Clear upgrade value as it is invalid
                $Upgrade[$inum][3] = "" ; Clear upgrade type as it  is invalid
                ClickP($TopLeftClient,2) ;Click Away
                Return False
            EndIf
            If _ColorCheck(_GetPixelColor(487, 479), Hex(0xF0E950, 6), 20) Then $Upgrade[$inum][3] = "Gold" ;Check if Gold required
            If _ColorCheck(_GetPixelColor(490, 475), Hex(0xFF2AD7, 6), 20) Then $Upgrade[$inum][3] = "Elixir" ;Check if Elixir required

            $Upgrade[$inum][2] = Number(getOther(384, 475, "Upgrades")) ; Try to read white text.
            If $Upgrade[$inum][2] = "" then
;               $bOopsFlag = True  ; Uncomment this line as temporary fix to upgrade values not reading.
                $Upgrade[$inum][2] = Number(getOther(384, 475, "RedUpgrades")) ;read RED upgrade text = Not working!!!!
            EndIf

        Case _ColorCheck(_GetPixelColor(715, 151), Hex(0xE1090E, 6), 20) ; Check if the Hero Upgrade window is open
            If _ColorCheck(_GetPixelColor(400, 485), Hex(0xE0403D, 6), 20) Then  ; Check if upgrade requires upgrade to TH and can not be completed
                Setlog("Selection #" & $inum & " upgrade not available, need TH upgrade - Skipped!", $COLOR_RED)
                $Upgrade[$inum][0] = -1 ; Clear upgrade location value as it is invalid
                $Upgrade[$inum][1] = -1 ; Clear upgrade location value as it  is invalid
                $Upgrade[$inum][2] = 0 ; Clear upgrade value as it is invalid
                $Upgrade[$inum][3] = "" ; Clear upgrade type as it  is invalid
                ClickP($TopLeftClient,2) ;Click Away
                Return False
            EndIf
            If _ColorCheck(_GetPixelColor(575, 502), Hex(0x000000, 6), 20) Then $Upgrade[$inum][3] = "Dark" ;Redundant? Check if DE required

            $Upgrade[$inum][2] = Number(getOther(490, 483, "Upgrades")) ; Try to read white text if available.
            If $Upgrade[$inum][2] = "" then
                $bOopsFlag = True
                $Upgrade[$inum][2] = Number(getOther(490, 483, "RedUpgrades")) ;read RED upgrade text -- Not Working Yet!!!
            EndIf

        Case Else
            Setlog("Selected Upgrade Window Opening Error, try again", $COLOR_RED)
            $Upgrade[$inum][0] = -1 ; Clear upgrade location value as it is invalid
            $Upgrade[$inum][1] = -1 ; Clear upgrade location value as it  is invalid
            $Upgrade[$inum][2] = 0 ; Clear upgrade value as it is invalid
            $Upgrade[$inum][3] = "" ; Clear upgrade type as it  is invalid
            ClickP($TopLeftClient,2) ;Click Away
            Return False
         EndSelect
#comments-start
;Temp fix for upgrade value read problems if needed.
        If $Upgrade[$inum][3] <> "" and $bOopsFlag = True Then  ;check if upgrade type value to not waste time and for text read oops flag
            $iLoot = $Upgrade[$inum][2]
            If $iLoot = ""  Then $iLoot = 8000000
            $inputbox = InputBox("Text Read Error", "Enter the cost of the upgrade", $iLoot, "", -1, -1)
            If @error then Return False
            $Upgrade[$inum][2] = Int($inputbox)
            $msgbox = MsgBox($MB_YESNO, "Question", "Save copy of upgrade image for developer analysis?", 60)
            If $msgbox = $IDYES Then  ;  Debug purposes only :)
                SetLog("Taking approved snapshot for later review", $COLOR_PURPLE) ;Debug purposes only :)
                $Date = @MDAY & "." & @MON & "." & @YEAR
                $Time = @HOUR & "." & @MIN & "." & @SEC
                _CaptureRegion()
                _GDIPlus_ImageSaveToFile($hBitmap, $dirloots & "Upgrade_" & $Date & " at " & $Time & ".png")
                If _Sleep(1000) Then Return
            EndIf
        Endif
; End of fix
#comments-end
        If $Upgrade[$inum][2] = "" or $Upgrade[$inum][3] = "" Then ;report loot error if exists
            Setlog("Error finding loot info " & $inum & ", Loot = " & $Upgrade[$inum][2] & ", Type= " & $Upgrade[$inum][3], $COLOR_RED)
            $Upgrade[$inum][0] = -1 ; Clear upgrade location value as it is invalid
            $Upgrade[$inum][1] = -1 ; Clear upgrade location value as it  is invalid
            ClickP($TopLeftClient,2) ;Click Away
            Return False
        EndIf
        Setlog("UpgradeValue = " & $Upgrade[$inum][2] & " " & $Upgrade[$inum][3], $COLOR_PURPLE) ; debug & document cost of upgrade
    Else
        Setlog("Upgrade selection fail", $COLOR_RED)
        $Upgrade[$inum][0] = -1 ; Clear upgrade location value as it is invalid
        $Upgrade[$inum][1] = -1 ; Clear upgrade location value as it  is invalid
        ClickP($TopLeftClient,2) ;Click Away
        Return False
    EndIf
    ClickP($TopLeftClient,5) ;Click Away
    Return True
EndFunc   ;==>UpgradeValue