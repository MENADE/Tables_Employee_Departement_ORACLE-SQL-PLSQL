/*
Jeu de tests
Cas 1 : date limite d'anciennet� is NULL, message d'erreur "La date limite est obligatoire !"
Cas 2 : si date limite d'anciennet� < min dateEmbauche ou > date system, message d'erreur 
     "La date limite doit �tre entre date min dateEmbauche et la date system au moment de l'execution "
Cas 3 : Si la valeur du retour de la fonction est diff�rent de  -1, affichage du r�sultat des totaux des
        salaires des ancien employ�s par rapport a la date donn� en param�tres.
Cas 4 : Si la valeur du retour de la fonction est �gale � -1, message d'erreur "Une erreur inconnue est 
            survenue lors de l'execution de la fonction"
Cas 5 : Exception,  pour les autres situations avec un message "Erreur inconnue"
*/
set serveroutput on
set verify off
accept dateLimiteAnciennte prompt 'Entrez la date limite d''anciennet� :'
declare
dateLimiteAncInput employes.dateembaucheemploye%type;
minDateEmbauche  employes.dateembaucheemploye%type;
begin
dateLimiteAncInput:='&dateLimiteAnciennte';
if (dateLimiteAncInput is null) then
    dbms_output.put_line('La date limite est obligatoire pour d�terminer l''anciennet� d''un employ� !');
else
     select min(dateembaucheemploye)  into minDateEmbauche from employes ;     
     if (dateLimiteAncInput<minDateEmbauche or dateLimiteAncInput> sysdate) then
        dbms_output.put_line('La date limite doit �tre entre '||minDateEmbauche||' et '||sysdate);
     else
          if(MaxTotalSalaires(dateLimiteAncInput) <> -1)  then
            dbms_output.put_line('La valeur maximale des totaux des salaires des anciens employ�s est : '||
            MaxTotalSalaires(dateLimiteAncInput));
          else
           dbms_output.put_line ('Une erreur inconnue est survenue � l''execution de la fonction');
          end if;     
     end if;
end if;
Exception 
when others then dbms_output.put_line ('Erreur inconue !');
end;
/