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

;==>ReArm
Func ReArm()
	Global $Rearm = $ichkTrap = 1
	If $Rearm = False Then Return
	Local $y = 563

	SetLog("Checking if Village needs Rearming..", $COLOR_BLUE)

	If $TownHallPos[0] = -1 Then
		LocateTownHall()
		SaveConfig()
		If _Sleep(1000) Then Return
	EndIf

	Click(1, 1) ; Click away
	If _Sleep(1000) Then Return
	Click($TownHallPos[0], $TownHallPos[1])
	If _Sleep(1000) Then Return

	;Traps
	Local $offColors[3][3] = [[0x887C78, 23, 15], [0xF3EF74, 71, 0], [0xF5F9F2, 79, 0]] ; 2nd pixel brown wrench, 3rd pixel gold, 4th pixel edge of button
	Global $RearmPixel = _MultiPixelSearch(240, $y, 670, 600, 1, 1, Hex(0xF6F8F2, 6), $offColors, 30) ; first white pixel of button
	If IsArray($RearmPixel) Then
		Click($RearmPixel[0]+ 20, $RearmPixel[1] + 20) ; Click RearmButton
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Rearmed Traps", $COLOR_GREEN)
		EndIf
	EndIf

	;Xbow
	Local $offColors[3][3] = [[0x896847, 30, 25], [0xEF6CEE, 70, 7], [0x2B2D1F, 76, 0]]; xbow, elixir, edge
	Global $XbowPixel = _MultiPixelSearch(240, $y, 670, 600, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; button start
	If IsArray($XbowPixel) Then
		Click($XbowPixel[0] + 20, $XbowPixel[1] + 20) ; Click XbowButton
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Reloaded X-Bows", $COLOR_GREEN)
		EndIf
	EndIf

	;Inferno
	Local $offColors[3][3] = [[0xBC4700, 22, 18], [0x5E4B68, 69, 7], [0x2B2D1F, 76, 0]]; inferno, dark, edge
	Global $InfernoPixel = _MultiPixelSearch(240, $y, 670, 600, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30)
	If IsArray($InfernoPixel) Then
		Click($InfernoPixel[0] + 20, $InfernoPixel[1] + 20) ; Click InfernoButton
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Reloaded Infernos", $COLOR_GREEN)
		EndIf
	EndIf

	Click(1, 1) ; Click away

EndFunc   ;==>ReArm