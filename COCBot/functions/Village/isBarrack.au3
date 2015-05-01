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

;Checks is your Barrack or no

Func isBarrack()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(218, 294), Hex(0xBBBBBB, 6), 10) Or _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 10) Then
		return True
	EndIf
	Return False
EndFunc   ;==>isBarrack

Func isDarkBarrack()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(639, 456), Hex(0xD7DBC8, 6), 10) Or _ColorCheck(_GetPixelColor(526, 419), Hex(0xC9CCBB, 6), 10) Then
		return True
	EndIf
	Return False
EndFunc   ;==>isDarkBarrack ; gamebot.org