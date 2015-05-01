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

;Goes into a match, breaks shield if it has to

Func PrepareSearch() ;Click attack button and find match button, will break shield
	SetLog("Going to Attack...", $COLOR_BLUE)

	Click(60, 614);Click Attack Button
	If _Sleep(1000) Then Return

	Click(217, 510);Click Find a Match Button
	If _Sleep(3000) Then Return

	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(513, 416), Hex(0x5DAC10, 6), 50) Then
		Click(513, 416);Click Okay To Break Shield
	EndIf
EndFunc   ;==>PrepareSearch
