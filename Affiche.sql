/*
Jeu de tests
Cas 1 : nom du département NULL - message d'erreur "Il faut saisir  un nom de département" 
Cas 2 : nom du département incorrect - message d'erreur "Le département n'existe pas"
Cas 3 : nom du département correct trouvé - affichage des employés et le nombre total
Cas 4 : Autres cas - exception
*/
set serveroutput on
set verify off
accept nomDeptEntree prompt 'Veuillez entrer le nom du département : '
declare
nbreTotalEmployes employes.nomemploye%type :=0; -- nombre total des employés trouvés
nomDept departements.nomdepartement%type;
Cursor cur_EmplDept is 
(select numeroEmploye,nomEmploye,dateEmbaucheemploye,
     salaireEmploye  from employes where numerodepartement=
     (select numerodepartement from departements where nomDepartement=nomDept));

begin
nomDept:='&nomDeptEntree';
if (nomDept is null) then
  dbms_output.put_line('Il faut saisir  un nom de département !');
else
    for EmplDept in cur_EmplDept loop
      nbreTotalEmployes:=nbretotalemployes+1;
    end loop;
  if (nbreTotalEmployes=0) then
    dbms_output.put_line('Le département "'||nomDept ||'" soit il n''existe pas, soit il n''a aucun employé');    
  else  
     DBMS_OUTPUT.PUT_LINE('Informations sur les salariés du département '||nomdept||' :'||CHR(10)||
                          '============================================================');
     for EmplDept in cur_EmplDept loop     
      DBMS_OUTPUT.PUT_LINE('Employé numéro : '||EmplDept.numeroemploye||CHR(10)||CHR(09)||'Nom Employé : '||
        EmplDept.nomemploye||CHR(10)||CHR(09)||'Date d''embauche : '||EmplDept.dateEmbaucheemploye
        ||CHR(10)||CHR(09)||'Salaire : '||to_char(EmplDept.salaireemploye,'999,999.99')||' $');    
     end loop;
     dbms_output.put_line('===========================================');
     dbms_output.put_line('Le nombre total d''employés trouvés est : '||nbretotalemployes);
 end if;
end if;
Exception 
when others then DBMS_OUTPUT.PUT_LINE('Erreur inconnue !');
end;
/