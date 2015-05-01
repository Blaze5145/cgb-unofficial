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
;Returns complete value of other

Func getReturnHome($x_start, $y_start, $type)
    _CaptureRegion(0, 0, $x_start + 120, $y_start + 25)
    ;-----------------------------------------------------------------------------
    Local $x = $x_start, $y = $y_start
    Local $Number, $i = 0

    Switch $type
        Case "ReturnTrophy"
            $Number = getDigitLarge($x, $y, "ReturnHome")

            While $Number = ""
                If $i >= 50 Then ExitLoop
                $i += 1
                $x += 1
                $Number = getDigitLarge($x, $y, "ReturnHome")
            WEnd

            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")

        Case "ReturnResource"
            $Number = getDigitLarge($x, $y, "ReturnHome")

            While $Number = ""
                If $i >= 120 Then ExitLoop
                $i += 1
                $x += 1
                $Number = getDigitLarge($x, $y, "ReturnHome")
            WEnd

            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $x += 9
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $x += 9
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")

    EndSwitch

    Return $Number
EndFunc   ;==>getOther