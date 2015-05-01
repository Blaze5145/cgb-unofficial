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
;Returns color of pixel in the coordinations

Func _GetPixelColor($iX, $iY,$hBitmapLocal = $hBitmap)
	Local $aPixelColor = _GDIPlus_BitmapGetPixel($hBitmapLocal, $iX, $iY)
	Return Hex($aPixelColor, 6)
 EndFunc   ;==>_GetPixelColor