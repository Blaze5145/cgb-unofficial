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

; Locates TownHall for Rearm Function

Func LocateTownHall()
   If $ichkTrap = 1 Then
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Townhall", "Click OK then click on your Townhall", 0, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$TownHallPos[0] = FindPos()[0]
			$TownHallPos[1] = FindPos()[1]
			SetLog("-Townhall =  " & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
	Click(1, 1)
	EndIf
EndFunc   ;==>LocateTownHall