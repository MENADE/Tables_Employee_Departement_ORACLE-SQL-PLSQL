/*
Jeu de tests
Cas 1 : date limite d'ancienneté is NULL, message d'erreur "La date limite est obligatoire !"
Cas 2 : si date limite d'ancienneté < min dateEmbauche ou > date system, message d'erreur 
     "La date limite doit être entre date min dateEmbauche et la date system au moment de l'execution "
Cas 3 : Si la valeur du retour de la fonction est différent de  -1, affichage du résultat des totaux des
        salaires des ancien employés par rapport a la date donné en paramètres.
Cas 4 : Si la valeur du retour de la fonction est égale à -1, message d'erreur "Une erreur inconnue est 
            survenue lors de l'execution de la fonction"
Cas 5 : Exception,  pour les autres situations avec un message "Erreur inconnue"
*/
set serveroutput on
set verify off
accept dateLimiteAnciennte prompt 'Entrez la date limite d''ancienneté :'
declare
dateLimiteAncInput employes.dateembaucheemploye%type;
minDateEmbauche  employes.dateembaucheemploye%type;
begin
dateLimiteAncInput:='&dateLimiteAnciennte';
if (dateLimiteAncInput is null) then
    dbms_output.put_line('La date limite est obligatoire pour déterminer l''ancienneté d''un employé !');
else
     select min(dateembaucheemploye)  into minDateEmbauche from employes ;     
     if (dateLimiteAncInput<minDateEmbauche or dateLimiteAncInput> sysdate) then
        dbms_output.put_line('La date limite doit être entre '||minDateEmbauche||' et '||sysdate);
     else
          if(MaxTotalSalaires(dateLimiteAncInput) <> -1)  then
            dbms_output.put_line('La valeur maximale des totaux des salaires des anciens employés est : '||
            MaxTotalSalaires(dateLimiteAncInput));
          else
           dbms_output.put_line ('Une erreur inconnue est survenue à l''execution de la fonction');
          end if;     
     end if;
end if;
Exception 
when others then dbms_output.put_line ('Erreur inconue !');
end;
/