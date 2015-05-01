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
Func Click($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "left", "1", $x, $y)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		ControlClick($Title, "", "", "left", "1", $x, $y)
	EndIf
 EndFunc   ;==>Click

 ; ClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func ClickP($point, $howMuch=1, $speed = 0)
   Click($point[0], $point[1], $howMuch, $speed)
EndFunc