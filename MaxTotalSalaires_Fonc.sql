create or replace function MaxTotalSalaires (dateLimiteAnciennte in date) 
return number is
MaxTotSal number (12,2);
begin
select sum(salaireemploye) into MaxTotSal
from employes
where  dateembaucheemploye < dateLimiteAnciennte
group by numerodepartement
having sum(salaireemploye) >= all 
(select sum(salaireemploye) from employes 
where  dateembaucheemploye <= dateLimiteAnciennte group by numerodepartement );
return MaxTotSal;
Exception
when others then return -1;
end;
/