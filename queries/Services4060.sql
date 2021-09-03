select S.Service_description, count(S.Service_ID) as Count
from Visits as V, Customer as C, Provided_at as P, Service as S
where V.Area_ID=P.Area_ID and
	  V.NFC_ID=C.NFC_ID and
	  P.Service_ID=S.Service_ID and
	  S.Service_description<>'stay at room' and
	  /*V.Visit_datetime>'2021/05/20' and*/
	  C.Birthdate between '1961' and '1981'
group by S.Service_description
order by count(S.Service_ID) desc
