Func SearchSpell($position)
   _CaptureRegion()
   If _ColorCheck(_GetPixelColor(68 + (72 * $position), 624), Hex(0x0848ED, 6), 5) Then Return $eLSpell ;Check if slot is Lightning Spell
   Return -1
EndFunc

Func SpellDarkStorage()
	If $DELightSpell = 0 Then Return

	Local $SDark
	Local $LightPosition[11]
	Local $LightSpell
	Local $SpellTimeOut = 0

	$SDark = getDarkElixir(51, 66 + 57)

	If ($SDark <> "") Then
	   $DELocation = checkDarkElix()

	   If $castSpell < 1 Then SetLog("~Zapping Dark Elixir activated, searching Dark Storage...", $COLOR_BLUE)

	   $LSpell = -1
	   For $i = 0 To 10
		 $LightSpell = SearchSpell($i)
		 If $LightSpell = $eLSpell Then
			$LightPosition[$i] = $LightSpell
			$LSpell = $i
		 EndIf
	   Next

	   If ($DELocation = 1) And ($LSpell <> -1) And ($SDark - $SpellMinDarkStorage >= 0) Then
		  SetLog("Found Dark Elixir: " & $SDark & " at PosX: " & $DElixx & ", PosY: " & $DElixy, $COLOR_BLUE)
		  Click(68 + (72 * $LSpell), 595) ;Select Spell
		  If _Sleep(500) Then Return
		  While _WaitForPixel(68 + (72 * $LSpell), 624, Hex(0x0848ED, 6), 5, 500, 500)
			 Click($DElixx, $DElixy)
			 $SpellTimeOut += 1
			 If ($SpellTimeOut >= 10) Then ExitLoop
		  WEnd
		  $CreateSpell = True
	   ElseIf ($SDark - $SpellMinDarkStorage <= -1 And $castSpell < 1) Then
		  SetLog("Dark Elixir Storage below minimum or empty", $COLOR_RED)
	   ElseIf ($LSpell = -1 And $castSpell < 1) Then
		  SetLog("Lightning Spell is not found or already used", $COLOR_RED)
	   ElseIf ($DELocation = 0 And $castSpell <= 3) Then
		  SetLog("Unable to locate Dark Elixir Storage or is empty", $COLOR_RED)
	   EndIf
	   $castSpell += 1
	EndIf
EndFunc   ;==>SpellDarkStorage
