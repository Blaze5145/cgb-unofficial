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
;Drops Clan Castle troops, given the slot and x, y coordinates.

Func dropCC($x, $y, $slot) ;Drop clan castle
	If $slot <> -1 And $checkUseClanCastle = 1 Then
		SetLog("Dropping Clan Castle", $COLOR_BLUE)
		Click(68 + (72 * $slot), 595, 1, 500)
		If _Sleep(500) Then Return
		Click($x, $y)
	EndIf
EndFunc   ;==>dropCC