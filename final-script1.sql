--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

-- Started on 2020-03-31 23:32:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 217 (class 1255 OID 16572)
-- Name: actuheurepers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actuheurepers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	listePers record; 
BEGIN
	if old.termine=false and new.termine=true then
		for listePers in select * from VolPersonnel v where v.numvol = new.numvol LOOP
			update Personnel p
			set nbHeureCumul = nbHeureCumul + new.duree 
			where p.numPersonnel = ligne.numPersonnel;
		END LOOP;
	END IF;
	return new; 
END
$$;


ALTER FUNCTION public.actuheurepers() OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16788)
-- Name: actuvolclient(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actuvolclient() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    clients record;
begin
    if old.termine = false and new.termine = true then
        for clients in select idpersonne into clients from reservation r where r.idvol = new.idvol LOOP
            update client c
            set cumulheurevol = cumulheurevol + new.duree
            where c.idpersonne = iencli.idpersonne;
         end loop; 
    end if;
  end;
  $$;


ALTER FUNCTION public.actuvolclient() OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16575)
-- Name: actuvolmodele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actuvolmodele() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
	pilotes record;
	modele varchar;
begin
	if old.termine = false and new.termine = true then
		for pilotes in select * from volpersonnel v where v.numpersonnel in (SELECT numPersonnel from Pilote) and v.numVol = new.numVol LOOP
			select refmodele into modele from avion av where av.numAvion = new.numAvion;
			UPDATE pilotemodele p
			set nbHeurevol = nbHeureVol+new.duree 
			where p.numPersonnel = pilotes.numPersonnel and p.refmodele = modele;
		end loop;
	end if;
end;
$$;


ALTER FUNCTION public.actuvolmodele() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16598)
-- Name: ajoutvol(character varying, character varying, character varying, date, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajoutvol(numvol character varying, dep character varying, arr character varying, hdep date, distance integer, numavion integer, duree integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	idV integer;
	ret integer := 0;
BEGIN
	idV = CAST(CAST(numvol AS text)||CAST(nextval('seq_vol') AS text) AS integer);
	insert into Vol(idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree)
	values(idV, numvol, dep, arr, hdep, distance, numavion, false, duree);

	-- Test si fonctionne (affecte 1 a la valeur de retour si le nouvel id est bien dans la base
	select 1 into ret where idV in(select idvol from vol);

	return ret;
END;
$$;


ALTER FUNCTION public.ajoutvol(numvol character varying, dep character varying, arr character varying, hdep date, distance integer, numavion integer, duree integer) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16582)
-- Name: ajoutvol(character varying, character varying, character varying, date, integer, integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajoutvol(numvol character varying, dep character varying, arr character varying, hdep date, distance integer, numavion integer, duree numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	idV integer;
	ret integer := 0;
BEGIN
	idV = CAST(CAST(numvol AS text)||CAST(nextval('seq_vol') AS text) AS integer);
	insert into Vol(idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree)
	values(idV, numvol, dep, arr, hdep, distance, numavion, false, duree);

	-- Test si fonctionne (affecte 1 a la valeur de retour si le nouvel id est bien dans la base
	select 1 into ret where idV in(select idvol from vol);

	return ret;
END;
$$;


ALTER FUNCTION public.ajoutvol(numvol character varying, dep character varying, arr character varying, hdep date, distance integer, numavion integer, duree numeric) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 16804)
-- Name: ajoutvol(character varying, character varying, character varying, timestamp without time zone, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajoutvol(numvol character varying, dep character varying, arr character varying, hdep timestamp without time zone, distance integer, numavion integer, duree integer, OUT idv integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer := 0;
BEGIN
	idV = CAST(CAST(numvol AS text)||CAST(nextval('seq_vol') AS text) AS integer);
	insert into Vol(idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree)
	values(idV, numvol, dep, arr, hdep, distance, numavion, false, duree);

	-- Test si fonctionne (affecte 1 a la valeur de retour si le nouvel id est bien dans la base
	select 1 into ret where idV in(select idvol from vol);

	
END;
$$;


ALTER FUNCTION public.ajoutvol(numvol character varying, dep character varying, arr character varying, hdep timestamp without time zone, distance integer, numavion integer, duree integer, OUT idv integer) OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16790)
-- Name: seq_avion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_avion
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avion OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16404)
-- Name: avion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avion (
    numavion integer DEFAULT nextval('public.seq_avion'::regclass) NOT NULL,
    refmodele character varying(20) NOT NULL
);


ALTER TABLE public.avion OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16424)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    idpersonne integer NOT NULL,
    numpasseport character varying(20) NOT NULL,
    cumulheurevol double precision NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16434)
-- Name: hotesse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotesse (
    numpersonnel integer NOT NULL
);


ALTER TABLE public.hotesse OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16444)
-- Name: langue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.langue (
    intitulelangue character varying(30) NOT NULL
);


ALTER TABLE public.langue OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16452)
-- Name: languehotesse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.languehotesse (
    numpersonnel integer NOT NULL,
    intitulelangue character varying(30) NOT NULL
);


ALTER TABLE public.languehotesse OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16414)
-- Name: modele; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modele (
    refmodele character varying(20) NOT NULL,
    nbpilotes integer NOT NULL,
    distmax integer NOT NULL
);


ALTER TABLE public.modele OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16399)
-- Name: numerovol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.numerovol (
    numvol character varying(15) NOT NULL
);


ALTER TABLE public.numerovol OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16792)
-- Name: seq_personne; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_personne
    START WITH 31
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_personne OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16419)
-- Name: personne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personne (
    idpersonne integer DEFAULT nextval('public.seq_personne'::regclass) NOT NULL,
    sexe character(1) NOT NULL,
    nom character varying(30) NOT NULL,
    prenom character varying(30) NOT NULL,
    adresse character varying(100) NOT NULL,
    codepostal character varying(30) NOT NULL,
    ville character varying(40) NOT NULL,
    pays character varying(50) NOT NULL,
    CONSTRAINT ck_sexe CHECK ((sexe = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.personne OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16429)
-- Name: personnel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personnel (
    numpersonnel integer NOT NULL,
    "nbHeureCumul" double precision
);


ALTER TABLE public.personnel OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16439)
-- Name: pilote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pilote (
    numpersonnel integer NOT NULL
);


ALTER TABLE public.pilote OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16449)
-- Name: pilotemodele; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pilotemodele (
    numpersonnel integer NOT NULL,
    refmodele character varying(20) NOT NULL,
    nbheurevol double precision DEFAULT 0.0 NOT NULL
);


ALTER TABLE public.pilotemodele OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16409)
-- Name: place; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.place (
    idplace integer NOT NULL,
    classe character varying(15) NOT NULL,
    "position" character varying(10) NOT NULL,
    prix double precision NOT NULL,
    datechgtprix date DEFAULT now(),
    numavion integer NOT NULL
);


ALTER TABLE public.place OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16794)
-- Name: seq_reduction; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_reduction
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_reduction OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16458)
-- Name: reduction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reduction (
    idreduc integer DEFAULT nextval('public.seq_reduction'::regclass) NOT NULL,
    idpersonne integer NOT NULL,
    utilise boolean NOT NULL
);


ALTER TABLE public.reduction OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16455)
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    idvol integer NOT NULL,
    idpersonne integer NOT NULL,
    idplace integer NOT NULL,
    datereserv date NOT NULL,
    numreserv integer NOT NULL
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16592)
-- Name: seq_numreserv; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_numreserv
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_numreserv OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16577)
-- Name: seq_vol; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_vol
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vol OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16394)
-- Name: vol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vol (
    idvol integer NOT NULL,
    numvol character varying(15) NOT NULL,
    aeroportdepart character varying(30) NOT NULL,
    aeroportarrivee character varying(30) NOT NULL,
    horairedepart timestamp without time zone NOT NULL,
    distance integer NOT NULL,
    numavion integer,
    termine boolean,
    duree integer
);


ALTER TABLE public.vol OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16463)
-- Name: volpersonnel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volpersonnel (
    idvol integer NOT NULL,
    numpersonnel integer NOT NULL
);


ALTER TABLE public.volpersonnel OWNER TO postgres;

--
-- TOC entry 2944 (class 0 OID 16404)
-- Dependencies: 198
-- Data for Name: avion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.avion (numavion, refmodele) VALUES (1, 'AIRBUS A380');
INSERT INTO public.avion (numavion, refmodele) VALUES (2, 'AIRBUS A380');
INSERT INTO public.avion (numavion, refmodele) VALUES (3, 'BOEING 787');
INSERT INTO public.avion (numavion, refmodele) VALUES (4, 'BOEING 787');
INSERT INTO public.avion (numavion, refmodele) VALUES (5, 'AIRBUS A340');
INSERT INTO public.avion (numavion, refmodele) VALUES (6, 'AIRBUS A340');


--
-- TOC entry 2948 (class 0 OID 16424)
-- Dependencies: 202
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (1, '16050203', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (2, '63926351', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (3, '62534009', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (4, '25399561', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (5, '42301103', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (6, '53642432', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (7, '24192367', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (8, '19236781', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (9, '52619023', 0);
INSERT INTO public.client (idpersonne, numpasseport, cumulheurevol) VALUES (10, '62418261', 0);


--
-- TOC entry 2950 (class 0 OID 16434)
-- Dependencies: 204
-- Data for Name: hotesse; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hotesse (numpersonnel) VALUES (17);
INSERT INTO public.hotesse (numpersonnel) VALUES (18);
INSERT INTO public.hotesse (numpersonnel) VALUES (19);
INSERT INTO public.hotesse (numpersonnel) VALUES (20);
INSERT INTO public.hotesse (numpersonnel) VALUES (21);
INSERT INTO public.hotesse (numpersonnel) VALUES (22);
INSERT INTO public.hotesse (numpersonnel) VALUES (23);
INSERT INTO public.hotesse (numpersonnel) VALUES (24);
INSERT INTO public.hotesse (numpersonnel) VALUES (25);
INSERT INTO public.hotesse (numpersonnel) VALUES (26);
INSERT INTO public.hotesse (numpersonnel) VALUES (27);
INSERT INTO public.hotesse (numpersonnel) VALUES (28);
INSERT INTO public.hotesse (numpersonnel) VALUES (29);
INSERT INTO public.hotesse (numpersonnel) VALUES (30);


--
-- TOC entry 2952 (class 0 OID 16444)
-- Dependencies: 206
-- Data for Name: langue; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.langue (intitulelangue) VALUES ('Français');
INSERT INTO public.langue (intitulelangue) VALUES ('Anglais');
INSERT INTO public.langue (intitulelangue) VALUES ('Espagnol');
INSERT INTO public.langue (intitulelangue) VALUES ('Allemand');
INSERT INTO public.langue (intitulelangue) VALUES ('Portugais');
INSERT INTO public.langue (intitulelangue) VALUES ('Russe');
INSERT INTO public.langue (intitulelangue) VALUES ('Japonais');
INSERT INTO public.langue (intitulelangue) VALUES ('Chinois');


--
-- TOC entry 2954 (class 0 OID 16452)
-- Dependencies: 208
-- Data for Name: languehotesse; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (17, 'Français');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (17, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (18, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (18, 'Chinois');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (19, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (19, 'Allemand');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (20, 'Chinois');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (20, 'Japonais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (21, 'Espagnol');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (21, 'Portugais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (22, 'Russe');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (22, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (23, 'Russe');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (23, 'Chinois');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (24, 'Espagnol');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (24, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (25, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (25, 'Portugais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (26, 'Anglais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (26, 'Japonais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (27, 'Français');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (27, 'Japonais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (28, 'Chinois');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (28, 'Espagnol');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (29, 'Espagnol');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (29, 'Russe');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (30, 'Portugais');
INSERT INTO public.languehotesse (numpersonnel, intitulelangue) VALUES (30, 'Français');


--
-- TOC entry 2946 (class 0 OID 16414)
-- Dependencies: 200
-- Data for Name: modele; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.modele (refmodele, nbpilotes, distmax) VALUES ('BOEING 787', 2, 10000);
INSERT INTO public.modele (refmodele, nbpilotes, distmax) VALUES ('AIRBUS A380', 2, 12000);
INSERT INTO public.modele (refmodele, nbpilotes, distmax) VALUES ('AIRBUS A340', 2, 7000);


--
-- TOC entry 2943 (class 0 OID 16399)
-- Dependencies: 197
-- Data for Name: numerovol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.numerovol (numvol) VALUES ('5768');
INSERT INTO public.numerovol (numvol) VALUES ('7115');
INSERT INTO public.numerovol (numvol) VALUES ('7543');
INSERT INTO public.numerovol (numvol) VALUES ('9361');
INSERT INTO public.numerovol (numvol) VALUES ('8800');
INSERT INTO public.numerovol (numvol) VALUES ('6010');
INSERT INTO public.numerovol (numvol) VALUES ('7064');
INSERT INTO public.numerovol (numvol) VALUES ('3139');
INSERT INTO public.numerovol (numvol) VALUES ('6455');
INSERT INTO public.numerovol (numvol) VALUES ('7843');
INSERT INTO public.numerovol (numvol) VALUES ('4896');
INSERT INTO public.numerovol (numvol) VALUES ('6989');
INSERT INTO public.numerovol (numvol) VALUES ('7683');
INSERT INTO public.numerovol (numvol) VALUES ('4593');
INSERT INTO public.numerovol (numvol) VALUES ('4234');
INSERT INTO public.numerovol (numvol) VALUES ('4941');
INSERT INTO public.numerovol (numvol) VALUES ('7514');
INSERT INTO public.numerovol (numvol) VALUES ('8308');
INSERT INTO public.numerovol (numvol) VALUES ('7916');
INSERT INTO public.numerovol (numvol) VALUES ('8128');


--
-- TOC entry 2947 (class 0 OID 16419)
-- Dependencies: 201
-- Data for Name: personne; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (1, 'F', 'Lindsey', 'Joan', '329-5331 Ut, Rd.', '60506', 'Heppenheim', 'Serbia');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (2, 'M', 'Sandoval', 'Alvin', '522-5485 Pellentesque Av.', '51677', 'Eschwege', 'Netherlands');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (3, 'M', 'Bolton', 'Lucas', 'Appartement 856-4790 Sed Rue', '45594', 'Cache Creek', 'Falkland Islands');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (4, 'F', 'Velazquez', 'Mallory', '9431 In Impasse', '5669 JL', 'Sutton', 'Micronesia');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (5, 'M', 'Sears', 'Henry', 'Appartement 291-2012 Ligula Rd.', '22180', 'San Miguel', 'Côte D''Ivoire (Ivory Coast)');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (6, 'F', 'Houston', 'Jorden', 'CP 212, 1300 Sapien. Rd.', '6488', 'Carlisle', 'Lithuania');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (7, 'F', 'Carrillo', 'Maxine', '369-4583 Elementum, Route', 'W80 6NF', 'Mitú', 'Belarus');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (8, 'M', 'Schwartz', 'Ian', '310-4048 Nibh Route', '5376', 'Saarlouis', 'Barbados');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (9, 'F', 'Strong', 'Jaime', '293-3152 Nam Rd.', '44035', 'San Ignacio', 'Libya');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (10, 'M', 'Gonzalez', 'Marshall', 'CP 305, 6459 Velit Avenue', '43671', 'San Rafael', 'Chile');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (11, 'F', 'Potts', 'Belle', '1320 Hymenaeos. Avenue', '23240', 'Nedlands', 'Switzerland');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (12, 'F', 'Mckee', 'Lila', '4748 Mi. Avenue', '434854', 'Sarreguemines', 'French Southern Territories');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (13, 'F', 'Albert', 'Hollee', 'Appartement 208-8343 Aliquam Impasse', 'IN80 3PU', 'Orange', 'Zimbabwe');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (14, 'F', 'Waller', 'Gary', 'Appartement 360-4862 Lorem, Avenue', '802537', 'Dijon', 'Burkina Faso');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (15, 'M', 'Sherman', 'Brooke', '2776 A Ave', '440132', 'Nossegem', 'United Arab Emirates');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (16, 'M', 'Jordan', 'Kane', 'CP 831, 3897 Est Rd.', '30544', 'Saskatoon', 'Canada');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (17, 'M', 'Tillman', 'Wade', 'CP 349, 4321 Lectus Av.', '792243', 'Ghanche', 'United Arab Emirates');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (18, 'F', 'Sheppard', 'Asher', 'Appartement 802-769 Mattis. Impasse', '64195', 'Estevan', 'Kenya');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (19, 'M', 'Hopkins', 'Ryder', '9090 Gravida Av.', '63167', 'Braunschweig', 'Honduras');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (20, 'M', 'Boone', 'Ferris', 'Appartement 999-8725 Ultricies Rd.', '222608', 'Grayvoron', 'Mexico');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (21, 'M', 'Fitzpatrick', 'Irene', '355-7552 In Rd.', '709025', 'Tourcoing', 'Laos');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (22, 'F', 'Frazier', 'Hedley', '6268 Congue Avenue', '245700', 'Blehen', 'Saint Barthélemy');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (23, 'F', 'Townsend', 'Tallulah', '759-4517 Sed Ave', '77389', 'Sars-la-Buissire', 'United Kingdom (Great Britain)');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (24, 'M', 'Booker', 'Veronica', 'Appartement 255-1063 Pharetra. Impasse', 'T6T 4K3', 'Stene', 'Serbia');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (25, 'M', 'Gaines', 'Maxwell', 'CP 416, 6657 Amet, Av.', 'XR5 9AX', 'Fleurus', 'Zimbabwe');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (26, 'M', 'Chambers', 'Deanna', 'CP 169, 716 Malesuada Rd.', '4391', 'Turbo', 'Namibia');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (27, 'M', 'Velasquez', 'Megan', '938-1227 Phasellus Chemin', '66780', 'Verona', 'Bahrain');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (28, 'F', 'Bruce', 'Sarah', '424-6519 Euismod Chemin', '71017', 'Teralfene', 'Mozambique');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (29, 'M', 'Valencia', 'Tarik', 'Appartement 475-4464 Eu Ave', 'SL0 6GO', 'Hollange', 'El Salvador');
INSERT INTO public.personne (idpersonne, sexe, nom, prenom, adresse, codepostal, ville, pays) VALUES (30, 'F', 'Bender', 'Dora', '1723 Vivamus Av.', '47065-50123', 'Margate', 'Jordan');


--
-- TOC entry 2949 (class 0 OID 16429)
-- Dependencies: 203
-- Data for Name: personnel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (17, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (18, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (19, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (20, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (21, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (22, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (23, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (24, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (25, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (26, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (27, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (28, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (29, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (30, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (12, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (13, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (14, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (15, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (16, 0);
INSERT INTO public.personnel (numpersonnel, "nbHeureCumul") VALUES (11, 0);


--
-- TOC entry 2951 (class 0 OID 16439)
-- Dependencies: 205
-- Data for Name: pilote; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pilote (numpersonnel) VALUES (11);
INSERT INTO public.pilote (numpersonnel) VALUES (12);
INSERT INTO public.pilote (numpersonnel) VALUES (13);
INSERT INTO public.pilote (numpersonnel) VALUES (14);
INSERT INTO public.pilote (numpersonnel) VALUES (15);
INSERT INTO public.pilote (numpersonnel) VALUES (16);


--
-- TOC entry 2953 (class 0 OID 16449)
-- Dependencies: 207
-- Data for Name: pilotemodele; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (11, 'AIRBUS A380', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (12, 'AIRBUS A380', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (13, 'AIRBUS A340', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (14, 'AIRBUS A340', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (15, 'BOEING 787', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (16, 'BOEING 787', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (15, 'AIRBUS A380', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (16, 'AIRBUS A380', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (11, 'AIRBUS A340', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (12, 'AIRBUS A340', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (13, 'BOEING 787', 0);
INSERT INTO public.pilotemodele (numpersonnel, refmodele, nbheurevol) VALUES (14, 'BOEING 787', 0);


--
-- TOC entry 2945 (class 0 OID 16409)
-- Dependencies: 199
-- Data for Name: place; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (1, 'Première', '1A', 140.990000000000009, '2020-03-31', 1);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (2, 'Première', '1B', 140.990000000000009, '2020-03-31', 1);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (3, 'Affaire', '2A', 119.989999999999995, '2020-03-31', 1);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (4, 'Affaire', '2B', 119.989999999999995, '2020-03-31', 1);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (5, 'Economique', '3A', 89.9899999999999949, '2020-03-31', 1);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (6, 'Economique', '3B', 89.9899999999999949, '2020-03-31', 1);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (7, 'Première', '1A', 140.990000000000009, '2020-03-31', 2);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (8, 'Première', '1B', 140.990000000000009, '2020-03-31', 2);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (9, 'Affaire', '2A', 119.989999999999995, '2020-03-31', 2);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (10, 'Affaire', '2B', 119.989999999999995, '2020-03-31', 2);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (11, 'Economique', '3A', 89.9899999999999949, '2020-03-31', 2);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (12, 'Economique', '3B', 89.9899999999999949, '2020-03-31', 2);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (13, 'Première', '1A', 140.990000000000009, '2020-03-31', 3);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (14, 'Première', '1B', 140.990000000000009, '2020-03-31', 3);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (15, 'Affaire', '2A', 119.989999999999995, '2020-03-31', 3);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (16, 'Affaire', '2B', 119.989999999999995, '2020-03-31', 3);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (17, 'Economique', '3A', 89.9899999999999949, '2020-03-31', 3);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (18, 'Economique', '3B', 89.9899999999999949, '2020-03-31', 3);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (19, 'Première', '1A', 140.990000000000009, '2020-03-31', 4);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (20, 'Première', '1B', 140.990000000000009, '2020-03-31', 4);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (21, 'Affaire', '2A', 119.989999999999995, '2020-03-31', 4);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (22, 'Affaire', '2B', 119.989999999999995, '2020-03-31', 4);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (23, 'Economique', '3A', 89.9899999999999949, '2020-03-31', 4);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (24, 'Economique', '3B', 89.9899999999999949, '2020-03-31', 4);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (25, 'Première', '1A', 140.990000000000009, '2020-03-31', 5);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (26, 'Première', '1B', 140.990000000000009, '2020-03-31', 5);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (27, 'Affaire', '2A', 119.989999999999995, '2020-03-31', 5);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (28, 'Affaire', '2B', 119.989999999999995, '2020-03-31', 5);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (29, 'Economique', '3A', 89.9899999999999949, '2020-03-31', 5);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (30, 'Economique', '3B', 89.9899999999999949, '2020-03-31', 5);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (31, 'Première', '1A', 140.990000000000009, '2020-03-31', 6);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (32, 'Première', '1B', 140.990000000000009, '2020-03-31', 6);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (33, 'Affaire', '2A', 119.989999999999995, '2020-03-31', 6);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (34, 'Affaire', '2B', 119.989999999999995, '2020-03-31', 6);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (35, 'Economique', '3A', 89.9899999999999949, '2020-03-31', 6);
INSERT INTO public.place (idplace, classe, "position", prix, datechgtprix, numavion) VALUES (36, 'Economique', '3B', 89.9899999999999949, '2020-03-31', 6);


--
-- TOC entry 2956 (class 0 OID 16458)
-- Dependencies: 210
-- Data for Name: reduction; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2955 (class 0 OID 16455)
-- Dependencies: 209
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservation (idvol, idpersonne, idplace, datereserv, numreserv) VALUES (57681003, 2, 1, '2020-03-31', 1);
INSERT INTO public.reservation (idvol, idpersonne, idplace, datereserv, numreserv) VALUES (71151004, 4, 5, '2020-03-31', 2);


--
-- TOC entry 2942 (class 0 OID 16394)
-- Dependencies: 196
-- Data for Name: vol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (57681003, '5768', 'Paris', 'Moscou', '2020-03-31 00:00:00', 4000, 1, false, 300);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (71151004, '7115', 'Moscou', 'Tokyo', '2020-03-31 00:00:00', 7449, 3, false, 540);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (81281005, '8128', 'Tokyo', 'Paris', '2020-04-15 15:04:00', 8272, 2, false, 234);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (81281006, '8128', 'Bali', 'Cancun', '2020-07-16 15:07:00', 2435, 2, false, 352);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (45931007, '4593', 'Mexico', 'Los Angeles', '2020-12-21 08:12:00', 9231, 2, false, 532);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (31391008, '3139', 'Paris', 'Cancun', '2020-08-23 11:08:00', 232, 4, false, 432);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (42341009, '4234', 'Paris', 'Lyon', '2020-09-12 10:09:00', 243, 6, false, 45);
INSERT INTO public.vol (idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree) VALUES (49411010, '4941', 'Annecy', 'Lyon', '2020-04-15 13:04:00', 120, 5, false, 21);


--
-- TOC entry 2957 (class 0 OID 16463)
-- Dependencies: 211
-- Data for Name: volpersonnel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 11);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 12);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 17);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 18);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 19);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 20);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 21);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (57681003, 22);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 23);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 24);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 25);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 26);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 27);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 28);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 29);
INSERT INTO public.volpersonnel (idvol, numpersonnel) VALUES (71151004, 30);


--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 214
-- Name: seq_avion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_avion', 7, false);


--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 213
-- Name: seq_numreserv; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_numreserv', 2, true);


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_personne; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_personne', 31, false);


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 216
-- Name: seq_reduction; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_reduction', 11, false);


--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 212
-- Name: seq_vol; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_vol', 1010, true);


--
-- TOC entry 2771 (class 2606 OID 16408)
-- Name: avion avion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT avion_pkey PRIMARY KEY (numavion);


--
-- TOC entry 2779 (class 2606 OID 16428)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (idpersonne);


--
-- TOC entry 2783 (class 2606 OID 16438)
-- Name: hotesse hotesse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotesse
    ADD CONSTRAINT hotesse_pkey PRIMARY KEY (numpersonnel);


--
-- TOC entry 2787 (class 2606 OID 16448)
-- Name: langue langue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.langue
    ADD CONSTRAINT langue_pkey PRIMARY KEY (intitulelangue);


--
-- TOC entry 2775 (class 2606 OID 16418)
-- Name: modele modele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele
    ADD CONSTRAINT modele_pkey PRIMARY KEY (refmodele);


--
-- TOC entry 2769 (class 2606 OID 16403)
-- Name: numerovol numerovol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.numerovol
    ADD CONSTRAINT numerovol_pkey PRIMARY KEY (numvol);


--
-- TOC entry 2777 (class 2606 OID 16423)
-- Name: personne personne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pkey PRIMARY KEY (idpersonne);


--
-- TOC entry 2781 (class 2606 OID 16433)
-- Name: personnel personnel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnel
    ADD CONSTRAINT personnel_pkey PRIMARY KEY (numpersonnel);


--
-- TOC entry 2785 (class 2606 OID 16443)
-- Name: pilote pilote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilote
    ADD CONSTRAINT pilote_pkey PRIMARY KEY (numpersonnel);


--
-- TOC entry 2791 (class 2606 OID 16469)
-- Name: languehotesse pk_languehotesse; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languehotesse
    ADD CONSTRAINT pk_languehotesse PRIMARY KEY (numpersonnel, intitulelangue);


--
-- TOC entry 2789 (class 2606 OID 16467)
-- Name: pilotemodele pk_pilotemodele; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotemodele
    ADD CONSTRAINT pk_pilotemodele PRIMARY KEY (numpersonnel, refmodele);


--
-- TOC entry 2793 (class 2606 OID 16471)
-- Name: reservation pk_reservation; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT pk_reservation PRIMARY KEY (idvol, idpersonne, idplace);


--
-- TOC entry 2799 (class 2606 OID 16473)
-- Name: volpersonnel pk_volpersonnel; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volpersonnel
    ADD CONSTRAINT pk_volpersonnel PRIMARY KEY (idvol, numpersonnel);


--
-- TOC entry 2773 (class 2606 OID 16413)
-- Name: place place_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pkey PRIMARY KEY (idplace);


--
-- TOC entry 2797 (class 2606 OID 16462)
-- Name: reduction reduction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reduction
    ADD CONSTRAINT reduction_pkey PRIMARY KEY (idreduc);


--
-- TOC entry 2795 (class 2606 OID 16566)
-- Name: reservation uq_numreserv; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT uq_numreserv UNIQUE (numreserv);


--
-- TOC entry 2767 (class 2606 OID 16398)
-- Name: vol vol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vol
    ADD CONSTRAINT vol_pkey PRIMARY KEY (idvol);


--
-- TOC entry 2818 (class 2620 OID 16573)
-- Name: vol actuheurepers; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER actuheurepers AFTER UPDATE ON public.vol FOR EACH ROW EXECUTE PROCEDURE public.actuheurepers();


--
-- TOC entry 2820 (class 2620 OID 16789)
-- Name: vol actuvolclient; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER actuvolclient AFTER UPDATE ON public.vol FOR EACH ROW EXECUTE PROCEDURE public.actuvolclient();


--
-- TOC entry 2819 (class 2620 OID 16576)
-- Name: vol actuvolmodele; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER actuvolmodele AFTER UPDATE ON public.vol FOR EACH ROW EXECUTE PROCEDURE public.actuvolmodele();


--
-- TOC entry 2802 (class 2606 OID 16484)
-- Name: avion fk_avionmodele; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT fk_avionmodele FOREIGN KEY (refmodele) REFERENCES public.modele(refmodele);


--
-- TOC entry 2804 (class 2606 OID 16504)
-- Name: client fk_clientpersonne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_clientpersonne FOREIGN KEY (idpersonne) REFERENCES public.personne(idpersonne);


--
-- TOC entry 2806 (class 2606 OID 16514)
-- Name: hotesse fk_hotessepersonnel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotesse
    ADD CONSTRAINT fk_hotessepersonnel FOREIGN KEY (numpersonnel) REFERENCES public.personnel(numpersonnel);


--
-- TOC entry 2811 (class 2606 OID 16539)
-- Name: languehotesse fk_languehotessehote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languehotesse
    ADD CONSTRAINT fk_languehotessehote FOREIGN KEY (numpersonnel) REFERENCES public.hotesse(numpersonnel);


--
-- TOC entry 2810 (class 2606 OID 16534)
-- Name: languehotesse fk_languehotesselang; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languehotesse
    ADD CONSTRAINT fk_languehotesselang FOREIGN KEY (intitulelangue) REFERENCES public.langue(intitulelangue);


--
-- TOC entry 2805 (class 2606 OID 16509)
-- Name: personnel fk_personnelpersonne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnel
    ADD CONSTRAINT fk_personnelpersonne FOREIGN KEY (numpersonnel) REFERENCES public.personne(idpersonne);


--
-- TOC entry 2808 (class 2606 OID 16524)
-- Name: pilotemodele fk_pilotemodelemod; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotemodele
    ADD CONSTRAINT fk_pilotemodelemod FOREIGN KEY (refmodele) REFERENCES public.modele(refmodele);


--
-- TOC entry 2809 (class 2606 OID 16529)
-- Name: pilotemodele fk_pilotemodelepil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotemodele
    ADD CONSTRAINT fk_pilotemodelepil FOREIGN KEY (numpersonnel) REFERENCES public.pilote(numpersonnel);


--
-- TOC entry 2807 (class 2606 OID 16519)
-- Name: pilote fk_pilotepersonnel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilote
    ADD CONSTRAINT fk_pilotepersonnel FOREIGN KEY (numpersonnel) REFERENCES public.personnel(numpersonnel);


--
-- TOC entry 2803 (class 2606 OID 16544)
-- Name: place fk_placeavion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.place
    ADD CONSTRAINT fk_placeavion FOREIGN KEY (numavion) REFERENCES public.avion(numavion);


--
-- TOC entry 2815 (class 2606 OID 16549)
-- Name: reduction fk_reductionclient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reduction
    ADD CONSTRAINT fk_reductionclient FOREIGN KEY (idpersonne) REFERENCES public.client(idpersonne);


--
-- TOC entry 2813 (class 2606 OID 16494)
-- Name: reservation fk_reservationclient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservationclient FOREIGN KEY (idpersonne) REFERENCES public.client(idpersonne);


--
-- TOC entry 2814 (class 2606 OID 16499)
-- Name: reservation fk_reservationplace; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservationplace FOREIGN KEY (idplace) REFERENCES public.place(idplace);


--
-- TOC entry 2812 (class 2606 OID 16489)
-- Name: reservation fk_reservationvol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservationvol FOREIGN KEY (idvol) REFERENCES public.vol(idvol);


--
-- TOC entry 2800 (class 2606 OID 16474)
-- Name: vol fk_volavion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vol
    ADD CONSTRAINT fk_volavion FOREIGN KEY (numavion) REFERENCES public.avion(numavion);


--
-- TOC entry 2801 (class 2606 OID 16479)
-- Name: vol fk_volnumvol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vol
    ADD CONSTRAINT fk_volnumvol FOREIGN KEY (numvol) REFERENCES public.numerovol(numvol);


--
-- TOC entry 2817 (class 2606 OID 16559)
-- Name: volpersonnel fk_volpersonnelpers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volpersonnel
    ADD CONSTRAINT fk_volpersonnelpers FOREIGN KEY (numpersonnel) REFERENCES public.personnel(numpersonnel);


--
-- TOC entry 2816 (class 2606 OID 16554)
-- Name: volpersonnel fk_volpersonnelvol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volpersonnel
    ADD CONSTRAINT fk_volpersonnelvol FOREIGN KEY (idvol) REFERENCES public.vol(idvol);


-- Completed on 2020-03-31 23:32:57

--
-- PostgreSQL database dump complete
--

