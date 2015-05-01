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
;Returns complete value of normal xxx

Func getNormal($x_start, $y_start)
	_CaptureRegion(0, 0, $x_start + 90, $y_start + 20)
	;-----------------------------------------------------------------------------
	Local $x = $x_start, $y = $y_start
	Local $Normal, $i = 0

	$Normal = getDigit($x, $y, "Normal")

	While $Normal = ""
		If $i >= 50 Then ExitLoop
		$i += 1
		$x += 1
		$Normal = getDigit($x, $y, "Normal")
	WEnd

	$Normal &= getDigit($x, $y, "Normal")
	$Normal &= getDigit($x, $y, "Normal")

	Return $Normal
EndFunc   ;==>getNormal