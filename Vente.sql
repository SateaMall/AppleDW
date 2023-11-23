CREATE TABLE Employe (
    idEmploye NUMBER(10) PRIMARY KEY, 
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    role VARCHAR2(50) CHECK (role IN ('CHEF', 'MANAGER', 'POLYVALENT')),
    dateEmbauche DATE,
    salaire NUMBER(10, 2),
    formation NUMBER(2),
    heureContrat NUMBER(2),
    email VARCHAR2(100),
    dateNaissance DATE
);


CREATE TABLE Magasin (
    siret NUMBER(10) PRIMARY KEY,
    ville VARCHAR2(50),
    codePostal VARCHAR2(10),
    pays VARCHAR2(50),
    nbEmployes NUMBER(10),
    superficie NUMBER(12,1),
    heureOuverture NUMBER(2),  
    heureFermeture NUMBER(2),
    dateOuverture DATE
);


CREATE TABLE Produit (
    idProduit VARCHAR2(20) PRIMARY KEY,
    nom VARCHAR2(50),
    couleur VARCHAR2(20),
    generation VARCHAR2(20),
    type VARCHAR2(50) CHECK (type IN ('smartphone', 'ordinateur', 'ecouteurs', 'tablette')),
    modele VARCHAR2(50),
    capaciteStockage NUMBER(10),
    dateSortie DATE,
    prixInitial NUMBER(10),
    garantie NUMBER(2),
    version VARCHAR2(50)
);


CREATE TABLE Dates (
    idDate NUMBER(8) PRIMARY KEY,
    dates DATE UNIQUE,
    jourSemaine NUMBER(1),
    semaine NUMBER(2),
    mois NUMBER(2),
    trimestre NUMBER(1),
    annee NUMBER(4),
    jourFerie CHAR(1) CHECK (jourFerie IN ('Y', 'N')),
    periodePromotion CHAR(1) CHECK (periodePromotion IN ('Y', 'N')),
    saison VARCHAR2(20)
);

CREATE TABLE Client (
    idClient NUMBER(10) PRIMARY KEY,
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    dateNaissance DATE,
    sexe CHAR(1) CHECK (sexe IN ('H', 'F', 'N')), 
    categorieProfessionnelle VARCHAR2(50),
    revenuAnnuel NUMBER(15, 0),
    email VARCHAR2(100),
    villeResidence VARCHAR2(50),
    pays VARCHAR2(50),
    departement VARCHAR2(50),
    estEmploye CHAR(1) CHECK (estEmploye IN ('Y', 'N'))
);

CREATE TABLE Vente (
    idVente NUMVER(10), 
    idProduit VARCHAR2(20),
    siret NUMBER(10),
    idEmploye NUMBER(10),
    idClient NUMBER(10),
    idDate NUMBER(8),
    prixTTC NUMBER(10, 2),
    prixHT NUMBER(10, 2),
    note NUMBER(1, 0) CHECK (note BETWEEN 0 AND 5 OR note IS NULL),
    PRIMARY KEY (idProduit, siret, idEmploye, idClient, IdDate),
    FOREIGN KEY (idProduit) REFERENCES Produit(idProduit),
    FOREIGN KEY (siret) REFERENCES Magasin(siret),
    FOREIGN KEY (idEmploye) REFERENCES Employe(idEmploye),
    FOREIGN KEY (idClient) REFERENCES Client(idClient),
    FOREIGN KEY (idDate) REFERENCES Dates(idDate)
);
                        /**** Test Valeurs Ventes ****/
INSERT INTO Employe (idEmploye, nom, prenom, role, dateEmbauche, salaire, formation, heureContrat, email, dateNaissance) 
VALUES (123, 'Dupont', 'Jean', 'CHEF', TO_DATE('01-06-2015', 'DD-MM-YYYY'), 3500.00, 5, 35, 'jean.dupont@entreprise.com', TO_DATE('15-08-1980', 'DD-MM-YYYY'));

INSERT INTO Magasin (siret, ville, codePostal, pays, nbEmployes, superficie, heureOuverture, heureFermeture, dateOuverture) 
VALUES (123456789, 'Paris', '75000', 'France', 25, 500.0, 9, 18, TO_DATE('01-01-2010', 'DD-MM-YYYY'));

INSERT INTO Produit (idProduit, nom, couleur, generation, type, modele, capaciteStockage, dateSortie, prixInitial, garantie, version) 
VALUES ('PRD123', 'iPhone 13', 'Noir', '13', 'Smartphone', 'Pro', 128, TO_DATE('20-09-2021', 'DD-MM-YYYY'), 999, 2, 'iOS 15');

INSERT INTO Dates (idDate,dates, jourSemaine, semaine, mois, trimestre, annee, jourFerie, periodePromotion, saison) 
VALUES (18012022, TO_DATE('01-01-2023', 'DD-MM-YYYY'), 7, 1, 1, 1, 2023, 'N', 'N', 'Hiver');

INSERT INTO Client (idClient, nom, prenom, dateNaissance, sexe, categorieProfessionnelle, revenuAnnuel, email, villeResidence, pays, departement, estEmploye) 
VALUES (1001, 'Martin', 'Lucie', TO_DATE('15-03-1985', 'DD-MM-YYYY'), 'F', 'Ingenieur', 60000, 'lucie.martin@email.com', 'Lyon', 'France', '69', 'N');

INSERT INTO Vente (idVente, idProduit, siret, idEmploye, idClient, idDate, prixTTC, prixHT, note) 
VALUES ('10255525', 'PRD123', 123456789, 123, 1001, 18012022, 1099.99, 916.66, 5);
