select distinct A.Area_name, C.Charge_amount, V.Visit_datetime, V.Exit_datetime
from Provided_at as P, Visits as V, Charge as C, Area as A
where A.Area_ID=V.Area_ID and
	  V.Area_ID=P.Area_ID and 
	  C.Service_ID=P.Service_ID and
	  V.Visit_datetime between '2021-05-10' and '2021-05-20'
	  and P.Service_ID=2
order by V.Visit_datetime asc