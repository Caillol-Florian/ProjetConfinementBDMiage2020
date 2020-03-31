-- AJOUT DE VOL

create sequence seq_vol start 1 increment by 1;

create function ajoutVol(numvol varchar, dep  varchar, arr varchar, hdep date, distance integer, numavion integer, duree numeric(2,2))
returns integer as $ret$
DECLARE
	idV integer;
	ret integer := 0;
BEGIN
	idV = CAST(CAST(numvol AS text)||CAST(nextval('seq_vol') AS text) AS integer);
	insert into Vol(idvol, numvol, aeroportdepart, aeroportarrivee, horairedepart, distance, numavion, termine, duree)
	values(idV, numvol, dep, arr, hdep, distance, numavion, duree);

	-- Test si fonctionne (affecte 1 a la valeur de retour si le nouvel id est bien dans la base
	select 1 into ret where idV in(select idvol from vol);

	return ret;
END;
$ret$ language plpgsql;



-- ACTUALISATION DES HEURES DE VOl DU PERSONNEL
create function actuHeurePers() returns trigger as $actuHeurePers$
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
$actuHeurePers$ LANGUAGE plpgsql;

create trigger actuHeurePers AFTER UPDATE on vol
	FOR EACH ROW EXECUTE PROCEDURE actuHeurePers();


-- MAJ HEURE PILOTE SUR LE MODELE

create function actuVolModele() returns trigger as $actuVolModele$
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
$actuVolModele$ LANGUAGE plpgsql;

create trigger actuVolModele AFTER UPDATE ON vol
for each row execute procedure actuVolModele();


create function actuVolClient() returns trigger as $actuVolClient$

begin
    if old.termine = false and new.termine = true then
        for iencli in  select idpersonne  from reservation r where r.idvol = new.idvol LOOP
            update client c
            set cumulheurevol = cumulheurevol + new.duree
            where c.idpersonne = iencli.idpersonne;
         end loop;
    end if;
  end;
  $actuVolClient$ language plpgsql;

  create trigger actuVolClient after update on vol
  for each row execute procedure actuVolClient();



