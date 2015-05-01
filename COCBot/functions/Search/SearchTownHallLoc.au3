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



Func FilterTH()
   	  For $i=0 to 20
		 If $Thx<52+$i*19 And $Thy<315-$i*14 Then Return False
		 If $Thx<52+$i*19 And $Thy>315+$i*14 Then Return False
 		 If $Thx>802-$i*19 And $Thy<315-$i*14 Then Return False
		 If $Thx>802-$i*19 And $Thy>315+$i*14 Then Return False
	  Next
			Return True
EndFunc



Func SearchTownHallLoc()
   If $searchTH <> "-" Then
 		 If FilterTH()=False Then Return False

	  For $i=0 to 20

		 If $Thx<114+$i*19+ceiling(($THaddtiles-2)/2*19) And $Thy<359-$i*14+ceiling(($THaddtiles-2)/2*14) Then
			$THi=$i
			$THside=0
			Return True
		 EndIf
		 If $Thx<117+$i*19+ceiling(($THaddtiles-2)/2*19) And $Thy>268+$i*14-floor(($THaddtiles-2)/2*14) Then
			$THi=$i
			$THside=1
			Return True
		 EndIf
		 If $Thx>743-$i*19-floor(($THaddtiles-2)/2*19) And $Thy<358-$i*14+ceiling(($THaddtiles-2)/2*14) Then
			$THi=$i
			$THside=2
			Return True
		 EndIf
		 If $Thx>742-$i*19-floor(($THaddtiles-2)/2*19) And $Thy>268+$i*14-floor(($THaddtiles-2)/2*14) Then
			$THi=$i
			$THside=3
			Return True
		 EndIf
		 Next
   EndIf
	Return False
EndFunc ;--- SearchTownHallLoc
