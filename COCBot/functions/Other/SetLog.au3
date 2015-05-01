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
Func SetLog($String, $Color = $COLOR_BLACK, $Font = "Verdana", $FontSize = 7.5) ;Sets the text for the log
	_GUICtrlRichEdit_SetFont($txtLog, 6, "Lucida Console")
	_GUICtrlRichEdit_AppendTextColor($txtLog, Time(), 0x000000)
	_GUICtrlRichEdit_SetFont($txtLog, $FontSize, $Font)
	_GUICtrlRichEdit_AppendTextColor($txtLog, $String & @CRLF, _ColorConvert($Color))
	_GUICtrlStatusBar_SetText($statLog, "Status : " & $String)
	_FileWriteLog($hLogFileHandle, $String)
EndFunc   ;==>SetLog

Func _GUICtrlRichEdit_AppendTextColor($hWnd, $sText, $iColor)
	Local $iLength = _GUICtrlRichEdit_GetTextLength($hWnd, True, True)
	Local $iCp = _GUICtrlRichEdit_GetCharPosOfNextWord($hWnd, $iLength)
	_GUICtrlRichEdit_AppendText($hWnd, $sText)
	_GUICtrlRichEdit_SetSel($hWnd, $iCp-1, $iLength + StringLen($sText))
	_GUICtrlRichEdit_SetCharColor($hWnd, $iColor)
	_GuiCtrlRichEdit_Deselect($hWnd)
EndFunc

Func _ColorConvert($nColor);RGB to BGR or BGR to RGB
    Return _
        BitOR(BitShift(BitAND($nColor, 0x000000FF), -16), _
        BitAND($nColor, 0x0000FF00), _
        BitShift(BitAND($nColor, 0x00FF0000), 16))
EndFunc	;==>_ColorConvert