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

;Clickes the collector locations

Func Collect()
	If $iChkCollect = 0 Then Return

	Local $collx, $colly, $i = 0

	SetLog("Collecting Resources", $COLOR_BLUE)
	If _Sleep(250) Then Return

	Click(1, 1) ;Click Away

	While 1
		If _Sleep(300) Or $RunState = False Then ExitLoop
		_CaptureRegion(0,0,780)
		If _ImageSearch(@ScriptDir & "\images\collect.png", 1, $collx, $colly, 20) Then
			Click($collx, $colly) ;Click collector
		Elseif $i >= 20 Then
			ExitLoop
		EndIf
		$i += 1
		Click(1, 1) ;Click Away
	WEnd
EndFunc   ;==>Collect