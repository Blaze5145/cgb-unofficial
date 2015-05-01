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
;Checks the troops when in battle, checks for type, slot, and quantity.
;Saved in $atkTroops[SLOT][TYPE/QUANTITY] variable

Func PrepareAttack($Remaining = False) ;Assigns troops
  If $Remaining Then
	  SetLog("Checking remaining unused troops", $COLOR_BLUE)
   Else
	  SetLog("Preparing to attack", $COLOR_RED)
   EndIf
  _CaptureRegion()
  For $i = 0 To 8
	  Local $troopKind = IdentifyTroopKind($i)
			For $x = 0 To 3
			 $troopKind = IdentifyTroopKind($i)
			 If $troopKind = $eBarbarian Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eArcher Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eGiant Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			ElseIf $troopKind = $eBalloon Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eWizard Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eGoblin Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eWallbreaker Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eHog Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eMinion Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eWizard Then; And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eRSpell Then ;And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eHSpell Then ; And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle And $troopKind <> $eLSpell Then
				$troopKind = -1
			 EndIf
			Next

	  If ($troopKind == -1) Then
		 $atkTroops[$i][1] = 0
	  ElseIf ($troopKind = $eKing) Or ($troopKind = $eQueen) Or ($troopKind = $eCastle) Then
		 $atkTroops[$i][1] = ""
	  Else
		 $atkTroops[$i][1] = ReadTroopQuantity($i)
	  EndIf
	  $atkTroops[$i][0] = $troopKind
	  If $troopKind <> -1 Then SetLog("-" & NameOfTroop($atkTroops[$i][0]) & " " & $atkTroops[$i][1], $COLOR_GREEN)
  Next
EndFunc   ;==>PrepareAttack
