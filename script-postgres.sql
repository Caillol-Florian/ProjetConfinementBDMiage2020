drop table if exists Vol CASCADE;
drop table if exists NumeroVol CASCADE;
drop table if exists Avion CASCADE;
drop table if exists Place CASCADE;
drop table if exists Modele CASCADE;
drop table if exists PiloteModele CASCADE;
drop table if exists Personne CASCADE;
drop table if exists Reservation CASCADE;
drop table if exists Client CASCADE;
drop table if exists Personnel CASCADE;
drop table if exists Pilote CASCADE;
drop table if exists Hotesse CASCADE;
drop table if exists Langue CASCADE;
drop table if exists LangueHotesse CASCADE;
drop table if exists Reduction CASCADE;
drop table if exists VolPersonnel CASCADE;


-- CREATION DES TABLES ET PRIMARY KEY SIMPLES

create table Vol (
	idVol integer primary key,
	numVol varchar(15) not null,
	aeroportDepart varchar(30) not null,
	aeroportArrivee varchar(30) not null,
	horaireDepart date not null,
	duree varchar(10) not null,
	distance integer not null,
	numAvion integer,
	termine boolean
	);

create table NumeroVol (
	numVol varchar(15) primary key
	);

create table Avion (
	numAvion integer primary key,
	refModele varchar(20) not null
	); -- Pas besoin de stocker le nombre de place car on a une table qui le gère

create table Place (
	idPlace integer primary key,
	classe varchar(15) not null,
	position varchar(10) not null,
	prix float not null,
	dateChgtPrix date,
	numAvion integer not null
	);

create table Modele (
	refModele varchar(20) primary key,
	nbPilotes integer not null,
	distMax integer not null
	);

create table Personne (
	idPersonne integer primary key,
	sexe char(1) not null,
	nom varchar(30) not null,
	prenom varchar(30) not null,
	adresse varchar(100) not null,
	codePostal varchar(10) not null,
	ville varchar(40) not null,
	pays varchar(20) not null
	);

create table Client (
	idPersonne integer primary key,
	numPasseport varchar(20) not null,
	cumulHeureVol float not null
	);

create table Personnel (
	numPersonnel integer primary key
	);

create table Hotesse (
	numPersonnel integer primary key
	);

create table Pilote (
	numPersonnel integer primary key,
	nbHeureTotal timestamp not null
);

create table Langue (
	intituleLangue varchar(30) primary key
	);

create table PiloteModele (
	numPersonnel integer,
	refModele varchar(20),
	nbHeureVol timestamp not null
	);

create table LangueHotesse (
	numPersonnel integer,
	intituleLangue varchar(30)
	);

create table Reservation (
	idVol integer,
	idPersonne integer,
	idPlace integer,
	dateReserv date not null,
	numReserv integer not null
	);

create table Reduction (
	idReduc integer primary key,
	idPersonne integer not null,
	utilise boolean not null
	);

create table VolPersonnel (
    idVol integer,
    numPersonnel integer
);


-- CONTRAINTES PRIMARY KEY COMPOSEE
alter table PiloteModele
add constraint pk_pilotemodele primary key (numPersonnel, refModele);

alter table LangueHotesse
add constraint  pk_languehotesse primary key (numPersonnel, intituleLangue);

alter table Reservation
add constraint  pk_reservation primary key (idVol, idPersonne, idPlace);

alter table VolPersonnel
add constraint pk_volpersonnel primary key (idVol,numPersonnel);

-- CONTRAINTES FOREIGN KEY
alter table Vol
add constraint  fk_volavion foreign key (numAvion) references Avion(numAvion);

alter table Vol
add constraint  fk_volnumvol foreign key (numVol) references NumeroVol(numVol);

alter table Avion
add constraint fk_avionmodele foreign key(refModele) references Modele(refModele);

alter table Reservation
add constraint  fk_reservationvol foreign key (idVol) references Vol(idVol);

alter table Reservation
add constraint  fk_reservationclient foreign key (idPersonne) references Client(idPersonne);

alter table Reservation
add constraint fk_reservationplace foreign key (idPlace) references Place(idPlace);

alter table Client
add constraint  fk_clientpersonne foreign key (idPersonne) references Personne(idPersonne);

alter table Personnel
add constraint  fk_personnelpersonne foreign key (numPersonnel) references Personne(idPersonne);

alter table Hotesse
add constraint  fk_hotessepersonnel foreign key (numPersonnel) references Personnel(numPersonnel);

alter table Pilote
add constraint  fk_pilotepersonnel foreign key (numPersonnel) references Personnel(numPersonnel);

alter table PiloteModele
add constraint  fk_pilotemodelemod foreign key (refModele) references Modele(refModele);

alter table PiloteModele
add constraint  fk_pilotemodelepil foreign key (numPersonnel) references Pilote(numPersonnel);

alter table LangueHotesse
add constraint  fk_languehotesselang foreign key (intituleLangue) references Langue(intituleLangue);

alter table LangueHotesse
add constraint  fk_languehotessehote foreign key (numPersonnel) references Hotesse(numPersonnel);

alter table Place
add constraint  fk_placeavion foreign key (numAvion) references Avion(numAvion);

alter table Reduction
add constraint  fk_reductionclient foreign key(idPersonne) references Client(idPersonne);

alter table VolPersonnel
add constraint  fk_volpersonnelvol foreign key(idVol) references Vol(idVol);

alter table VolPersonnel
add constraint  fk_volpersonnelpers foreign key (numPersonnel) references Personnel(numPersonnel);


-- CONTRAINTES CHECK
alter table Personne
add constraint  ck_sexe check (sexe in('M','F'));

-- CONTRAINTES UNIQUE
alter table Reservation
add constraint uq_numreserv unique (numReserv);






