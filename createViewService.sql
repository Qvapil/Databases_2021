create View [Service Info] as
select sum(Charge_amount) as Revenue, Charge_description, count(Charge_description) as Count
from Charge
where Service_Id>1
group by Charge_description
