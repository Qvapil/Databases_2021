select V2.NFC_ID, A.Area_name, V2.Visit_datetime, V2.Exit_datetime
from Visits as V1, Area as A, Visits as V2
where V1.Area_ID=A.Area_ID and 
	  V2.Area_ID=V1.Area_ID and 
	  V1.NFC_ID=15 and
	  V2.NFC_ID<>V1.NFC_ID and
	  V2.Exit_datetime between V1.Visit_datetime and V1.Exit_datetime+0.05
order by V1.Visit_datetime