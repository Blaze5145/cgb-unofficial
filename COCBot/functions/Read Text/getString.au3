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
;Uses getChar to get the characters of the donation and gets all of the character into a string.

Func getString($y)
	For $i = 0 To 3
		Local $x_Temp = 35
		If getChar($x_Temp, $y) = "  " Or getChar($x_Temp, $y) = "|" Then
			$y += 1
		Else
			ExitLoop
		EndIf
	Next
	Local $x = 35
	Local $String = ""
	Do
		$String &= getChar($x, $y)
	;Until (StringMid($String, StringLen($String) - 1, 2) = "   " Or StringMid($String, StringLen($String), 1) = "|")
	Until StringMid($String, StringLen($String), 1) = "|" or $x >= 310
	$String = StringReplace($String, "   ", " ")
	$String = StringReplace($String, "  ", " ")
	$String = StringReplace($String, "|", Null)

	Return $String
EndFunc