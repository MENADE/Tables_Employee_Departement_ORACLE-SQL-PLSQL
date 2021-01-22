Create or replace procedure AugmenteSalaire (numDeptInput in departements.nomdepartement%type,
                                                 tauxAugmentation in  number,nbreModif out number) is
begin
update employes set salaireemploye=salaireemploye*(1+tauxAugmentation/100)
where numerodepartement=numDeptInput and 
(numeroemploye <> (select chefdepartement  from departements where numerodepartement=numDeptInput))
and (select sum(salaireemploye) from employes  where numerodepartement=numDeptInput)<=150000;
nbreModif:=SQL%ROWCOUNT;
exception
when others then nbreModif:=-1;
end;
/