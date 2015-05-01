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
;Waits 5 minutes for the pixel of mainscreen to be located, checks for obstacles every 2 seconds.
;After five minutes, will try to restart bluestacks.

Func waitMainScreen() ;Waits for main screen to popup
	SetLog("Waiting for Main Screen")
	For $i = 0 To 105 ;120*2000 = 3.5 Minutes
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(284, 28), Hex(0x41B1CD, 6), 20) = False Then ;Checks for Main Screen
			If _Sleep(2000) Then Return
			If checkObstacles() Then $i = 0 ;See if there is anything in the way of mainscreen
		Else
			Return
		EndIf
	Next

	SetLog("Unable to load Clash Of Clans, Restarting...", $COLOR_RED)
	$iTimeTroops = 0
	Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
	Run($RestartApp & " Android")
	If _Sleep(10000) Then Return

	Do
		If _Sleep(5000) Then Return
	Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
EndFunc   ;==>waitMainScreen
