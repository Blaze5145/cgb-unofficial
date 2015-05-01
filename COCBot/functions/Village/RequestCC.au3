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

Func RequestCC()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		If $CCPos[0] = -1 Then
			LocateClanCastle()
			SaveConfig()
			If _Sleep(1000) Then Return
		EndIf
		While 1
			SetLog("Requesting Clan Castle Troops", $COLOR_BLUE)
			Click($CCPos[0], $CCPos[1])
			If _Sleep(1000) Then ExitLoop
			_CaptureRegion()
			$RequestTroop = _PixelSearch(310, 590, 553, 600, Hex(0x5C8E93, 6), 10)
			If IsArray($RequestTroop) Then
				Click($RequestTroop[0], $RequestTroop[1])
				If _Sleep(1000) Then ExitLoop
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(340, 245), Hex(0xCC4010, 6), 20) Then
					If GUICtrlRead($txtRequest) <> "" Then
						Click(430, 140) ;Select text for request
						If _Sleep(1000) Then ExitLoop
						$TextRequest = GUICtrlRead($txtRequest)
						ControlSend($Title, "", "", $TextRequest, 0)
					EndIf
					If _Sleep(1000) Then ExitLoop
					Click(524, 228)
					If _Sleep(2000) Then ExitLoop
					;Click(340, 228)
				Else
					SetLog("Request has already been made", $COLOR_RED)
					Click(1, 1, 2)
				EndIf
			Else
				SetLog("Join a clan to donate troops", $COLOR_RED)
			EndIf
			ExitLoop
		WEnd
	EndIf
	If $ReqText <> GUICtrlRead($txtRequest) Then
		$ReqText = GUICtrlRead($txtRequest)
	EndIf
EndFunc   ;==>RequestCC
