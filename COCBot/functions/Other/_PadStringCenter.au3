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
Func _PadStringCenter($String = "", $Width = 50, $PadChar = "=")

	If $String = "" Then Return ""

	Local $Odd = Mod(($Width - StringLen($String)), 2)
	Local $Count = ($Width - StringLen($String)) / 2
	Local $Pad = ""

	For $i = 0 To $Count - 1
		$Pad &= $PadChar
	Next

	If $Odd Then
		$Out = $Pad & $String & $Pad & $PadChar ; Odd
	Else
		$Out = $Pad & $String & $Pad ; Even
	EndIf

	Return $Out

EndFunc   ;==>_PadStringCenter
