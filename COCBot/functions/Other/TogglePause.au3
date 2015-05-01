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
; TogglePause

HotKeySet("{PAUSE}", "TogglePause")

Func TogglePause()
   Local $BlockInputPausePrev
	$TPaused = NOT $TPaused
	If $TPaused and $Runstate = True Then
		TrayTip($sBotTitle, "", 1)
		TrayTip($sBotTitle, "was Paused!", 1, $TIP_ICONEXCLAMATION)
		Setlog("ClashGameBot was Paused!",$COLOR_RED)
		 If $BlockInputPause>0 Then	 $BlockInputPausePrev=$BlockInputPause
		 If $BlockInputPause>0 Then  _BlockInputEx(0,"","",$HWnD)
		GUICtrlSetState($btnPause, $GUI_HIDE)
		GUICtrlSetState($btnResume, $GUI_SHOW)
	ElseIf $TPaused = False And $Runstate = True Then
		TrayTip($sBotTitle, "", 1)
		TrayTip($sBotTitle, "was Resumed.", 1, $TIP_ICONASTERISK)
		Setlog("ClashGameBot was Resumed.",$COLOR_GREEN)
		 If $BlockInputPausePrev>0 Then  _BlockInputEx($BlockInputPausePrev,"","",$HWnD)
		 If $BlockInputPausePrev>0 Then $BlockInputPausePrev=0
		GUICtrlSetState($btnPause, $GUI_SHOW)
		GUICtrlSetState($btnResume, $GUI_HIDE)
	EndIf

	While $TPaused ; Actual Pause loop
		If _Sleep(100) Then ExitLoop
	WEnd
	; everything below this WEnd is executed when unpaused!
	ZoomOut()
	If _Sleep(250) Then Return
EndFunc