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

Func LocateBarrack($ArmyCamp = False)
    Local $choice = "Barrack"
    If $ArmyCamp Then $choice = "Army Camp"
	SetLog("Locating " & $choice & "...", $COLOR_BLUE)
	Local $MsgBox
	$MsgBox = MsgBox(1 + 262144, "Locate your " & $choice, "Click OK then click on one of your " & $choice & "s.", 0, $frmBot)
	If $MsgBox = 1 Then
	    If $ArmyCamp Then
		   $ArmyPos[0] = FindPos()[0]
		   $ArmyPos[1] = FindPos()[1]
		Else
		   $barrackPos[0] = FindPos()[0]
		   $barrackPos[1] = FindPos()[1]
		EndIf
	endif
	#cs
	While 1
	  $MsgBox = MsgBox(6 + 262144, "Locate first barrack", "Click Continue then click on your first barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[0][0] = FindPos()[0]
		  $barrackPos[0][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  For $i=0 To 3
			 $barrackPos[$i][0] = ""
			 $barrackPos[$i][1] = ""
		  Next
		  ExitLoop
	  EndIf
	  If _Sleep(500) Then ExitLoop
	  $MsgBox = MsgBox(6 + 262144, "Locate second barrack", "Click Continue then click on your second barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[1][0] = FindPos()[0]
		  $barrackPos[1][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  For $i=1 To 3
			 $barrackPos[$i][0] = ""
			 $barrackPos[$i][1] = ""
		  Next
		  ExitLoop
	  EndIf
	  If _Sleep(500) Then ExitLoop
	  $MsgBox = MsgBox(6 + 262144, "Locate third barrack", "Click Continue then click on your third barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[2][0] = FindPos()[0]
		  $barrackPos[2][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  For $i=2 To 3
			 $barrackPos[$i][0] = ""
			 $barrackPos[$i][1] = ""
		  Next
		  ExitLoop
	  EndIf
	  If _Sleep(500) Then ExitLoop
	  $MsgBox = MsgBox(6 + 262144, "Locate fourth barrack", "Click Continue then click on your fourth barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[3][0] = FindPos()[0]
		  $barrackPos[3][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  $barrackPos[3][0] = ""
		  $barrackPos[3][1] = ""
	  EndIf
	  If GUICtrlRead($chkRequest) = $GUI_CHECKED And $CCPos[0] = -1 Then LocateClanCastle()
	  ExitLoop
   WEnd
   #ce
	SaveConfig()
	SetLog("-Locating Complete-", $COLOR_BLUE)
	If $ArmyCamp Then
	   SetLog("-" & $choice & " = " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_GREEN)
    Else
	   SetLog("-" & $choice & " = " & "(" & $barrackPos[0] & "," & $barrackPos[1] & ")", $COLOR_GREEN)
    EndIf
EndFunc   ;==>LocateBarrack