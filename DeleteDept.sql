/*
Jeu de tests
Cas 1 : chefDepartement is not null (Table D�partements) : D�partement non supprim�
Cas 2 : chefDepartement is null (Table D�partements) et
        numeroDepartement existe dans (Table Employes) : D�partement non supprim�        
Cas 3 : chefDepartement is null (Table D�partements) et
        numeroDepartement n'existe pas dans (Table Employes) : D�partement supprim�
*/
set serveroutput on
declare
nbreDepartementSupprimes number(6);
begin
 delete from departements where chefdepartement is null and numerodepartement not in 
 (select numerodepartement from employes where numerodepartement is not null);
  nbredepartementsupprimes:=SQL%ROWCOUNT;
 if (nbredepartementsupprimes=0) then
   dbms_output.put_line('Il n''y a pas de d�partement sans employ�s');
 else
   dbms_output.put_line(nbredepartementsupprimes||' d�partement(s) supprim�(s).');
 end if;
end;
/