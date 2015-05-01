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
;==============================================================================================================
;===Check Pixels===============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Using _ColorCheck, checks compares multiple pixels and returns true if they all pass _ColorCheck.
;--------------------------------------------------------------------------------------------------------------

Func boolPixelSearch($pixel1, $pixel2, $pixel3, $variation = 10)
	If _ColorCheck(_GetPixelColor($pixel1[0], $pixel1[1]), $pixel1[2], $variation) And _ColorCheck(_GetPixelColor($pixel2[0], $pixel2[1]), $pixel2[2], $variation) And _ColorCheck(_GetPixelColor($pixel3[0], $pixel3[1]), $pixel3[2], $variation) Then Return True
	Return False
EndFunc   ;==>boolPixelSearch