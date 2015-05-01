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
; _NumberFormat

Func _NumberFormat($Number = "") ; pad numbers with spaces as thousand separator

	If $Number = "" then Return ""

	If StringLeft($Number, 1) = "-" Then
		Return "- " & StringRegExpReplace(StringTrimLeft($Number, 1), "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 ")
	Else
		Return StringRegExpReplace($Number, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 ")
	EndIf

EndFunc
