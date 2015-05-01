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
; check Wall function | safar46, edit by: Hervidero

Global $Wall[8]

For $i = 0 To 7
   $Wall[$i] = @ScriptDir & "\images\Walls\" & $i+4 & ".png"
Next

Global $WallX = 0, $WallY = 0, $WallLoc = 0
Global $Tolerance2 = 55

Func CheckWall()
    If _Sleep(500) Then Return
    For $i = 0 To 3
	   _CaptureRegion()
	   $WallLoc = _ImageSearch($Wall[$icmbWalls], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
;	   If $icmbWalls = 6 Then
;		  If $WallLoc = 0 Then $WallLoc = _ImageSearch($Wall[$icmbWalls+1], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall lvl 10 Location
;	   EndIf
	   If $WallLoc = 1 Then
		  SetLog("Found Walls level " & $icmbWalls+4 & ", Upgrading...", $COLOR_GREEN)
		  Return True
	   EndIf
	Next
	SetLog("Cannot find Walls level " & $icmbWalls+4 & ", Skip upgrade...", $COLOR_ORANGE)
	Return False
EndFunc