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

; Uses the getGold,getElixir... functions and uses CompareResources until it meets conditions.
; Will wait ten seconds until getGold returns a value other than "", if longer than 10 seconds exits

Func GetResources() ;Reads resources
 While 1
Local $i = 0
_CaptureRegion()

While getGold(51, 66) = "" ; Loops until gold is readable
If _Sleep(1000) Then ExitLoop (2)
$i += 1
If $i >= 10 Then
   SetLog("Cannot locate Next button, Restarting Bot", $COLOR_RED)
$Is_ClientSyncError= True ;new line
GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync)+ 1)
$iStuck=0
checkMainScreen()
$Restart = True
ExitLoop (2)
EndIf

WEnd

If _Sleep(300) Then ExitLoop (2)

   $searchTH = checkTownhallADV()
$searchGold = getGold(51, 66)
$searchElixir = getElixir(51, 66 + 29)
$searchTrophy = getTrophy(51, 66 + 90)

If $searchGold = $searchGold2 Then $iStuck += 1
If $searchGold <> $searchGold2 Then $iStuck = 0

$searchGold2 = $searchGold
if $iStuck>=5 then
SetLog("Cannot locate Next button, Restarting Bot", $COLOR_RED)
$Is_ClientSyncError= True ;new line
GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync)+ 1)
$iStuck=0
checkMainScreen()
$Restart = True
ExitLoop (2)
   EndIf

If $searchTrophy <> "" Then
$searchDark = getDarkElixir(51, 66 + 57)
Else
$searchDark = 0
$searchTrophy = getTrophy(51, 66 + 60)
EndIf

Local $THString = ""
   $searchTH = "-"
If ($OptBullyMode = 1 And $SearchCount >= $ATBullyMode) Or $OptTrophyMode = 1 Or $chkConditions[4] = 1 Or $chkConditions[5] = 1 Then
If $chkConditions[5] = 1 Or $OptTrophyMode = 1 Then
$searchTH = checkTownhallADV()
Else
$searchTH = checkTownhallADV()
EndIf

If SearchTownHallLoc() = False And $searchTH <> "-" Then
$THLoc = "In"
ElseIf $searchTH <> "-" Then
$THLoc = "Out"
Else
$THLoc = $searchTH
$THx = 0
$THy = 0
EndIf
$THString = " [TH]:" & StringFormat("%2s", $searchTH) & ", " & $THLoc
EndIf
Local $Snapshot_name=''
;saving base snapshot if needed
If ($AllTownsSnapshot) Then
	Local $sGold	=	Number(Number($searchGold)>Number($AllTownsSnapshotMinGold))
	Local $sElixir  =	Number(Number($searchElixir)>Number($AllTownsSnapshotMinElixir))
	If (($sGold + $sElixir)>$AllTownsSnapshotAndOr) Then
		Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
		Local $Time = @HOUR & "-" & @MIN
		$Snapshot_name= $Date & "_" & $Time & "_Gold-" & Number($searchGold) & "_Elixir-" & Number($searchElixir) & "_.png"
		_CaptureRegion()
		_GDIPlus_ImageSaveToFile ( $hBitmap, $dirAllTowns & $Snapshot_name )
		$Snapshot_name =", Snapshot in " & $Snapshot_name
	EndIf
EndIf

$SearchCount += 1 ; Counter for number of searches
SetLog(StringFormat("%3s", $SearchCount) & "> [G]:" & StringFormat("%7s", $searchGold) & " [E]:" & StringFormat("%7s", $searchElixir) & " [D]:" & StringFormat("%5s", $searchDark) & " [T]:" & StringFormat("%2s", $searchTrophy) & $THString & $Snapshot_name, $COLOR_BLACK, "Lucida Console", 7.5)

ExitLoop
WEnd
EndFunc   ;==>GetResources