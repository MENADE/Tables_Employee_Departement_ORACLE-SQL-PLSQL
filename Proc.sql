/*
Jeu de tests
Cas 1 : numéro département is NULL, message d'erreur "Le numéro de département est obligatoire !"
Cas 2 : taux d'augmentation is NULL, message d'erreur "Il faut saisir le taux d''augmentation"
Cas 3 : taux d'augmentation <=0,  message d'erreur "Le taux d''augmentation doit être > 0 !"
Cas 4 : numéro département incorrect, message d'erreur
Cas 5 : département qui contient seulement un chef - pas d'augmentation
Cas 6 : Montant Global > 150 000, pas d'augmentation
Cas 7 : variable qui retourne nombre de modif dans la procedure retourn -1, message d'erreur "Erreur inconnue 
        lors de l'execution de la procédure"
Cas 7 : numéro département correct et taux d'augmentation correct et condition d'augmentation vérifieés, message
        précisant le nombre de salariés augmentés.
Cas 8 : Exception, pour les autres situation avec un message "Erreur inconnue"
*/
set serveroutput on
set verify off
accept numDeptInput prompt 'Entrez le numéro du département : '
accept tauxAugmentation prompt 'Entrez le taux d''augmentation un chiffre en 0% et 100% :'
declare
numDept departements.numerodepartement%type;
tauxAugmt number(5,2);
nbreModif number(9);
begin
numDept:='&numDeptInput';
if (numDept is null) then
 dbms_output.put_line('Le numéro de département est obligatoire ! ');
else
     tauxAugmt:='&tauxAugmentation';
     if (tauxAugmt is null) then
      dbms_output.put_line('Il faut saisir le taux d''augmentation !');
     else if (tauxAugmt<=0) then
            dbms_output.put_line('Le taux d''augmentation doit être > 0 !');
          else
            augmentesalaire(numDept,tauxAugmt,nbreModif);
                if (nbreModif=-1) then
                   dbms_output.put_line('Erreur inconnue qui a empêcher d''effectuer l''augmentation !');
                else if (nbreModif=0) then
                       dbms_output.put_line('Le département n° "'||numDept||'" soit : '||CHR(10)||CHR(9)||
                       '1) il n''existe pas,'||CHR(10)||CHR(9)||'2) soit il n''a aucun employé ou seulement le chef de département,'
                       ||CHR(10)||CHR(9)||'2) soit le montant global des salaires des employés de ce département dépasse 150 000.');
                     else
                      dbms_output.put_line('Augmentation de salaire de '||nbremodif||' salarié(s)');
                     end if;
                end if;
          end if;
      end if;
end if;
Exception
when others then dbms_output.put_line('Erreur inconnue !');
end;
/