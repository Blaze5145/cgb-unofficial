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

;Gets trophy count of village and compares to max trophy input.
;Will drop a troop and return home with no screenshot or gold wait.

Func DropTrophy()
 Local $TrophyCount = getOther(50, 74, "Trophy")
 Local $itxtMaxTrophyNeedCheck
 $itxtMaxTrophyNeedCheck = $itxtMaxTrophy ; $itxtMaxTrophy = 1800
 While Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck)
  $TrophyCount = getOther(50, 74, "Trophy")
  SetLog("Trophy Count : " & $TrophyCount, $COLOR_GREEN)
  If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
   $itxtMaxTrophyNeedCheck = $itxtdropTrophy ; $itxtMinTrophy = 1650
   SetLog("Dropping Trophies to " & $itxtdropTrophy, $COLOR_BLUE)
   If _Sleep(2000) Then ExitLoop

   ZoomOut()
   PrepareSearch()

   If _Sleep(5000) Then ExitLoop
   While getGold(51, 66) = "" ; Loops until gold is readable
      If _Sleep(1000) Then ExitLoop (2)
   WEnd
   Click(34, 310) ;Drop one troop

   $CurArch += 1
   If _Sleep(1000) Then ExitLoop

   ReturnHome(False, False) ;Return home no screenshot
   If _Sleep(1000) Then ExitLoop
   GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped)-($TrophyCount-getOther(50, 74, "Trophy")))
  Else
   SetLog("Trophy Drop Complete", $COLOR_BLUE)
  EndIf
 WEnd
EndFunc   ;==>DropTrophy