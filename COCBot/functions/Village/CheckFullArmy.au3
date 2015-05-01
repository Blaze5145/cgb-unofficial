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

;Checks if red pixel located in the popup baracks window is available

Func CheckFullArmy()
	_CaptureRegion()
	$Pixel = _ColorCheck(_GetPixelColor(327, 520), Hex(0xD03838, 6), 20)
	if not $Pixel then
		if _sleep(200) then return
		_CaptureRegion()
		$Pixel = (_ColorCheck(_GetPixelColor(653, 247), Hex(0xE0E4D0, 6), 20) AND Not _ColorCheck(_GetPixelColor(475, 214), Hex(0xE0E4D0, 6), 20))
	endif
	If $Pixel Then
		$fullArmy = True
	ElseIf _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 1 Then
		$fullArmy = False
	EndIf
EndFunc   ;==>CheckFullArmy