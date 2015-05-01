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
;PixelSearch a certain region, works for memory BMP

Func _PixelSearch($iLeft, $iTop, $iRight, $iBottom, $iColor, $iColorVariation)
	_CaptureRegion($iLeft, $iTop, $iRight, $iBottom)
	For $x = $iRight - $iLeft To 0 Step -1
		For $y = 0 To $iBottom - $iTop
			If _ColorCheck(_GetPixelColor($x, $y), $iColor, $iColorVariation) Then
				Local $Pos[2] = [$iLeft + $x, $iTop + $y]
				Return $Pos
			EndIf
		Next
	Next
	Return 0
EndFunc   ;==>_PixelSearch