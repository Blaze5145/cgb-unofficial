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
;Will drop heroes in a specific coordinates, only if slot is not -1
;Only drops when option is clicked.

Func dropHeroes($x, $y, $KingSlot = -1, $QueenSlot = -1) ;Drops for king and queen
	While 1
		If _Sleep(2000) Then ExitLoop
		Switch $iradAttackMode
			Case 0 ;Dead Base
				If $KingSlot <> -1 And ($KingAttack[0] = 1 Or $KingAttack[2] = 1) Then
					SetLog("Dropping King", $COLOR_BLUE)
					Click(68 + (72 * $KingSlot), 595) ;Select King
					If _Sleep(500) Then Return
					Click($x, $y)
					$checkKPower = True
				EndIf

				If _Sleep(1000) Then ExitLoop

				If $QueenSlot <> -1 And ($QueenAttack[0] = 1 Or $QueenAttack[2] = 1) Then
					SetLog("Dropping Queen", $COLOR_BLUE)
					Click(68 + (72 * $QueenSlot), 595) ;Select Queen
					If _Sleep(500) Then Return
					Click($x, $y)
					$checkQPower = True
				EndIf
			Case 1 ;Weak Base
				;--------------------------------
			Case 2 ;All Base
				If $KingSlot <> -1 And $KingAttack[2] = 1 Then
					SetLog("Dropping King", $COLOR_BLUE)
					Click(68 + (72 * $KingSlot), 595) ;Select King
					If _Sleep(500) Then Return
					Click($x, $y)
					$checkKPower = True
				EndIf

				If _Sleep(1000) Then ExitLoop

				If $QueenSlot <> -1 And $QueenAttack[2] = 1 Then
					SetLog("Dropping Queen", $COLOR_BLUE)
					Click(68 + (72 * $QueenSlot), 595) ;Select Queen
					If _Sleep(500) Then Return
					Click($x, $y)
					$checkQPower = True
				EndIf
		EndSwitch
		ExitLoop
	WEnd
EndFunc   ;==>dropHeroes