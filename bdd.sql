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
('PHUNG', 'Vincent', 'vincent@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 1', '0123456789', '1991-01-01', 'lien_photo', 'lien_cv','y','y'),
('TSIAOUSSIS', 'Dimitri', 'dimitri@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 2', '0132456789', '1992-02-11', 'lien_photo', 'lien_cv','y','y'),
('BIRAUD', 'Gregory', 'gregory@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 3', '0124356789', '1993-03-14', 'lien_photo', 'lien_cv','y','y'),
('CHAN', 'Christian', 'christian@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 4', '0123543789', '1994-04-24', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant1', 'durant@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 5', '0111111111', '1995-05-31', 'lien_photo', 'lien_cv','y','y'),
('Dupont2', 'Durant2', '123@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 5', '0122222222', '1995-05-31', 'lien_photo', 'lien_cv','y','n'),
('Dupont3', 'Durant3', '456@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 5', '0133333333', '1995-05-31', 'lien_photo', 'lien_cv','y','n'),
('Dupont4', 'Durant4', '789@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 5', '0144444444', '1995-05-31', 'lien_photo', 'lien_cv','y','n'),
('Dupont1', 'Durant5', 'durant5@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 5', '0111111111', '1995-05-02', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant6', 'durant6@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 6', '0111111111', '1995-05-31', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant7', 'durant7@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 7', '0111111111', '1995-05-01', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant8', 'durant8@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 8', '0111111111', '1995-01-31', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant9', 'durant9@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 9', '0111111111', '1985-10-14', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant10', 'durant10@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 10', '0111111111', '1993-11-30', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant11', 'durant11@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 11', '0111111111', '1991-06-21', 'lien_photo', 'lien_cv','y','y'),
('Dupont1', 'Durant12', 'durant12@gmail.com','51abb9636078defbf888d8457a7c76f85c8f114c', 'Adresse 12', '0111111111', '1992-02-11', 'lien_photo', 'lien_cv','y','y');


insert into alumni.entreprise(nomEntreprise, adresse) values
('BNP Paribas' ,'Adresse BNP Paribas'),
('Orange' ,'91 rue de tolbiac 75013 Paris'),
('Technip' ,'89 avenue de la grande armée 75116'),
('Renault' ,'Adresse 4'),
('Accenture' ,'Rue de la mort');

insert into alumni.contact(nom, prenom, mail, mdp, telephone, poste, idEntreprise, validation)  values
('Nom_Paribas_1', 'Prenom_Paribas_1', 'bnp@paribas.fr', '51abb9636078defbf888d8457a7c76f85c8f114c', '0123456789', 'CEO', 1, 'y'),
('Nom_Paribas_2', 'Prenom_Paribas_2', 'bnp2@paribas.fr', '51abb9636078defbf888d8457a7c76f85c8f114c', '0123456789', 'CTO', 1, 'y'),
('Nom_Paribas_3', 'Prenom_Paribas_3', 'bnp3@paribas.fr', '51abb9636078defbf888d8457a7c76f85c8f114c', '0123456789', 'Femme de menage', 1, 'n'),
('Nom_Technip_1', 'Prenom_Technip_1', 'technip1@technip.fr', '51abb9636078defbf888d8457a7c76f85c8f114c', '0123456789', 'DRH', 3, 'y'),
('Nom_Technip_2', 'Prenom_Technip_2', 'technip2@technip.fr', '51abb9636078defbf888d8457a7c76f85c8f114c', '0123456789', 'DRH', 3, 'y'),
('Nom_Technip_3', 'Prenom_Technip_3', 'technip3@technip.fr', '51abb9636078defbf888d8457a7c76f85c8f114c', '0123456789', 'DRH', 3, 'y');

INSERT INTO ALUMNI.EXPERIENCE (IDENTREPRISE, IDETUDIANT, TYPECONTRAT, DEBUT, FIN, INTITULEPOSTE) VALUES 
(1, 2, 'cdd', '2012-11-06', '2013-01-01', 'AMOA'),
(2, 2, 'cdi', '2013-01-02', '2013-04-08', 'Developpeur PHP'),
(3, 1, 'cdd', '2008-01-01', '2010-12-31', 'Informaticien'),
(3, 1, 'cdi', '2011-01-01', '2011-12-31', 'Developpeur JEE'),
(3, 1, 'cdi', '2012-01-01', '2012-12-31', 'Chef de Projet'),
(3, 1, 'cdi', '2013-01-01', '2013-04-10', 'CTO'),
(3, 3, 'cdi', '2013-01-01', '2013-04-10', 'PMO'),
(3, 4, 'cdi', '2013-01-01', '2013-04-10', 'Consultant SAP');

INSERT INTO alumni.competence (idExperience, libelle) VALUES
(3, 'HTML'),
(3, 'CSS'),
(3, 'PHP'),
(3, 'JavaScript'),
(3, 'jQuery'),
(3, 'Symfony2.0'),
(3, 'JUnit'),
(4, 'EJB'),
(4, 'J2EE'),
(4, 'Struts'),
(4, 'Hibernate'),
(4, 'Client/Serveur'),
(4, 'JMS'),
(4, 'MDB'),
(4, 'HTML'),
(4, 'JSP'),
(4, 'CSS'),
(4, 'Agile'),
(4, 'JUnit'),
(5, 'HTML'),
(5, 'Management'),
(5, 'Architecture Client/Serveur'),
(5, 'Agile'),
(5, 'JUnit');

INSERT INTO alumni.salaire (idExperience, valeur, annee) VALUES
(1, 34000, 2012),
(2, 34000, 2013),
(3, 24000, 2008),
(3, 28000, 2009),
(3, 32000, 2010),
(4, 40000, 2011),
(5, 60000, 2012),
(6, 100000, 2013),
(7, 50000, 2013),
(8, 39999, 2013);


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