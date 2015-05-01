Global $atkDElix[19]

For $i = 0 To 18
	$atkDElix[$i] = @ScriptDir & "\images\DElix\DE" & $i + 1 & ".bmp"
Next

Global $Tolerance1

Func checkDarkElix()
	If _Sleep(500) Then Return
    For $i = 0 To 18
	   For $Tolerance1 = 70 to 80
		   _CaptureRegion()
		   $DELocation = _ImageSearch($atkDElix[$i], 1, $DElixx, $DElixy, $Tolerance1)
		   If $DELocation = 1 Then
			   Return $DELocation
			   ExitLoop
		   EndIf
	   Next
	Next
	If $DELocation = 0 Then
		$DElixx = 0
		$DElixy = 0
		Return $DELocation
	EndIf
EndFunc   ;==>checkDarkElix
