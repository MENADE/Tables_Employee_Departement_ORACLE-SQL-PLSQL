/*
Jeu de tests
Cas 1 : num�ro d�partement is NULL, message d'erreur "Le num�ro de d�partement est obligatoire !"
Cas 2 : taux d'augmentation is NULL, message d'erreur "Il faut saisir le taux d''augmentation"
Cas 3 : taux d'augmentation <=0,  message d'erreur "Le taux d''augmentation doit �tre > 0 !"
Cas 4 : num�ro d�partement incorrect, message d'erreur
Cas 5 : d�partement qui contient seulement un chef - pas d'augmentation
Cas 6 : Montant Global > 150 000, pas d'augmentation
Cas 7 : variable qui retourne nombre de modif dans la procedure retourn -1, message d'erreur "Erreur inconnue 
        lors de l'execution de la proc�dure"
Cas 7 : num�ro d�partement correct et taux d'augmentation correct et condition d'augmentation v�rifie�s, message
        pr�cisant le nombre de salari�s augment�s.
Cas 8 : Exception, pour les autres situation avec un message "Erreur inconnue"
*/
set serveroutput on
set verify off
accept numDeptInput prompt 'Entrez le num�ro du d�partement : '
accept tauxAugmentation prompt 'Entrez le taux d''augmentation un chiffre en 0% et 100% :'
declare
numDept departements.numerodepartement%type;
tauxAugmt number(5,2);
nbreModif number(9);
begin
numDept:='&numDeptInput';
if (numDept is null) then
 dbms_output.put_line('Le num�ro de d�partement est obligatoire ! ');
else
     tauxAugmt:='&tauxAugmentation';
     if (tauxAugmt is null) then
      dbms_output.put_line('Il faut saisir le taux d''augmentation !');
     else if (tauxAugmt<=0) then
            dbms_output.put_line('Le taux d''augmentation doit �tre > 0 !');
          else
            augmentesalaire(numDept,tauxAugmt,nbreModif);
                if (nbreModif=-1) then
                   dbms_output.put_line('Erreur inconnue qui a emp�cher d''effectuer l''augmentation !');
                else if (nbreModif=0) then
                       dbms_output.put_line('Le d�partement n� "'||numDept||'" soit : '||CHR(10)||CHR(9)||
                       '1) il n''existe pas,'||CHR(10)||CHR(9)||'2) soit il n''a aucun employ� ou seulement le chef de d�partement,'
                       ||CHR(10)||CHR(9)||'2) soit le montant global des salaires des employ�s de ce d�partement d�passe 150 000.');
                     else
                      dbms_output.put_line('Augmentation de salaire de '||nbremodif||' salari�(s)');
                     end if;
                end if;
          end if;
      end if;
end if;
Exception
when others then dbms_output.put_line('Erreur inconnue !');
end;
/