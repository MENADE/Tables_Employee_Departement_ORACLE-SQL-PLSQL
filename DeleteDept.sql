/*
Jeu de tests
Cas 1 : chefDepartement is not null (Table Départements) : Département non supprimé
Cas 2 : chefDepartement is null (Table Départements) et
        numeroDepartement existe dans (Table Employes) : Département non supprimé        
Cas 3 : chefDepartement is null (Table Départements) et
        numeroDepartement n'existe pas dans (Table Employes) : Département supprimé
*/
set serveroutput on
declare
nbreDepartementSupprimes number(6);
begin
 delete from departements where chefdepartement is null and numerodepartement not in 
 (select numerodepartement from employes where numerodepartement is not null);
  nbredepartementsupprimes:=SQL%ROWCOUNT;
 if (nbredepartementsupprimes=0) then
   dbms_output.put_line('Il n''y a pas de département sans employés');
 else
   dbms_output.put_line(nbredepartementsupprimes||' département(s) supprimé(s).');
 end if;
end;
/