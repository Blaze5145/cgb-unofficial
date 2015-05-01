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
Func AttackReport()

Local $lootGold
Local $lootElixir
Local $lootDarkElixir
Local $lootTrophies

   SetLog("Attack Report", $COLOR_GREEN)

   If _ColorCheck(_GetPixelColor(459, 372), Hex(0x433350, 6), 20) Then  ; if the color of the DE drop detected
    $lootGold   	= GetReturnHome(320,289, "ReturnResource")
    $lootElixir		= GetReturnHome(320,328, "ReturnResource")
    $lootDarkElixir	= GetReturnHome(320,366, "ReturnResource")
    $lootTrophies	= GetReturnHome(400,402, "ReturnTrophies")
    SetLog("Loot: [G]: " & $lootGold & " [E]: " & $lootElixir & " [DE]: " & $lootDarkElixir & " [T]: " & $lootTrophies, $COLOR_GREEN)
   Else
    $lootGold		= GetReturnHome(320,289, "ReturnResource")
    $lootElixir		= GetReturnHome(320,328, "ReturnResource")
    $lootTrophies	= GetReturnHome(400,365, "ReturnTrophies") ; 1 pixel higher
    SetLog("Loot: [G]: " & $lootGold & " [E]: " & $lootElixir & " [DE]: " & "" & " [T]: " & $lootTrophies, $COLOR_GREEN)
   EndIf

EndFunc
