;Returns color of pixel in the coordinations

Func _GetPixelColor($iX, $iY,$hBitmapLocal = $hBitmap)
	Local $aPixelColor = _GDIPlus_BitmapGetPixel($hBitmapLocal, $iX, $iY)
	Return Hex($aPixelColor, 6)
 EndFunc   ;==>_GetPixelColor