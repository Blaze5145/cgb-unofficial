#cs
This file is part of ClashGameBot.

ClashGameBot is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ClashGameBot is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with ClashGameBot.  If not, see <http://www.gnu.org/licenses/>.
#ce
#cs ----------------------------------------------------------------------------
	 AutoIt Version: 3.3.6.1
	 This file was made to be used with software CoCgameBot v2.0
	 Author:         KnowJack

	 Script Function: LazyManV2 MOD
 CoCgameBot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
 CoCgameBot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 You should have received a copy of the GNU General Public License along with CoCgameBot.  If not, see ;<http://www.gnu.org/licenses/>.
 #ce ----------------------------------------------------------------------------
Func UpgradeIt4()

    Local $iz = 0
    Local $iUpgradeAction = -1
    Local $iMinDark = 2000 ;Reserve enough to make war troops?

    Setlog("LAZYMANV2 MOD, upgrade time!", $COLOR_BLUE)

; check to see if anything is enabled before wasting time.
    For $iz = 0 to 3
      If GUICtrlRead($chkbxUpgrade[$iz])= $GUI_CHECKED then
         $iUpgradeAction += 2^($iz+1)
      EndIf
   Next
   If $iUpgradeAction < 0 then Return False
   $iUpgradeAction = -1  ; Reset action

    ; Need to update village report function to skip statistics and extra messages not required using a bypass?
    VillageReport(True)  ; Get current loot available after training troops and update free builder status
    If $FreeBuilder <= 0 Then
        Setlog("No builder available for upgrades", $COLOR_RED)
        Return False
    EndIf

    For $iz = 0 to 3
        If GUICtrlRead($chkbxUpgrade[$iz]) = $GUI_UNCHECKED Then ContinueLoop  ; Is the upgrade checkbox selected?
        If $aUpgrades[$iz][0] <= 0 or $aUpgrades[$iz][1] <= 0 or $aUpgrades[$iz][3] = "" Then ContinueLoop  ; Now check to see if upgrade manually located?
        If $FreeBuilder <= 0 Then  ; Check free builder in case of multiple upgrades
            Setlog("No builder available for upgrade #" & $iz+1, $COLOR_RED)
            Return False
        EndIf
        SetLog("Checking Upgrade " & $iz + 1, $COLOR_GREEN) ;Debug tell logfile which upgrade working on.
;       SetLog("-Upgrade location =  " & "(" & $aUpgrades[$iz][0] & "," & $aUpgrades[$iz][1] & ")", $COLOR_PURPLE) ;Debug
        If _Sleep(500) Then Return
;
        Switch $aUpgrades[$iz][3]  ;Change action based on upgrade type!
            Case "Gold"
                If $GoldVillage <= $aUpgrades[$iz][2] + Number(GUICtrlRead($txtUpgrMinGold)) then  ; Do we have enough Gold?
                    SetLog("Insufficent Gold for #" & $iz + 1 & ", requires: " & $aUpgrades[$iz][2] & " + " & Number(GUICtrlRead($txtUpgrMinGold)), $COLOR_BLUE)
                    ContinueLoop
                EndIf
                If UpgradeNormal($iz) = False Then ContinueLoop
                $iUpgradeAction += 2^($iz+1)
                Setlog("Gold used = " & $aUpgrades[$iz][2], $COLOR_BLUE)
                $FreeBuilder -=1
                Local $temp = GetOther(324, 23, "Builder")
                If $temp <> "" Then
                    $FreeBuilder = $temp
                Else
                    $FreeBuilder -=1
                EndIf
                ContinueLoop
            Case "Elixir"
                If $ElixirVillage <= $aUpgrades[$iz][2] + Number(GUICtrlRead($txtUpgrMinElixir)) then
                    SetLog("Insufficent Elixir for #" & $iz + 1 & ", requires: " & $aUpgrades[$iz][2]& " + " & Number(GUICtrlRead($txtUpgrMinElixir)), $COLOR_BLUE)
                    ContinueLoop
                EndIf
                If UpgradeNormal($iz) = False Then ContinueLoop
                $iUpgradeAction += 2^($iz+1)
                Setlog("Elixir used = " & $aUpgrades[$iz][2], $COLOR_BLUE)
                Local $temp = GetOther(324, 23, "Builder")
                If $temp <> "" Then
                    $FreeBuilder = $temp
                Else
                    $FreeBuilder -=1
                EndIf
                ContinueLoop
            Case "Dark"
                If $DarkVillage <= $aUpgrades[$iz][2] + $iMinDark then
                    SetLog("Insufficent Dark for #" & $iz + 1 & ", requires: " & $aUpgrades[$iz][2] & " + " & $iMinDark , $COLOR_BLUE)
                    ContinueLoop
                EndIf
                If UpgradeHero($iz) = False Then ContinueLoop
                $iUpgradeAction += 2^($iz+1)
                Setlog("Dark Elixir used = " & $aUpgrades[$iz][2], $COLOR_BLUE)
                Local $temp = GetOther(324, 23, "Builder")
                If $temp <> "" Then
                    $FreeBuilder = $temp
                Else
                    $FreeBuilder -=1
                EndIf
                ContinueLoop
            Case Else
                Setlog("Something went wrong with loot type on UpgradeIt module on #" & $iz + 1, $COLOR_RED)
                ExitLoop
        EndSwitch

    Next
    If $iUpgradeAction <= 0 then Setlog("No Upgrades Available", $COLOR_GREEN)
    Return $iUpgradeAction

EndFunc   ;==>UpgradeIt4

Func UpgradeNormal($inum)

    Click($aUpgrades[$inum][0], $aUpgrades[$inum][1])  ; Select the item to be upgrade
    If _Sleep(800) Then Return  ; Wait for window to open

    Local $aoffColors[3][3] = [[0xD6714B, 47, 37], [0xF0E850, 70, 0], [0xF4F8F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
    Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF3F3F1, 6), $aoffColors, 30) ; first white pixel of button

    If IsArray($ButtonPixel) Then
        SetLog("-$ButtonPixel =  " & "(" & $ButtonPixel[0] & "," & $ButtonPixel[1] & ")", $COLOR_PURPLE) ;Debug
        If _Sleep(500) Then Return
        Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20) ; Click Upgrade Button
        If _Sleep(1000) Then Return  ; Wait for window to open
        _CaptureRegion()
        If _ColorCheck(_GetPixelColor(685, 150), Hex(0xE1090E, 6), 20) Then  ; Check if the building Upgrade window is open
            If _ColorCheck(_GetPixelColor(471, 478), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(471, 482), Hex(0xE70A12, 6), 20) And _
            _ColorCheck(_GetPixelColor(471, 486), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!
                SetLog("Upgrade Fail #" & $inum + 1 & " No Loot!", $COLOR_RED)
                ClickP($TopLeftClient,2) ;Click Away
                Return False
            Else
                Click(440, 480) ; Click upgrade buttton
                If _Sleep(800) Then Return
                _CaptureRegion()
                If _ColorCheck(_GetPixelColor(573, 256), Hex(0xE1090E, 6), 20) Then ; Safety Check if the use Gem window opens
                  SetLog("Upgrade Fail #" & $inum + 1 & " No Loot!", $COLOR_RED)
                  Click(1, 1) ; click away to close window
                  Return False
                EndIf
                SetLog("Upgrade #" & $inum + 1 & " complete", $COLOR_GREEN)
                $aUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
                $aUpgrades[$inum][1] = -1
                $aUpgrades[$inum][3] = ""
                GUICtrlSetImage ($picUpgradeStatus[$inum], $hGreenLight)  ; Change GUI upgrade status to not ready
                GUICtrlSetState($chkbxUpgrade[$inum],$GUI_UNCHECKED) ; Change upgrade selection box to unchecked
                Click(1, 1) ; click away to close window
                If _Sleep(800) Then Return  ; Wait for window to close
                Return True
            EndIf
        Else
          Setlog("Upgrade #" & $inum + 1 & " window open fail", $COLOR_RED)
          ClickP($TopLeftClient,2) ;Click Away
        EndIf
    Else
      Setlog("Upgrade #" & $inum + 1 & " Error finding button", $COLOR_RED)
      ClickP($TopLeftClient,2) ;Click Away
      Return False
    EndIf

EndFunc  ;==>> UpgradeNormal

Func UpgradeHero($inum)

    Click($aUpgrades[$inum][0], $aUpgrades[$inum][1])  ; Select the item to be upgrade
    If _Sleep(800) Then Return  ; Wait for window to open

    Local $aoffColors[3][3] = [[0x854833, 35, 33], [0x000000, 66, 11], [0x2B2D1F, 76, 0]] ; 2nd pixel brown hammer, 3rd pixel black, 4th pixel edge of button
    Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 615, 1, 1, Hex(0xF2F6F5, 6), $aoffColors, 30) ; first white pixel of button

    If IsArray($ButtonPixel) Then
        SetLog("-$ButtonPixel =  " & "(" & $ButtonPixel[0] & "," & $ButtonPixel[1] & ")", $COLOR_PURPLE) ;Debug
        If _Sleep(500) Then Return
        Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20) ; Click Upgrade Button
        If _Sleep(1000) Then Return  ; Wait for window to open
        _CaptureRegion()
        If _ColorCheck(_GetPixelColor(715, 150), Hex(0xE1090E, 6), 20) Then  ; Check if the Hero Upgrade window is open
            If _ColorCheck(_GetPixelColor(557, 486), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(557, 490), Hex(0xE70A12, 6), 20) And _
            _ColorCheck(_GetPixelColor(557, 494), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!
                SetLog("Hero Upgrade Fail #" & $inum + 1 & " No DE!", $COLOR_RED)
                ClickP($TopLeftClient,2) ;Click Away to close window
                Return False
            Else
;               Click(440, 480) ; Click upgrade buttton
                Click(1,1)
                If _Sleep(800) Then Return
                _CaptureRegion()
                If _ColorCheck(_GetPixelColor(573, 256), Hex(0xE1090E, 6), 20) Then ; Safety Check if the use Gem window opens
                  SetLog("Upgrade Fail #" & $inum + 1 & " No DE!", $COLOR_RED)
                  ClickP($TopLeftClient,2) ;Click Away to close windows
                  Return False
                EndIf
                SetLog("Hero Upgrade #" & $inum + 1 & " complete", $COLOR_GREEN)
                $aUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
                $aUpgrades[$inum][1] = -1
                $aUpgrades[$inum][3] = ""
                GUICtrlSetImage ($picUpgradeStatus[$inum], $hGreenLight)  ; Change GUI upgrade status to not ready
                GUICtrlSetState($chkbxUpgrade[$inum],$GUI_UNCHECKED) ; Change upgrade selection box to unchecked
                ClickP($TopLeftClient,2) ;Click Away to close windows
                If _Sleep(800) Then Return  ; Wait for window to close
                Return True
            EndIf
        Else
          Setlog("Upgrade #" & $inum + 1 & " window open fail", $COLOR_RED)
          ClickP($TopLeftClient,2) ;Click Away to close windows
        EndIf
    Else
      Setlog("Upgrade #" & $inum + 1 & " Error finding button", $COLOR_RED)
      ClickP($TopLeftClient,2) ;Click Away to close windows
      Return False
    EndIf

EndFunc  ;==>> UpgradeHero