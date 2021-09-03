select top 15 count(A.Area_name) as Count, A.Area_name
from Visits as V, Area as A, Customer as C
where V.Area_ID=A.Area_ID and
	  V.NFC_ID=C.NFC_ID and
	  /*V.Visit_datetime>'2021/05/20' and*/
	  C.Birthdate between '1961' and '1981'
group by A.Area_name
order by count(A.Area_name) desc