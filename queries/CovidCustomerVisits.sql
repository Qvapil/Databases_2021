select A.Area_name, V.Visit_datetime, V.Exit_Datetime
from Visits as V, Area as A
where V.Area_ID=A.Area_ID and 
	  V.NFC_ID=15
order by Visit_datetime