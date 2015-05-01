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
Func FindPos()
	getBSPos()
	Local $Pos[2]
	While 1
		If _IsPressed("01") Then
			$Pos[0] = MouseGetPos()[0] - $BSpos[0]
			$Pos[1] = MouseGetPos()[1] - $BSpos[1]
			Return $Pos
		EndIf
	WEnd
EndFunc   ;==>FindPos