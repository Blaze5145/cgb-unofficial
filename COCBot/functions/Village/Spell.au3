
Func CreateSpell()
   If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Or $CreateSpell = True Then
	  SetLog("Create Lightning Spells...", $COLOR_BLUE)
	  If $SFPos[0] = -1 Then
		 LocateSpellFactory()
		 SaveConfig()
	  Else
		 Click(1, 1) ;Click away
		 If _Sleep(500) Then Return

		 Click($SFPos[0], $SFPos[1])
		 If _Sleep(600) Then Return
		 _CaptureRegion()
		 If _Sleep(600) Then Return
		 Local $CreatePos = _PixelSearch(249, 563, 610, 639, Hex(0x001048, 6), 5) ;Finds Create Spells button
		 If IsArray($CreatePos) = False Then
			SetLog("Spell Factory is not available, skip Create", $COLOR_RED)
			If _Sleep(500) Then Return
		 Else
			Click($CreatePos[0], $CreatePos[1]) ;Click Create Spell
			If _Sleep(1000) Then Return
			_CaptureRegion()
			If _Sleep(600) Then Return
			If _ColorCheck(_GetPixelColor(237, 354), Hex(0xFFFFFF, 6), 20) = False Then
			   SetLog("Not enough Elixir to create Lightning Spell", $COLOR_RED)
			Elseif _ColorCheck(_GetPixelColor(200, 346), Hex(0x1A1A1A, 6), 20) Then
			   SetLog("Spell Factory Full", $COLOR_RED)
			Else
			   While _WaitForPixel(250, 357, Hex(0xCC4FC6, 6), 20, 800, 30)
				  Click(220, 320, 1) ;Lightning Spell
				  If _Sleep(500) Then Return
			   WEnd
			   SetLog("Create Lightning Spell Complete...", $COLOR_BLUE)
			   $CreateSpell = False
			EndIf
		 EndIf
		 Click(1, 1) ;Click Away
		 If _Sleep(500) Then Return
		 Click(1, 1) ;Click Away
	  EndIf
   Else
   EndIf
EndFunc

;CreateSpell