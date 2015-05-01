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


	Func CreateSpell()
If GUICtrlRead($chklighspell) = $GUI_CHECKED Then
SetLog("Creating Spells...")
			If $SFPos[0] = -1 Then
			LocateSpellFactory()
			SaveConfig()
			Else

					 Click($SFPos[0], $SFPos[1])
					 If _Sleep(600) Then Return
					  _CaptureRegion()
					  If _Sleep(600) Then Return
					 if _ColorCheck(_GetPixelColor(555, 616), Hex(0xFFFFFF, 6), 20)  Then
						SetLog("Create Lighning Spell", $COLOR_BLUE)
						Click(566,599) ;click create spell
						 If _Sleep(1000) Then Return
							    _CaptureRegion()
								 If _Sleep(600) Then Return
						   if  _ColorCheck(_GetPixelColor(237, 354), Hex(0xFFFFFF, 6), 20) = False Then
							  setlog("Not enoug Elixir to create Spell", $COLOR_RED)
						   Elseif  _ColorCheck(_GetPixelColor(200, 346), Hex(0x1A1A1A, 6), 20) Then
								  setlog("Spell Factory Full", $COLOR_RED)
						   Else
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
						   EndIf


					 Else
						   setlog("Spell Factory is not available, Skip Create", $COLOR_RED)
						EndIf
			EndIf
	  Else
	  EndIf
	  EndFunc

 ;CreateSpell