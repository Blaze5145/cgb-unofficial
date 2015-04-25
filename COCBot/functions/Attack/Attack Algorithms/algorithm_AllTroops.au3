; Improved attack algorithm, using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
; Create by Fast French, edited by safar46

Func SetSleep($type)
   Switch $type
   Case 0
	  If $iRandomspeedatk = 1 Then
		 Return Round(Random(1, 10))*10
	  Else
		 Return ($icmbUnitDelay+1)*10
	  EndIf
   Case 1
	  If $iRandomspeedatk = 1 Then
		 Return Round(Random(1, 10))*100
	  Else
		 Return ($icmbWaveDelay+1)*100
	  EndIf
   EndSwitch
EndFunc

; Old mecanism, not used anymore
Func OldDropTroop($troop, $position, $nbperspot)
  SelectDropTroop($troop) ;Select Troop
  If _Sleep(100) Then Return
  For $i = 0 To 4
	 Click($position[$i][0], $position[$i][1], $nbperspot, 1)
	 If _Sleep(50) Then Return
  Next
EndFunc


; improved function, that avoids to only drop on 5 discret drop points :
Func DropOnEdge($troop, $edge, $number, $slotsPerEdge = 0, $edge2 = -1, $x = -1)
   if $number = 0 Then Return
   If _Sleep(100) Then Return
   SelectDropTroop($troop) ;Select Troop
   If _Sleep(300) Then Return
   If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
   If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
	  Click($edge[2][0], $edge[2][1], $number,250)
	  If $edge2 <> -1 Then Click($edge2[2][0], $edge2[2][1], $number,250)
	  If _Sleep(50) Then Return
  ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
	 Local $half = Ceiling($number/2)
	 Click($edge[1][0], $edge[1][1], $half)
	 If $edge2 <> -1 Then
		If _Sleep(SetSleep(0)) Then Return
		Click($edge2[1][0], $edge2[1][1], $half)
	 EndIf
	 If _Sleep(SetSleep(0)) Then Return
	 Click($edge[3][0], $edge[3][1], $number  - $half)
	 If $edge2 <> -1 Then
		If _Sleep(SetSleep(0)) Then Return
		Click($edge2[3][0], $edge2[3][1], $number  - $half)
	 EndIf
	 If _Sleep(SetSleep(0)) Then Return
   Else
	    Local $minX = $edge[0][0]
		Local $maxX = $edge[4][0]
		Local $minY = $edge[0][1]
		Local $maxY = $edge[4][1]
	    If $edge2 <> -1 Then
			Local $minX2 = $edge2[0][0]
			Local $maxX2 = $edge2[4][0]
			Local $minY2 = $edge2[0][1]
			Local $maxY2 = $edge2[4][1]
	    EndIf
		Local $nbTroopsLeft = $number
  	    For $i = 0 To $slotsPerEdge - 1
			Local $nbtroopPerSlot = Round($nbTroopsLeft/($slotsPerEdge - $i)) ; progressively adapt the number of drops to fill at the best
	  		Local $posX = $minX + (($maxX - $minX) * $i) / ($slotsPerEdge - 1)
			Local $posY = $minY + (($maxY - $minY) * $i) / ($slotsPerEdge - 1)
			Click($posX, $posY, $nbtroopPerSlot)
			If $edge2 <> -1 Then ; for 2, 3 and 4 sides attack use 2x dropping
			   Local $posX2 = $maxX2 - (($maxX2 - $minX2) * $i) / ($slotsPerEdge - 1)
			   Local $posY2 = $maxY2 - (($maxY2 - $minY2) * $i) / ($slotsPerEdge - 1)
			   If $x = 0 Then
				  If _Sleep(SetSleep(0)) Then Return ; add delay for first wave attack to prevent skip dropping troops, must add for 4 sides attack
			   EndIf
			   Click($posX2, $posY2, $nbtroopPerSlot)
			   $nbTroopsLeft -= $nbtroopPerSlot
			Else
			   $nbTroopsLeft -= $nbtroopPerSlot
			EndIf
			If _Sleep(SetSleep(0)) Then Return
		 Next
	  EndIf
EndFunc

Func DropOnEdges($troop, $nbSides, $number, $slotsPerEdge=0)
    If $nbSides = 0 Or $number = 1 Then
	   OldDropTroop($troop, $Edges[0], $number);
	   Return
    EndIf
	If $nbSides < 1 Then Return
    Local $nbTroopsLeft = $number
	If $nbSides = 4 Then
	  For $i = 0 to $nbSides-3
		 Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i*2))
		 DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i+2], $i)
		 $nbTroopsLeft -= $nbTroopsPerEdge*2
	  Next
	  Return
	EndIf
  	For $i = 0 to $nbSides-1
	   If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
	     Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i))
		 DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge)
	     $nbTroopsLeft -= $nbTroopsPerEdge
	   Elseif ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
	     Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i*2))
		 DropOnEdge($troop, $Edges[$i+3], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i+1])
	     $nbTroopsLeft -= $nbTroopsPerEdge*2
	   EndIf
    Next
EndFunc

Func LauchTroop($troopKind, $nbSides, $waveNb, $maxWaveNb, $slotsPerEdge=0)
   Local $troop = -1
   Local $troopNb = 0
   Local $name = ""
   For $i = 0 To 8 ; identify the position of this kind of troop
	  If $atkTroops[$i][0] = $troopKind Then
		 $troop = $i
		 $troopNb = Ceiling($atkTroops[$i][1]/$maxWaveNb)
		 Local $plural = 0
		 if $troopNb > 1 Then $plural = 1
		 $name = NameOfTroop($troopKind, $plural)
	  EndIf
   Next

   if ($troop = -1) Or ($troopNb = 0) Then
	  ;if $waveNb > 0 Then SetLog("Skipping wave of " & $name & " (" & $troopKind & ") : nothing to drop" )
	  Return False; nothing to do => skip this wave
   EndIf

   Local $waveName = "first"
   if $waveNb = 2 Then $waveName = "second"
   if $waveNb = 3 Then $waveName = "third"
   if $maxWaveNb = 1 Then $waveName = "only"
   if $waveNb = 0 Then $waveName = "last"
   SetLog("Dropping " & $waveName & " wave of " & $troopNb & " " & $name, $COLOR_GREEN)
   DropTroop($troop, $nbSides, $troopNb, $slotsPerEdge)
   Return True
EndFunc

Func algorithm_AllTroops() ;Attack Algorithm for all existing troops
    $nameFunc = "[algorithm_AllTroops]"
    debugRedArea($nameFunc & " IN ")
    debugRedArea($nameFunc & " ==========> DATE : [" & @YEAR & @MON & @MDAY & @HOUR & @MIN & @SEC & "] <==========")
     debugRedArea("$chkRedArea : " & $chkRedArea)
     If ($chkRedArea) Then
    SetLog("==> Search red area <==")
    Local $hTimer = TimerInit()
    _WinAPI_DeleteObject($hBitmapFirst)
    $hBitmapFirst = _CaptureRegion2()
    _GetRedArea()
     
     SetLog("==> Found  (in "&Round(TimerDiff($hTimer) / 1000, 2)&" seconds) :")
     SetLog(" ["&UBound($PixelTopLeft)&"] pixels TopLeft")
     SetLog(" ["&UBound($PixelTopRight)&"] pixels TopRight")
     SetLog(" ["&UBound($PixelBottomLeft)&"] pixels BottomLeft")
     SetLog(" ["&UBound($PixelBottomRight)&"] pixels BottomRight")
     EndIf

	$King = -1
	$Queen = -1
	$CC = -1
    For $i = 0 To 8
		If $atkTroops[$i][0] = $eCastle Then
			$CC = $i
		ElseIf $atkTroops[$i][0] = $eKing Then
			$King = $i
		ElseIf $atkTroops[$i][0] = $eQueen Then
			$Queen = $i
		EndIf
	 Next

	If _Sleep(2000) Then Return

If SearchTownHallLoc() AND GUICtrlRead($chkAttackTH)=$GUI_CHECKED Then
		 Switch $AttackTHType
		 Case 0
			   algorithmTH()
			   _CaptureRegion()
			   If _ColorCheck(_GetPixelColor(746,498), Hex(0x0E1306, 6), 20) Then AttackTHNormal() ;if 'no star' use another attack mode.
		 Case 1
			   AttackTHNormal();Good for Masters
		 Case 2
			   AttackTHXtreme();Good for Champ
			EndSwitch

		  Local $iErrorTime = 30000 ; Set to exit star check loop if no win 30 seconds after troop deployment
          Local $iBegin = TimerInit()
          Do
            _CaptureRegion()
            If _ColorCheck(_GetPixelColor(746,498), Hex(0x0E1306, 6), 20)=False Then ExitLoop ;exit if not 'no star'
            _Sleep(5000)
          Until TimerDiff($iBegin) >= $iErrorTime

 		 If $OptBullyMode=0  And $OptTrophyMode=1 And SearchTownHallLoc() Then; Return ;Exit attacking if trophy hunting and not bullymode
			Click(62, 519) ;Click Surrender
			If _Sleep(3000) Then Return
			Click(512, 394) ;Click Confirm
			Return
		 EndIf
EndIf


	    Local $nbSides = 0
        SetLog("~Using JVS MOD for Deploy Settings...")
        if $THL <= $deployTHSettings Then
            $nbSides = $deployBSettings + 1
        Else
            $nbSides = $deployASettings + 1
        EndIf
        Switch $nbSides
        Case 1 ;Single sides 
            SetLog("~Attacking on a single side...")
        Case 2 ;Two sides 
            SetLog("~Attacking on two sides...")
        Case 3 ;Three sides 
            SetLog("~Attacking on three sides...")
        Case 4 ;All sides 
            SetLog("~Attacking on all sides...")
        EndSwitch
		 if ($nbSides = 0) Then Return
		 If _Sleep(1000) Then Return

         ; ================================================================================?
         ; ========= Here is coded the main attack strategy ===============================
         ; ========= Feel free to experiment something else ===============================
         ; ================================================================================?
;         algorithmTH()
         if LauchTroop($eGiant, $nbSides, 1, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         if LauchTroop($eBarbarian, $nbSides, 1, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         if LauchTroop($eWallbreaker, $nbSides, 1, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         if LauchTroop($eArcher, $nbSides, 1, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         If LauchTroop($eBarbarian, $nbSides, 2, 2) Then
            If _Sleep(SetSleep(1)) Then Return
            EndIf
         If LauchTroop($eGoblin, $nbSides, 1, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf

		 $RandomEdge = $Edges[Round(Random(0, 3))]
		 Local $RandomXY = Round(Random(0, 4))
         If ($chkRedArea) Then
         Local $arrPixelDropHeroes = $PixelRedArea[Round(Random(0, 3))]
         Local $pixelDropHeroes = $arrPixelDropHeroes[Round(Random(0, UBound($arrPixelDropHeroes) - 1))]
         dropHeroes($pixelDropHeroes[0], $pixelDropHeroes[1], $King, $Queen)
         Else
         dropHeroes($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $King, $Queen)
         EndIf
		 dropCC($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $CC)

         if LauchTroop($eHog, $nbSides, 1, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf

         if LauchTroop($eWizard, $nbSides, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
			   
         if LauchTroop($eMinion, $nbSides, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf

         If LauchTroop($eArcher, $nbSides, 2, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         If LauchTroop($eGoblin, $nbSides, 2, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         ; ================================================================================?


		 Local $RandomEdge = $Edges[Round(Random(0, 3))]
		 Local $RandomXY = Round(Random(0, 4))
		 dropHeroes($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $King, $Queen)

		 If _Sleep(SetSleep(1)) Then Return

		If _Sleep(100) Then Return
		SetLog("Dropping left over troops", $COLOR_BLUE)
		For $x = 0 To 1
		   PrepareAttack(True) ;Check remaining quantities
		   For $i = $eBarbarian To $eWizard ; lauch all remaining troops
			  ;If $i = $eBarbarian Or $i = $eArcher Then
				 LauchTroop($i, $nbSides, 0, 1)
			  ;Else
			;	 LauchTroop($i, $nbSides, 0, 1, 2)
			  ;EndIf
			  If _Sleep(500) Then Return
		   Next
		Next

		;Activate KQ's power
		If ($checkKPower Or $checkQPower) and $iActivateKQCondition = "Manual" Then
			SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating Hero abilities", $COLOR_BLUE)
			_Sleep($delayActivateKQ)
			If $checkKPower Then
				SetLog("Activating King's power", $COLOR_BLUE)
				SelectDropTroop($King)
				$checkKPower = false
			EndIf
			If $checkQPower Then
				SetLog("Activating Queen's power", $COLOR_BLUE)
				SelectDropTroop($Queen)
				$checkQPower = false
			EndIf
		EndIf

		SetLog("~Finished Attacking, waiting to end battle", $COLOR_GREEN)
 EndFunc   ;==>algorithm_AllTroops

; Strategy :
;           Search red area
;           Split the result in 4 sides (global var) : Top Left / Bottom Left / Top Right / Bottom Right
;           Remove bad pixel (Suppose that pixel to deploy are in the green area)
;           Get pixel next the "out zone" , indeed the red color is very different and more uncertain
;           Sort each sides
;           Add each sides in one array (not use, but it can help to get closer pixel of all the red area)
Func _GetRedArea()
    $nameFunc = "[_GetRedArea] "
    debugRedArea($nameFunc & " IN")
 
 
    Local $colorVariation = 40
    Local $xSkip = 1
    Local $ySkip = 5
 
    Local $result = DllCall(@ScriptDir & "\redArea.dll", "str", "getRedArea", "ptr", $hBitmapFirst, "int", $xSkip, "int", $ySkip, "int", $colorVariation)
    Local $listPixelBySide = StringSplit($result[0], "#")
    $PixelTopLeft = GetPixelSide($listPixelBySide,1)
    $PixelBottomLeft = GetPixelSide($listPixelBySide,2)
    $PixelBottomRight = GetPixelSide($listPixelBySide,3)
    $PixelTopRight = GetPixelSide($listPixelBySide,4)
 
    Local $offsetArcher = 15
    Global $PixelTopLeftFurther[UBound($PixelTopLeft)]
    For $i = 0 To UBound($PixelTopLeft) - 1
        $PixelTopLeftFurther[$i] = _GetOffsetTroopFurther($PixelTopLeft[$i], $eVectorLeftTop, $offsetArcher)
    Next
    Global $PixelBottomLeftFurther[UBound($PixelBottomLeft)]
    For $i = 0 To UBound($PixelBottomLeft) - 1
        $PixelBottomLeftFurther[$i] = _GetOffsetTroopFurther($PixelBottomLeft[$i], $eVectorLeftBottom, $offsetArcher)
    Next
    Global $PixelTopRightFurther[UBound($PixelTopRight)]
    For $i = 0 To UBound($PixelTopRight) - 1
        $PixelTopRightFurther[$i] = _GetOffsetTroopFurther($PixelTopRight[$i], $eVectorRightTop, $offsetArcher)
    Next
    Global $PixelBottomRightFurther[UBound($PixelBottomRight)]
    For $i = 0 To UBound($PixelBottomRight) - 1
        $PixelBottomRightFurther[$i] = _GetOffsetTroopFurther($PixelBottomRight[$i], $eVectorRightBottom, $offsetArcher)
    Next
    debugRedArea("PixelTopLeftFurther " + UBound($PixelTopLeftFurther))
 
 
    If UBound($PixelTopLeft) < 10 Then
        $PixelTopLeft = _GetVectorOutZone($eVectorLeftTop)
        $PixelTopLeftFurther =$PixelTopLeft
    EndIf
    If UBound($PixelBottomLeft) < 10 Then
        $PixelBottomLeft = _GetVectorOutZone($eVectorLeftBottom)
        $PixelBottomLeftFurther =$PixelBottomLeft
    EndIf
    If UBound($PixelTopRight) < 10 Then
        $PixelTopRight = _GetVectorOutZone($eVectorRightTop)
        $PixelTopRightFurther =$PixelTopRight
    EndIf
    If UBound($PixelBottomRight) < 10 Then
        $PixelBottomRight = _GetVectorOutZone($eVectorRightBottom)
        $PixelBottomRightFurther =$PixelBottomRight
    EndIf
 
    debugRedArea($nameFunc & "  Size of arr pixel for TopLeft [" & UBound($PixelTopLeft) & "] /  BottomLeft [" & UBound($PixelBottomLeft) & "] /  TopRight [" & UBound($PixelTopRight) & "] /  BottomRight [" & UBound($PixelBottomRight) & "] ")
    $PixelRedArea[0] = $PixelTopLeft
    $PixelRedArea[1] = $PixelBottomLeft
    $PixelRedArea[2] = $PixelTopRight
    $PixelRedArea[3] = $PixelTopRight
    debugRedArea($nameFunc & " OUT ")
EndFunc   ;==>_GetRedArea
 
Func GetPixelSide($listPixel,$index)
    Local $listPixelSideStr = StringSplit($listPixel[$index], "|")
 
 
    Local $listPixelSide[ UBound($listPixelSideStr)-1]
    For $i=0 to UBound($listPixelSide)-1
        Local $pixelStr=StringSplit($listPixelSideStr[$i+1], "-")
        Local $pixel[2]=[$pixelStr[1],$pixelStr[2]]
        $listPixelSide[$i] = $pixel
    Next
    return $listPixelSide
EndFunc
 
 
; Search the closer array of pixel in the array of pixel
Func _FindPixelCloser($arrPixel, $pixel, $nb = 1)
    Local $arrPixelCloser[0]
    For $j = 0 To $nb
        Local $PixelCloser = $arrPixel[0]
        For $i = 0 To UBound($arrPixel) - 1
            $alreadyExist = False
            Local $arrTemp = $arrPixel[$i]
 
            If ((Abs($arrTemp[0] - $pixel[0]) < Abs($PixelCloser[0] - $pixel[0]) Or $pixel[0] = -1) And (Abs($arrTemp[1] - $pixel[1]) < Abs($PixelCloser[1] - $pixel[1]) Or $pixel[1] = -1)) Then
                For $k = 0 To UBound($arrPixelCloser) - 1
                    Local $arrTemp2 = $arrPixelCloser[$k]
                    If ($arrTemp[0] = $arrTemp2[0] And $arrTemp[1] = $arrTemp2[1]) Then
                        $alreadyExist = True
                        ExitLoop
                    EndIf
                Next
                If ($alreadyExist = False) Then
                    $PixelCloser = $arrTemp
                EndIf
            EndIf
        Next
        ReDim $arrPixelCloser[UBound($arrPixelCloser) + 1]
        $arrPixelCloser[UBound($arrPixelCloser) - 1] = $PixelCloser
 
    Next
    Return $arrPixelCloser
EndFunc   ;==>_FindPixelCloser
 
Func _ReduceMemory($PID)
    Local $dll = DllOpen("kernel32.dll")
    Local $ai_Handle = DllCall($dll, 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $PID)
    Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
    DllCall($dll, 'int', 'CloseHandle', 'int', $ai_Handle[0])
    DllClose($dll)
    Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory
 
Func debugRedArea($string)
    If $debugRedArea = 1 Then
        _FileWriteLog(FileOpen($dirLogs & "debugRedArea.log", $FO_APPEND), $string)
    EndIf
EndFunc   ;==>debugRedArea
 
 
 
Func _GetOffsetTroopFurther($pixel, $eVectorType, $offset)
    debugRedArea("_GetOffsetTroopFurther IN")
    Local $xMin, $xMax, $yMin, $yMax, $xStep, $yStep, $xOffset, $yOffset
    Local $vectorRedArea[0]
    Local $pixelOffset = GetOffestPixelRedArea2($pixel, $eVectorType, $offset)
    If ($eVectorType = $eVectorLeftTop) Then
        $xMin = 74
        $xMax = 433
        $yMin = 320
        $yMax = 60
        $xStep = 4
        $yStep = -3
        $yOffset = -1*$offset
        $xOffset = Floor($yOffset)
    ElseIf ($eVectorType = $eVectorRightTop) Then
        $xMin = 417
        $xMax = 800
        $yMin = 39
        $yMax = 320
        $xStep = 4
        $yStep = 3
        $yOffset = -1*$offset
        $xOffset = Floor($yOffset) * -1
    ElseIf ($eVectorType = $eVectorLeftBottom) Then
        $xMin = 75
        $xMax = 451
        $yMin = 298
        $yMax = 580
        $xStep = 4
        $yStep = 3
        $yOffset = $offset
        $xOffset = Floor($yOffset) * -1
    Else
        $xMin = 433
        $xMax = 800
        $yMin = 570
        $yMax = 300
        $xStep = 4
        $yStep = -3
        $yOffset = $offset
        $xOffset = Floor($yOffset)
    EndIf
 
 
 
    Local $y = $yMin
    Local $found = False
    For $x = $xMin To $xMax Step $xStep
        If ($eVectorType = $eVectorRightBottom And $y > $yMax And $pixelOffset[0] > $x And $pixelOffset[1] > $y) Then
            $pixelOffset[0] = $x + $xOffset
            $pixelOffset[1] = $y + $yOffset
            $found = True
        ElseIf ($eVectorType = $eVectorLeftBottom And $y < $yMax And $pixelOffset[0] < $x And $pixelOffset[1] > $y) Then
            $pixelOffset[0] = $x + $xOffset
            $pixelOffset[1] = $y + $yOffset
            $found = True
        ElseIf ($eVectorType = $eVectorLeftTop And $y > $yMax And $pixelOffset[0] < $x And $pixelOffset[1] < $y) Then
            $pixelOffset[0] = $x + $xOffset
            $pixelOffset[1] = $y + $yOffset
 
            $found = True
        ElseIf ($eVectorType = $eVectorRightTop And $y < $yMax And $pixelOffset[0] > $x And $pixelOffset[1] < $y) Then
            $pixelOffset[0] = $x + $xOffset
            $pixelOffset[1] = $y + $yOffset
            $found = True
        EndIf
 
        $y += $yStep
        If ($found) Then ExitLoop
    Next
    ; Not select pixel in menu of troop
    If $pixelOffset[1] > 547 Then
        $pixelOffset[1]  = 547
    EndIf
    debugRedArea("$pixelOffset x : [" + $pixelOffset[0] + "] / y : [" + $pixelOffset[1] + "]")
 
    Return $pixelOffset
EndFunc   ;==>_GetOffsetTroopFurther
 
 
 
; Param :   $pixel : The pixel to add an offset
;           $xSign : The translation on X
;           $ySign : The translation on Y
;           $hBitmap : handle of bitmap
; Return :  The pixel with offset
; Strategy :
;           According to the type of translation search the color of pixels around the current pixel
;           With the different of red color, we know how to make the offset (top,bottom,left,right)
Func GetOffestPixelRedArea2($pixel, $eVectorType, $offset = 3)
    ; $nameFunc = "[GetOffestPixelRedArea] "
    ;  debugRedArea($nameFunc&" IN")
    Local $pixelOffest = $pixel
 
    If ($eVectorType = $eVectorLeftTop) Then
        $pixelOffest[0] = Round($pixel[0] - $offset * 4 / 3)
        $pixelOffest[1] = $pixel[1] - $offset
    ElseIf ($eVectorType = $eVectorRightBottom) Then
        $pixelOffest[0] = Round($pixel[0] + $offset * 4 / 3)
        $pixelOffest[1] = $pixel[1] + $offset
    ElseIf ($eVectorType = $eVectorLeftBottom) Then
        $pixelOffest[0] = Round($pixel[0] - $offset * 4 / 3)
        $pixelOffest[1] = $pixel[1] + $offset
    ElseIf ($eVectorType = $eVectorRightTop) Then
        $pixelOffest[0] = Round($pixel[0] + $offset * 4 / 3)
        $pixelOffest[1] = $pixel[1] - $offset
    EndIf
    ; Not select pixel in menu of troop
    If $pixelOffest[1] > 547 Then
        $pixelOffest[1]  = 547
    EndIf
    ; debugRedArea($nameFunc&" OUT")
    Return $pixelOffest
 
 
EndFunc   ;==>GetOffestPixelRedArea2
 
 
; Param :   $troop : Troop to deploy
;           $arrPixel : Array of pixel where troop are deploy
;           $number : Number of troop to deploy
; Strategy :
; While troop left :
;   If number of troop > number of pixel => Search the number of troop to deploy by pixel
;   Else Search the offset to browse the tab of pixel
;   Browse the tab of pixel and send troop
Func DropOnPixel($troop, $listArrPixel, $number, $slotsPerEdge = 0)
 
    $nameFunc = "[DropOnPixel]"
    debugRedArea($nameFunc & " IN ")
    debugRedArea("troop : [" & $troop & "] / size arrPixel [" & UBound($listArrPixel) & "] / number [" & $number & "]/ $slotsPerEdge [" & $slotsPerEdge & "] ")
    If ($number = 0 Or UBound($listArrPixel) = 0) Then Return
    If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
        For $i = 0 To UBound($listArrPixel) - 1
            debugRedArea("$listArrPixel $i : [" & $i & "] ")
            Local $arrPixel = $listArrPixel[$i]
            debugRedArea("$arrPixel $UBound($arrPixel) : [" & UBound($arrPixel) & "] ")
            If UBound($arrPixel) > 0 Then
                Local $pixel = $arrPixel[0]
                Click($pixel[0], $pixel[1], $number, 250)
            EndIf
            If _Sleep(50) Then Return
        Next
    ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
        Local $half = Ceiling($number / 2)
        If UBound($listArrPixel) > 0 Then
            Local $arrPixel = $listArrPixel[0]
            If UBound($arrPixel) > 0 Then
                Local $pixel = $arrPixel[0]
                Click($pixel[0], $pixel[1], $half)
            EndIf
            If UBound($listArrPixel) > 1 Then
                If _Sleep(SetSleep(0)) Then Return
                Local $arrPixel = $listArrPixel[1]
                If UBound($arrPixel) > 0 Then
                    Local $pixel = $arrPixel[0]
                    Click($pixel[0], $pixel[1], $half)
                EndIf
            EndIf
            If _Sleep(SetSleep(0)) Then Return
        EndIf
        If UBound($listArrPixel) > 0 Then
            Local $arrPixel = $listArrPixel[0]
            If UBound($arrPixel) > 1 Then
                Local $pixel = $arrPixel[1]
                Click($pixel[0], $pixel[1], $half)
            EndIf
            If UBound($listArrPixel) > 1 Then
                If _Sleep(SetSleep(0)) Then Return
                Local $arrPixel = $listArrPixel[1]
                If UBound($arrPixel) > 1 Then
                    Local $pixel = $arrPixel[1]
                    Click($pixel[0], $pixel[1], $half)
                EndIf
            EndIf
            If _Sleep(SetSleep(0)) Then Return
        EndIf
    Else
        For $i = 0 To UBound($listArrPixel) - 1
            debugRedArea("$listArrPixel $i : [" & $i & "] ")
            Local $nbTroopsLeft = $number
            Local $offset = 1
            Local $nbTroopByPixel = 1
            Local $arrPixel = $listArrPixel[$i]
            ;   SetLog("UBound($edge) " & UBound($arrPixel) & "$number :"& $number , $COLOR_GREEN)
            While ($nbTroopsLeft > 0)
                If (UBound($arrPixel) = 0) Then
                    ExitLoop
                EndIf
                If (UBound($arrPixel) > $nbTroopsLeft) Then
                    $offset = UBound($arrPixel) / $nbTroopsLeft
                Else
                    $nbTroopByPixel = Floor($number / UBound($arrPixel))
                EndIf
                If ($offset < 1) Then
                    $offset = 1
                EndIf
                If ($nbTroopByPixel < 1) Then
                    $nbTroopByPixel = 1
                EndIf
                For $j = 0 To UBound($arrPixel) - 1 Step $offset
                    Local $index = Round($j)
                    If ($index > UBound($arrPixel) - 1) Then
                        $index = UBound($arrPixel) - 1
                    EndIf
                    Local $currentPixel = $arrPixel[Floor($index)]
                    Click($currentPixel[0], $currentPixel[1], $nbTroopByPixel)
                    $nbTroopsLeft -= $nbTroopByPixel
 
 
                    If _Sleep(SetSleep(0)) Then Return
                Next
            WEnd
        Next
    EndIf
    debugRedArea($nameFunc & " OUT ")
EndFunc   ;==>DropOnPixel
 
 
; Param :   $arrPixel : Array of pixel where troop are deploy
;           $vectorDirection : The vector direction => 0 = Left To Right (x asc) / 1 = Top to Bottom (y asc)
;           $sizeVector : Number of pixel for the vector
; Return :  The vector of pixel
; Strategy :
;           Get min / max pixel of array pixel
;           Get min / max value of x or y (depends vector direction)
;           Get the offset to browse the array pixel (depends of size vector)
;           For min to max with offset , get pixel closer and add to the vector
Func GetVectorPixelToDeploy($arrPixel, $vectorDirection, $sizeVector)
    Local $vectorPixel[0]
    debugRedArea("GetVectorPixelToDeploy IN")
    debugRedArea("size " & UBound($arrPixel))
    If (UBound($arrPixel) > 1) Then
        Local $pixelSearch[2] = [-1, -1]
        Local $minPixel = $arrPixel[0]
        Local $maxPixel = $arrPixel[UBound($arrPixel) - 1]
        Local $min = $minPixel[$vectorDirection]
        Local $max = $maxPixel[$vectorDirection]
        Local $offset = ($max - $min) / $sizeVector
        debugRedArea("min : [" & $min & "] / max [" & $max & "] / offset [" & $offset & "]")
        For $i = $min To $max Step $offset
            $pixelSearch[$vectorDirection] = $i
            Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
            ReDim $vectorPixel[UBound($vectorPixel) + 1]
            $vectorPixel[UBound($vectorPixel) - 1] = $arrPixelCloser[0]
        Next
 
    EndIf
    Return $vectorPixel
EndFunc   ;==>GetVectorPixelToDeploy
 
Func GetVectorPixelAverage($arrPixel, $vectorDirection)
    Local $vectorPixelAverage[1]
    debugRedArea("GetVectorPixelAverage IN $vectorDirection [" & $vectorDirection & "]")
    If (UBound($arrPixel) > 1) Then
        Local $pixelSearch[2] = [-1, -1]
        Local $minPixel = $arrPixel[0]
        Local $maxPixel = $arrPixel[UBound($arrPixel) - 1]
        Local $min = $minPixel[$vectorDirection]
        Local $max = $maxPixel[$vectorDirection]
        Local $posAverage = ($max - $min) / 2
        debugRedArea("GetVectorPixelAverage IN $min [" & $min & "]")
        debugRedArea("GetVectorPixelAverage IN $max [" & $max & "]")
 
        $pixelSearch[$vectorDirection] = $min + $posAverage
        debugRedArea("GetVectorPixelAverage $pixelSearch x : [" & $pixelSearch[0] & "] / y [" & $pixelSearch[1] & "] ")
        Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
        Local $arrTemp = $arrPixelCloser[0]
        debugRedArea("GetVectorPixelAverage $arrTemp x : [" & $arrTemp[0] & "] / y [" & $arrTemp[1] & "] ")
        $vectorPixelAverage[0] = $arrPixelCloser[0]
 
 
    EndIf
    Return $vectorPixelAverage
EndFunc   ;==>GetVectorPixelAverage
 
Func GetVectorPixelOnEachSide($arrPixel, $vectorDirection)
    Local $vectorPixelEachSide[2]
    If (UBound($arrPixel) > 1) Then
        Local $pixelSearch[2] = [-1, -1]
        Local $minPixel = $arrPixel[0]
        Local $maxPixel = $arrPixel[UBound($arrPixel) - 1]
        Local $min = $minPixel[$vectorDirection]
        Local $max = $maxPixel[$vectorDirection]
        Local $posSide = ($max - $min) / 4
 
        $pixelSearch[$vectorDirection] = $min + $posSide
        Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
        $vectorPixelEachSide[0] = $arrPixelCloser[0]
 
        $pixelSearch[$vectorDirection] = $min + $posSide * 3
        Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
        $vectorPixelEachSide[1] = $arrPixelCloser[0]
 
 
    EndIf
    Return $vectorPixelEachSide
EndFunc   ;==>GetVectorPixelOnEachSide
 
 
Func DropTroop($troop, $nbSides, $number, $slotsPerEdge = 0)
    $nameFunc = "[DropTroop]"
    debugRedArea($nameFunc & " IN ")
    debugRedArea("troop : [" & $troop & "] / nbSides : [" & $nbSides & "] / number : [" & $number & "] / slotsPerEdge [" & $slotsPerEdge & "]")
 
 
    If ($chkRedArea) Then
 
        If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
        If _Sleep(100) Then Return
        SelectDropTroop($troop) ;Select Troop
        If _Sleep(300) Then Return
 
        If $nbSides < 1 Then Return
        Local $nbTroopsLeft = $number
        If $nbSides = 4 Then
            Local $edgesPixelToDrop = GetPixelDropTroop($troop, $number, $slotsPerEdge)
 
            For $i = 0 To $nbSides - 3
                Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
                Local $listEdgesPixelToDrop[2] = [$edgesPixelToDrop[$i], $edgesPixelToDrop[$i + 2]]
                DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)
                $nbTroopsLeft -= $nbTroopsPerEdge * 2
            Next
            Return
        EndIf
 
 
        For $i = 0 To $nbSides - 1
 
            If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
 
                Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i))
                Local $edgesPixelToDrop = GetPixelDropTroop($troop, $nbTroopsPerEdge, $slotsPerEdge)
                Local $listEdgesPixelToDrop[1] = [$edgesPixelToDrop[$i]]
                DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)
                $nbTroopsLeft -= $nbTroopsPerEdge
            ElseIf ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
                Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
                Local $edgesPixelToDrop = GetPixelDropTroop($troop, $nbTroopsPerEdge, $slotsPerEdge)
                Local $listEdgesPixelToDrop[2] = [$edgesPixelToDrop[$i + 3], $edgesPixelToDrop[$i + 1]]
 
                DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)
                $nbTroopsLeft -= $nbTroopsPerEdge * 2
            EndIf
        Next
 
    Else
        DropOnEdges($troop, $nbSides, $number, $slotsPerEdge)
    EndIf
 
    debugRedArea($nameFunc & " OUT ")
 
EndFunc   ;==>DropTroop
 
Func GetPixelDropTroop($troop, $number, $slotsPerEdge)
    Local $newPixelTopLeft
    Local $newPixelBottomLeft
    Local $newPixelTopRight
    Local $newPixelBottomRight
 
    If ($troop = $eArcher Or $troop = $eWizard Or $troop = $eMinion) Then
        $newPixelTopLeft = $PixelTopLeftFurther
        $newPixelBottomLeft = $PixelBottomLeftFurther
        $newPixelTopRight = $PixelTopRightFurther
        $newPixelBottomRight = $PixelBottomRightFurther
 
    Else
        $newPixelTopLeft = $PixelTopLeft
        $newPixelBottomLeft = $PixelBottomLeft
        $newPixelTopRight = $PixelTopRight
        $newPixelBottomRight = $PixelBottomRight
    EndIf
 
    If ($slotsPerEdge = 1) Then
        $newPixelTopLeft = GetVectorPixelAverage($newPixelTopLeft, 0)
        $newPixelBottomLeft = GetVectorPixelAverage($newPixelBottomLeft, 1)
        $newPixelTopRight = GetVectorPixelAverage($newPixelTopRight, 1)
        $newPixelBottomRight = GetVectorPixelAverage($newPixelBottomRight, 0)
    ElseIf ($slotsPerEdge = 2) Then
        $newPixelTopLeft = GetVectorPixelOnEachSide($newPixelTopLeft, 0)
        $newPixelBottomLeft = GetVectorPixelOnEachSide($newPixelBottomLeft, 1)
        $newPixelTopRight = GetVectorPixelOnEachSide($newPixelTopRight, 1)
        $newPixelBottomRight = GetVectorPixelOnEachSide($newPixelBottomRight, 0)
    Else
        debugRedArea("GetPixelDropTroop :  $slotsPerEdge [" & $slotsPerEdge & "] ")
        $newPixelTopLeft = GetVectorPixelToDeploy($newPixelTopLeft, 0, $slotsPerEdge)
        $newPixelBottomLeft = GetVectorPixelToDeploy($newPixelBottomLeft, 1, $slotsPerEdge)
        $newPixelTopRight = GetVectorPixelToDeploy($newPixelTopRight, 1, $slotsPerEdge)
        $newPixelBottomRight = GetVectorPixelToDeploy($newPixelBottomRight, 0, $slotsPerEdge)
 
    EndIf
    Local $edgesPixelToDrop[4] = [$newPixelBottomRight, $newPixelTopLeft, $newPixelBottomLeft, $newPixelTopRight]
    Return $edgesPixelToDrop
EndFunc   ;==>GetPixelDropTroop
 
Func _GetVectorOutZone($eVectorType)
    debugRedArea("_GetVectorOutZone IN")
    Local $vectorOutZone[0]
 
    If ($eVectorType = $eVectorLeftTop) Then
        $xMin = 426
        $yMin = 10
        $xMax = 31
        $yMax = 300
        $xStep = -4
        $yStep = 3
    ElseIf ($eVectorType = $eVectorRightTop) Then
        $xMin = 426
        $yMin = 10
        $xMax = 834
        $yMax = 312
        $xStep = 4
        $yStep = 3
    ElseIf ($eVectorType = $eVectorLeftBottom) Then
        $xMin = 24
        $yMin = 307
        $xMax = 336
        $yMax = 540
        $xStep = 4
        $yStep = 3
    Else
        $xMin = 834
        $yMin = 312
        $xMax = 545
        $yMax = 544
        $xStep = -4
        $yStep = 3
    EndIf
 
 
    Local $pixel[2]
    Local $x = $xMin
    For $y = $yMin To $yMax Step $yStep
        $x += $xStep
        $pixel[0] = $x
        $pixel[1] = $y
        ReDim $vectorOutZone[UBound($vectorOutZone) + 1]
        $vectorOutZone[UBound($vectorOutZone) - 1] = $pixel
 
    Next
 
    Return $vectorOutZone
EndFunc   ;==>_GetVectorOutZone