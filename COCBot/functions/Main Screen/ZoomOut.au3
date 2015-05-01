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
;Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.
;Only does it for 20 zoom outs, no more than that.

Func ZoomOut() ;Zooms out
	Local $i = 0
	While 1
		_CaptureRegion(0, 0, 860, 2)
		If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then SetLog("Zooming Out", $COLOR_BLUE)
		While _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6)
			If _Sleep(600) Then Return
			If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
			If $i = 40 Then
				ExitLoop
			EndIf
			_CaptureRegion(0, 0, 860, 2)
		 WEnd
		ExitLoop
	WEnd
EndFunc   ;==>ZoomOut