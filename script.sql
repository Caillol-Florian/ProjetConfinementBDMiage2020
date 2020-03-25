drop table Vol;
drop table NumeroVol;
drop table Avion;
drop table Place;
drop table Modele;
drop table PiloteModele;
drop table Personne;
drop table Reservation; 
drop table Client;
drop table Personnel;
drop table Pilote;
drop table Hotesse;
drop table Langue;
drop table LangueHotesse;
drop table Reduction;


-- CREATION DES TABLES ET PRIMARY KEY SIMPLES

create table Vol (
	idVol int primary key,
	numVol varchar2(15) not null,
	aeroportDepart varchar2(30) not null,
	aeroportArrivee varchar2(30) not null,
	horaireDepart date not null,
	duree varchar2(10) not null,
	distance int not null, 
	numAvion int,
	termine boolean
	);

create table NumeroVol (
	numVol varchar2(15) primary key
	);

create table Avion (
	numAvion int primary key,
	refModele varchar2(20) not null
	); -- Pas besoin de stocker le nombre de place car on a une table qui le gère

create table Place (
	idPlace int primary key,
	classe varchar2(15) not null,
	position varchar2(10) not null,
	prix number not null,
	dateChgtPrix date
	numAvion int not null
	);

create table Modele (
	refModele varchar2(20) primary key,
	nbPilotes int not null,
	distMax int not null
	);

create table Personne (
	idPersonne int primary key, 
	sexe char(1) not null,
	nom varchar(30) not null,
	prenom varchar2(30) not null,
	adresse varchar(100) not null,
	codePostal varchar2(10) not null, 
	ville varchar2(40) not null,
	pays varchar2(20) not null
	);

create table Client (
	idPersonne int primary key,
	numPasseport varchar2(20) not null,
	cumulHeureVol timestamp not null
	);

create table Personnel (
	numPersonnel int primary key,
	); 

create table Hotesse (
	numPersonnel int primary key
	);

create table Pilote (
	numPersonnel int primary key, 
	nbHeureTotal timestamp not null
);

create table Langue (
	intituleLangue varchar2(30) primary key
	);

create table PiloteModele (
	numPersonnel int,
	refModele varchar2(20),
	nbHeureVol timestamp not null
	);

create table LangueHotesse (
	numPersonnel int, 
	intituleLangue varchar2(30)
	);

create table Reservation (
	idVol int,
	idPersonne int, 
	idPlace int, 
	dateReserv date not null, 
	numReserv int not null
	);

create table Reduction (
	idReduc int primary key,
	idPersonne int not null,
	utilise boolean not null
	);

-- CONTRAINTES PRIMARY KEY COMPOSEE
add constraint primary key pk_pilotemodele PiloteModele(numPersonnel, refModele);
add constraint primary key pk_languehotesse LangueHotesse(numPersonnel, intituleLangue);
add constraint primary key pk_reservation Reservation(idVol, idPersonne, idPlace);

-- CONTRAINTES FOREIGN KEY
add constraint foreign key fk_volavion Vol(numAvion) references Avion(numAvion);
add constraint foreign key fk_volnumvol Vol(numVol) references NumeroVol(numVol);
add constraint foreign key fk_avionmodele Avion(refModele) references Modele(refModele);
add constraint foreign key fk_reservationvol Reservation(idVol) references Vol(idVol);
add constraint foreign key fk_reservationclient Reservation(idPersonne) references Client(idPersonne);
add constraint foreign key fk_reservationplace Reservation(idPlace) references Place(idPlace);
add constraint foreign key fk_clientpersonne Client(idPersonne) references Personne(idPersonne);
add constraint foreign key fk_personnelpersonne Personnel(numPersonnel) references Personne(idPersonne);
add constraint foreign key fk_hotessepersonnel Hotesse(numPersonnel) references Personnel(numPersonnel);
add constraint foreign key fk_pilotepersonnel Pilote(numPersonnel) references Personnel(numPersonnel);
add constraint foreign key fk_pilotemodelemod PiloteModele(refModele) references Modele(refModele);
add constraint foreign key fk_pilotemodelepil PiloteModele(numPersonnel) references Pilote(numPersonnel);
add constraint foreign key fk_languehotesselang LangueHotesse(intituleLangue) references Langue(intituleLangue);
add constraint foreign key fk_languehotessehote LangueHotesse(numPersonnel) references Hotesse(numPersonnel);
add constraint foreign key fk_placeavion Place(numAvion) references Avion(numAvion);
add constraint foreign key fk_reductionclient Reduction(idPersonne) references Client(idPersonne);


-- CONTRAINTES CHECK
add constraint check ck_sexe Personne(sexe in('M','F'));

-- CONTRAINTES UNIQUE
add constraint unique uq_numreserv Reservation(numReserv)






