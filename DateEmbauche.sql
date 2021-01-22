create or replace trigger DateEmbauche
before insert or update of dateEmbaucheEmploye on Employes
for each row
declare
dateEmbaucheValide date;
numeroDepartementValide employes.numerodepartement%type;
dateCreatDepartConcerne date;
begin
numeroDepartementValide:=:new.numeroDepartement;
if numeroDepartementValide is not null then     
       dateEmbaucheValide:=:new.dateEmbaucheEmploye;        
    if dateEmbaucheValide is  not null  then
       select dateCreationDepartement into dateCreatDepartConcerne from departements
       where numeroDepartement=numeroDepartementValide;
         if dateCreatDepartConcerne > dateEmbaucheValide then
            RAISE_APPLICATION_ERROR(-20100, 'Transaction refus�e, la date d''embauche doit �tre > date de cr�ation du d�partement!');     
         end if;      
    end if;
end if;
end;
/

/*
Jeu de Tests
Cas 1 : update employes set dateEmbaucheEmploye='01/01/2000' where numeroEmploye=1;
:new.numeroDepartement = :old.numeroDepartement =NULL, 1 ligne mis � jour.
(Condition satisfaite car l'employe n'appartient � aucun d�partement)

Cas 2 : update employes set dateEmbaucheEmploye='01/01/1990' where numeroEmploye=2;
:new.numeroDepartement = :old.numeroDepartement =DP0001, :new.dateEmbaucheEmploye='01/01/1990',
message d'erreur "Transaction refus�e, la date d''embauche doit �tre > date de cr�ation du d�partement"
(condition non satisfaite, car la date de cr�ation du d�partement DEP001 est le 12/09/1992 )

Cas 3 : update employes set dateEmbaucheEmploye='01/01/1998' where numeroEmploye=2;
:new.numeroDepartement = :old.numeroDepartement =DP0001, 1 ligne mis � jour.
(condition satisfaite car la date de cr�ation du d�partement DEP001 est le 12/09/1992 )

Cas 4 : INSERT INTO Employes VALUES (18, 'Heisenberg', 'Lisa', '8764, Rue du coll�ge',            
'Longueuil', '', 'H1A2C6', 5146325943, 'Assistant', 25127.64,              
NULL, NULL,1, '01/01/1990', '26/02/1968');
:new.numeroDepartement=null, 1 ligne mis � jour.
(Condition satisfaite car l'employe n'appartient � aucun d�partement)

Cas 5 : INSERT INTO Employes VALUES (18, 'Heisenberg', 'Lisa', '8764, Rue du coll�ge',            
'Longueuil', '', 'H1A2C6', 5146325943, 'Assistant', 25127.64,              
NULL, 'DEP002',1, '01/01/1990', '26/02/1968');
:new.numeroDepartement=DEP002, message d'erreur "Transaction refus�e,
la date d''embauche doit �tre > date de cr�ation du d�partement"
(condition non satisfaite, car la date de cr�ation du d�partement DEP002 est le 13/03/1993 )

Cas 6 : INSERT INTO Employes VALUES (18, 'Heisenberg', 'Lisa', '8764, Rue du coll�ge',            
'Longueuil', '', 'H1A2C6', 5146325943, 'Assistant', 25127.64,              
NULL, 'DEP002',1, '15/03/1993', '26/02/1968');
:new.numeroDepartement=DEP002, 1 ligne mis � jour.
(condition satisfaite car la date de cr�ation du d�partement DEP002 est le 13/03/1993 )

Cas 6 : INSERT INTO Employes VALUES (19, 'Heisenberg', 'Lisa', '8764, Rue du coll�ge',            
'Longueuil', '', 'H1A2C6', 5146325943, 'Assistant', 25127.64,              
NULL, NULL,1, null, '26/02/1968');
:new.numeroDepartement=NULL,:new.dateEmbaucheEmploye=NULL, 1 ligne mis � jour.
(Car dans la table employ� le num�ro de d�partement et la date d'embauche peuvent �tre nuls).
*/