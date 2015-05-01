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

;Locates Spell Factory manually
;saviart

Func LocateSpellFactory()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Spell Factory", "Click OK then click on your Spell Factory", 0, $frmBot)
		If $MsgBox = 1 Then
			$SFPos[0] = FindPos()[0]
			$SFPos[1] = FindPos()[1]
			SetLog("-Spell Factory =  " & "(" & $SFPos[0] & "," & $SFPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateSpellFactory