drop table alumni.etudiantannee;
drop table alumni.competence;
drop table alumni.experience;
drop table alumni.administrateur;
drop table alumni.contact;
drop table alumni.etudiant;
drop table alumni.salaire;
drop table alumni.entreprise;
drop table alumni.anneedeformation;

create table alumni.etudiant(
	idEtudiant int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	nom varchar(50) not null,
	prenom varchar(50) not null,
	mail varchar(255) not null,
	mdp varchar(255) not null,
	adresse varchar(255),
	telephone varchar(20),
	dateNaissance date,
	photoProfil varchar(255),
	CV varchar(255),
	souhaiteEmploi varchar(1) constraint ck_sEmploie_etu check(souhaiteEmploi in('y','n')),
	validation varchar(1) constraint ck_val_etu check(validation in('y','n'))
);

create table alumni.administrateur(
	idAdmin int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	nom varchar(50) not null,
	prenom varchar(50) not null,
	mail varchar(255) not null,
	mdp varchar(255) not null
);

create table alumni.entreprise(
    idEntreprise int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    nomEntreprise varchar(100) not null,
    adresse varchar(255)
);

create table alumni.contact(
	idContact int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	nom varchar(50) not null,
	prenom varchar(50) not null,
	mail varchar(255) not null,
	mdp varchar(255) not null,
	telephone varchar(20),
	poste varchar(100),
	idEntreprise int not null,
	validation varchar(1) constraint ck_val_contact check(validation in('y','n')),
	constraint fk_contact_entreprise FOREIGN KEY (idEntreprise) REFERENCES alumni.entreprise
);

create table alumni.experience (
    idExperience int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	idEntreprise int not null,
    idEtudiant int not null,
    typeContrat varchar(20) constraint ck_type check( typeContrat in('cdd','cdi','freelance','interim','stage')) not null,
    debut date not null,
    fin date,
    intitulePoste varchar(100) not null,
    constraint fk_exp_etu foreign key (idEtudiant) REFERENCES alumni.etudiant,
	constraint fk_exp_entre foreign key (idEntreprise) REFERENCES alumni.entreprise
);

create table alumni.competence(
    idCompetence int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    idExperience int,
	libelle varchar(50),
    constraint fk_comp_exp foreign key (idExperience) REFERENCES alumni.experience
);

create table alumni.salaire(
    idSalaire int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    idExperience int, 
    valeur double,
	annee int
);

create table alumni.anneedeformation(
	idFormation int primary key not null GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    anneeUniversitaireDebut int not null,
    anneeUniversitaireFin int not null,
    ecole varchar(50) not null,
    libelle varchar(50) not null
);

create table alumni.etudiantannee(
    idFormation int,
	idEtudiant int,
	constraint pk_formation_anneesuniv primary key(idFormation,idEtudiant),
	constraint fk_etudiant_annee foreign key (idEtudiant) REFERENCES alumni.etudiant,
	constraint fk_annee_annee foreign key (idFormation) REFERENCES alumni.anneedeformation
);


insert into alumni.administrateur(nom, prenom, mail, mdp) values
('Admin', 'Admin', 'admin@admin.com','51abb9636078defbf888d8457a7c76f85c8f114c');

insert into alumni.etudiant(nom, prenom, mail, mdp, adresse, telephone, dateNaissance, photoProfil, CV, souhaiteEmploi, validation) values
('DUPONT', 'Francois', 'francois@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '1 rue générale de gaulle 75001 PARIS', '0689236723', '1990-05-17', 'lien_photo', 'lien_cv','y','y'),
('MARTIN', 'nicolas', 'nicolas@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '23 boulevard de la gare 75013 PARIS', '0712348934', '1985-12-15', 'lien_photo', 'lien_cv','n','y'),
('NICOLAS', 'Elodie', 'elodie@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '102 allée du passoir 75009 PARIS', '0134783423', '1989-03-01', 'lien_photo', 'lien_cv','y','y'),
('YVES', 'Lucie', 'lucie@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '3 rue de paris 75003 PARIS', '0812438945', '1990-04-08', 'lien_photo', 'lien_cv','y','y'),
('HERVE', 'Thierry', 'thierry@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '123 boulevard de la gare 75001 PARIS', '0123456789', '1990-10-02', 'lien_photo', 'lien_cv','y','y'),
('LESAGE', 'Franck', 'franck@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '23 rue de paris 75004 PARIS', '0412983469', '1992-08-22', 'lien_photo', 'lien_cv','y','n'),
('DERIEN', 'Luc', 'luc@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '88 allée cassiopée 75020 PARIS', '0134894756', '1987-09-18', 'lien_photo', 'lien_cv','y','n'),
('PASCAL', 'Elisa', 'elisa@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '1 place étoile 75006 PARIS', '0745362984', '1986-11-28', 'lien_photo', 'lien_cv','n','n'),
('HERVE', 'Sophie', 'sophie@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '2 rue concorde 75003 PARIS', '0683926633', '1988-12-30', 'lien_photo', 'lien_cv','y','y'),
('HERVE', 'Sophia', 'sophia@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '23 boulevard de la gare 75004 PARIS', '0698340399', '1990-12-23', 'lien_photo', 'lien_cv','y','y'),
('HERVE', 'Noemie', 'noemie@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '12 rue de metz 75001 PARIS', '0154738279', '1985-10-18', 'lien_photo', 'lien_cv','n','y'),
('HERVE', 'François', 'francois@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '65 boulevard ', '074829389', '1987-05-16', 'lien_photo', 'lien_cv','y','y'),
('HERVE', 'Alex', 'alex@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '132 rue du génie 75003 PARIS ', '0634827384', '1989-03-06', 'lien_photo', 'lien_cv','y','y'),
('HERVE', 'Dayvid', 'dayvid@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '48 boulevard leclerc 75002 PARIS', '0749284765', '1992-04-09', 'lien_photo', 'lien_cv','n','y'),
('HERVE', 'Cedric', 'cedric@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '34 rue tolbiac 75013 PARIS', '0187349834', '1990-03-24', 'lien_photo', 'lien_cv','n','y'),
('HERVE', 'Dimitri', 'dimitri@gmail.com','00d70c561892a94980befd12a400e26aeb4b8599', '2 allée orion 75007 PARIS', '0734637277', '1990-02-11', 'lien_photo', 'lien_cv','y','y');


insert into alumni.entreprise(nomEntreprise, adresse) values
('Air France' ,'orly'),
('Monnaie de Paris' ,'Paris'),
('LCL' ,'la défense'),
('Orange' ,'gentilly'),
('Areva' ,'la defense'),
('BNP','paris'), 
('Renault','sevres'),
('ICDC', 'antony'),
('Matmut','Cergy');

insert into alumni.contact(nom, prenom, mail, mdp, telephone, poste, idEntreprise, validation)  values
('JACQUES', 'HENRY', 'henry@bnp.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0723994533', 'Chef comptable', 6, 'y'),
('MARTIN', 'CLAUDE', 'claude@bnp.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0611223344', 'chef de projet', 6, 'y'),
('KHAUV', 'Thierry', 'thierry@tidda.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0621728179', 'CEO', 3, 'y'),
('HUNAULT', 'Alexandre', 'alexandre@tidda.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0634928734', 'CEO', 3, 'y'),
('KAYAL', 'Dayvid', 'dayvid@tidda.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0694827456', 'CEO', 3, 'y');
('NI', 'Nicolas', 'nicolas@airfrance.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0799833462', 'Developpeur PHP', 1, 'y'),
('RO', 'Romain', 'romain@monnaiedeparis.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0645928923', 'ingénieur études', 2, 'y'),
('LA', 'Laurent', 'laurent@renault.fr', '00d70c561892a94980befd12a400e26aeb4b8599', '0723119977', 'consultant interne', 7, 'y');

INSERT INTO ALUMNI.EXPERIENCE (IDENTREPRISE, IDETUDIANT, TYPECONTRAT, DEBUT, FIN, INTITULEPOSTE) VALUES 
(1, 1, 'cdi', '2009-03-12', '2013-03-24', 'chef de projet junior'),
(2, 1, 'cdd', '2008-04-21', '2009-01-30', 'ingénieur études'),
(3, 1, 'cdi', '2010-01-20', '2013-03-31', 'consultant technico-commercial'),
(3, 2, 'cdi', '2012-10-17', '2013-12-15', 'developpeur PHP'),
(6, 3, 'cdd', '2010-11-15', '2013-11-03', 'developpeur JAVA'),
(6, 4, 'cdd', '2005-12-04', '2006-10-30', 'chargé référencement'),
(4, 5, 'cdi', '2007-08-13', '2009-02-09', 'consultant ERP'),
(5, 5, 'cdi', '2000-02-23', '2010-01-12', 'developpeur C++'),
(1, 10, 'stage', '2010-04-01', '2010-07-31', 'stagiaire développeur PHP'),
(2, 13, 'stage', '2009-01-02', '2009-06-30', 'stagiaire assistant chef de projet'),
(2, 14, 'stage', '2011-06-01', '2011-09-30', 'stagiaire architecte'),
(5, 15, 'stage', '2013-04-01', '2013-09-01', 'stagiaire business intelligence');

INSERT INTO alumni.competence (idExperience, libelle) VALUES
(3, 'PHP'),
(3, 'C++'),
(3, 'C#'),
(3, 'HTML'),
(3, 'CSS'),
(3, 'Javascript'),
(3, 'J2EE'),
(4, 'HTML'),
(4, 'PHP'),
(4, 'SAP'),
(4, 'BO'),
(4, 'SQL'),
(2, 'PHP'),
(2, 'SCRUM'),
(2, 'HTML'),
(6, 'PHP'),
(6, 'WORDPRESS'),
(6, 'HTML'),
(1, 'PHP'),
(1, '.NET'),
(1, 'HTML'),
(5, 'HTML'),
(5, '.NET'),
(5, 'PHP');

INSERT INTO alumni.salaire (idExperience, valeur, annee) VALUES
(1, 37000, 2010),
(1, 38000, 2012),
(2, 40000, 2008),
(2, 45000, 2009),
(4, 33000, 2011),
(4, 34000, 2012),
(5, 41000, 2012),
(5, 42000, 2013),
(6, 30000, 2010),
(6, 32000, 2013);


INSERT INTO alumni.anneedeformation(anneeUniversitaireDebut, anneeUniversitaireFin, ecole, libelle) VALUES
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Classique'),
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'L3 MIAGE Sorbonne Apprentissage'),
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Classique'),
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'M1 MIAGE Sorbonne Apprentissage'),
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne Classique'),
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne SIC Apprentissage'),
(2005, 2006, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2006, 2007, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2007, 2008, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2008, 2009, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2009, 2010, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2010, 2011, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2011, 2012, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage'),
(2012, 2013, 'Université Paris 1 Panthéon-Sorbonne', 'M2 MIAGE Sorbonne IKSEM Apprentissage');


INSERT INTO alumni.etudiantannee VALUES
(7,1),
(15,2),
(7,3),
(7,4),
(24,1),
(24,2),
(24,3),
(24,4);