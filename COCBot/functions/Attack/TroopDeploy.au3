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
Func NameOfTroop($kind, $plurial = 0)
	Switch $kind
		Case $eBarbarian
			Return "Barbarians"
		Case $eArcher
			Return "Archers"
		Case $eGoblin
			Return "Goblins"
		Case $eGiant
			Return "Giants"
		Case $eWallbreaker
			Return "Wall Breakers"
		Case $eWizard
			Return "Wizards"
		Case $eHog
			Return "Hog Riders"
		Case $eMinion
			Return "Minions"
		Case $eKing
			Return "King"
		Case $eQueen
			Return "Queen"
		Case $eCastle
			Return "Clan Castle"
		Case $eLSpell
			Return "Lightning Spell"
		Case $eRSpell
			Return "Rage Spell"
		Case $eHSpell
			Return "Heal Spell"
		Case $eBalloon
			Return "Ballon"

		Case Else
			Return ""
	EndSwitch
EndFunc   ;==>NameOfTroop

Func SelectDropTroop($Troop)
	Click(68 + (72 * $Troop), 595)
EndFunc   ;==>SelectDropTroop

; Read the quantity for a given troop
Func ReadTroopQuantity($Troop)
	Return Number(getNormal(40 + (72 * $Troop), 565))
EndFunc   ;==>ReadTroopQuantity

Func IdentifyTroopKind($position)
	_CaptureRegion()
	$TroopPixel = _GetPixelColor(68 + (72 * $position), 595)
	If $position >= 3 Then
		$TroopPixel = _GetPixelColor(69 + (72 * $position), 595)
	EndIf
	If $position >= 7 Then
		$TroopPixel = _GetPixelColor(70 + (72 * $position), 595)
	EndIf

	If _ColorCheck($TroopPixel, Hex(0xF8B020, 6), 10) Then Return $eBarbarian ;Check if slot is Barbarian
	If _ColorCheck($TroopPixel, Hex(0xD83F68, 6), 10) Then Return $eArcher ;Check if slot is Archer
	;If _ColorCheck($TroopPixel, Hex(0x7BC950, 6), 10) Then Return $eGoblin ;Check if slot is Goblin
	If _ColorCheck($TroopPixel, Hex(0x80CE50, 6), 10) Then Return $eGoblin
	;If _ColorCheck($TroopPixel, Hex(0xF8D49E, 6), 10) Then Return $eGiant
	If _ColorCheck($TroopPixel, Hex(0xF8D8A0, 6), 10) Then Return $eGiant ;Check if slot is Giant
	If _ColorCheck($TroopPixel, Hex(0x603A30, 6), 20) Then Return $eHog
	;If _ColorCheck($TroopPixel, Hex(0x3C76B4, 6), 20) Then Return $eMinion;
	;If _ColorCheck($TroopPixel, Hex(0x4392C9, 6), 20) Then Return $eMinion
	If _ColorCheck($TroopPixel, Hex(0xF8F2D1, 6), 10) Then Return $eWizard ;Check if slot is Wizard

	If _ColorCheck($TroopPixel, Hex(0x955630, 6), 20) Then Return $eHSpell ;Check if slot is Heal Spell
	If _ColorCheck($TroopPixel, Hex(0x705C60, 6), 20) Then Return $eRSpell ;Check if slot is Rage Spell
	If _ColorCheck($TroopPixel, Hex(0xF8EB79, 6), 20) Then Return $eKing ;Check if slot is King


	$WallBPixel = _GetPixelColor(68 + (72 * $position), 610) ;
	If $position >= 3 Then
		$WallBPixel = _GetPixelColor(69 + (72 * $position), 610)
	EndIf
	If $position >= 7 Then
		$WallBPixel = _GetPixelColor(70 + (72 * $position), 610)
	EndIf

	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 632), Hex(0x0426EC, 6), 5) Then Return $eLSpell ;Check if slot is Lightning Spell

	If _ColorCheck($TroopPixel, Hex(0x60A4D0, 6), 10) And _ColorCheck($WallBPixel, Hex(0x302A2A, 6), 10) Then Return $eWallbreaker ;Check if slot is Wallbreaker
	If _ColorCheck($TroopPixel, Hex(0x4CA0D2, 6), 10) Then Return $eMinion
	If _ColorCheck($TroopPixel, Hex(0x3C76B4, 6), 20) Then Return $eMinion
	If _ColorCheck($TroopPixel, Hex(0x4392C9, 6), 20) Then Return $eMinion

	;$OtherPixel = _GetPixelColor(68 + (72 * $position), 588)
	;If _ColorCheck($OtherPixel, Hex(0x7031F0, 6), 20) Or _ColorCheck($TroopPixel, Hex(0x421E3F, 6), 20) Then Return $eQueen ;Check if slot is Queen <= level 10 Or Check if slot is Queen > level 10


	$CCPixel = _GetPixelColor(68 + (72 * $position), 585) ;
	If $position >= 3 Then
		$CCPixel = _GetPixelColor(69 + (72 * $position), 585)
	EndIf
	If $position >= 7 Then
		$CCPixel = _GetPixelColor(70 + (72 * $position), 585)
	EndIf
	If _ColorCheck($CCPixel, Hex(0x662CE6, 6), 10) Then Return $eQueen ;Check if slot is Queen <= level 10 Or Check if slot is Queen > level 10
	;If _ColorCheck($CCPixel, Hex(0x68ACD0, 6), 10) Then Return $eCastle ;Check if slot is Clan Castle
	;If _ColorCheck(_GetPixelColor(68 + (72 * $position), 585), Hex(0x68ACD2, 6), 5) Then Return $eCastle ;Check if slot is Clan Castle

	If _ColorCheck($TroopPixel, Hex(0x511510, 6), 10) Then Return $eBalloon ;Check if slot is balloon
	If _ColorCheck($TroopPixel, Hex(0x511510, 6), 10) Then Return $eBalloon ;Check if slot is balloon

	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 585), Hex(0x68ACD4, 6), 5) Then Return $eCastle ;Check if slot is Clan Castle
	If _ColorCheck(_GetPixelColor(68 + (72 * $position), 585), Hex(0x68ACD2, 6), 5) Then Return $eCastle ;Check if slot is Clan Castle



	Return -1
EndFunc   ;==>IdentifyTroopKind
