import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Vol {
    public int idVol;
    public int numVol;
    public String aeroportDepart;
    public String aeroportArrivee;
    public LocalDateTime horaireDepart;
    public int duree;
    public int distance;
    public int numAvion;
    public boolean termine;
    public List<Personnel> personnel;
    public static DAOHelper<Vol> volDAOHelper = new DAOHelper<>(Vol.class);

    public int getIdVol() {
        return idVol;
    }

    public void setIdVol(int idVol) {
        this.idVol = idVol;
    }

    public int getNumVol() {
        return numVol;
    }

    public void setNumVol(int numVol) {
        this.numVol = numVol;
    }

    public String getAeroportDepart() {
        return aeroportDepart;
    }

    public void setAeroportDepart(String aeroportDepart) {
        this.aeroportDepart = aeroportDepart;
    }

    public String getAeroportArrivee() {
        return aeroportArrivee;
    }

    public void setAeroportArrivee(String aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee;
    }

    public LocalDateTime getHoraireDepart() {
        return horaireDepart;
    }

    public void setHoraireDepart(LocalDateTime horaireDepart) {
        this.horaireDepart = horaireDepart;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public int getAvion() {
        return numAvion;
    }

    public void setAvion(int avion) {
        this.numAvion = avion;
    }

    public boolean isTermine() {
        return termine;
    }

    public void setTermine(boolean termine) {
        this.termine = termine;
    }

    public List<Personnel> getPersonnel() {
        return personnel;
    }

    public void setPersonnel(List<Personnel> personnel) {
        this.personnel = personnel;
    }

    public static Vol createVol() {
        Vol v = new Vol();
        v.numVol = setNumVol();
        System.out.println("\n Saisissez la ville de départ : ");
        v.aeroportDepart = LectureClavier.lireChaine();
        System.out.println("\n Saissisez la ville d'arrivée : ");
        v.aeroportArrivee = LectureClavier.lireChaine();
        System.out.println("\n Renseignez le jour et l'heure de départ (DD/MM/YYYY HH:MM)");
        v.horaireDepart = Vol.formatDate(LectureClavier.lireChaine());
        v.duree = LectureClavier.lireEntier("\n Saisir le temps de vol en minute : ");
        v.distance = LectureClavier.lireEntier("\n Saisir la distance de vol en kilomètres (arrondi a l'unité)");
        v.numAvion = setNumAvion();
        v.termine = false;
        v.personnel = setPersonnel();



        return v;
    }

    private static List<Personnel> setPersonnel(){
        ArrayList<Personnel> psl = getAllPersonnel();
        ArrayList<Personnel> retenus = new ArrayList<Personnel>();
        System.out.println("\n Saisissez les numéros des hotesses souhaitées : (0 pour passer a la suite) : ");
        for(Personnel p : psl){
            if(p.getClass() != Hotesse.class)
                continue;
            System.out.println(p);
        }

        boolean over = false;
        while(!over){
            int i = LectureClavier.lireEntier("");
            if(i == 0){
                over = true;
                continue;
            }
            for(Personnel p : psl){
                if(i == p.idPersonne)
                    retenus.add(p);
            }
        }

        System.out.println("Saisissez les numéros des pilotes souhaités : (0 pour passer a la suite) : ");
        for(Personnel p : psl){
            if(p.getClass() != Pilote.class)
                continue;
            System.out.println(p);
        }

        over = false;
        while(!over){
            int i = LectureClavier.lireEntier("");
            if(i == 0){
                over = true;
                continue;
            }
            for(Personnel p : psl){
                if(i == p.idPersonne)
                    retenus.add(p);
            }
        }

        return retenus;


    }

    private static ArrayList<Personnel> getAllPersonnel(){
        ArrayList<Personnel> liste = new ArrayList<Personnel>();
        try{
            String query = "Select numpersonnel, nom, prenom from hotesse h join personne pe on h.numpersonnel = pe.idpersonne";
            Statement stmt = Test.conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                Hotesse h = new Hotesse(new ArrayList<Langue>());
                h.idPersonne = rs.getInt(1);
                h.nom = rs.getString(2);
                h.prenom = rs.getString(3);
                Statement stmt2 = Test.conn.createStatement();
                ResultSet rs2 = stmt2.executeQuery("Select intituleLangue from languehotesse where numpersonnel=" + h.idPersonne + ";");
                while(rs2.next()){
                    h.langues.add(new Langue(rs2.getString(1)));
                }
                liste.add(h);
             }

             query = "Select numpersonnel, pe.nom, pe.prenom from pilote p join personne pe on p.numPersonnel = pe.idpersonne";
            Statement stmt3 = Test.conn.createStatement();
            ResultSet rs3 = stmt3.executeQuery(query);
            while(rs3.next()){
                Pilote p = new Pilote(new ArrayList<PiloteModele>());
                p.idPersonne = rs3.getInt(1);
                p.nom = rs3.getString(2);
                p.prenom = rs3.getString(3);
                Statement stmt4 = Test.conn.createStatement();
                ResultSet rs4 = stmt4.executeQuery("select refmodele, nbHeureVol from pilotemodele p  where numpersonnel=" + p.idPersonne + ";");
                while (rs4.next()) {
                    p.modelesPilotables.add(new PiloteModele(p.idPersonne, rs4.getString(1), rs4.getInt(2) ));
                }
                liste.add(p);
            }

        }catch(SQLException e){
                System.out.println("Problème lors de la récupération des membres de personnel");
        }

        return liste;
    }


    private static ArrayList<Integer> getNumerosVol()  {
        ArrayList<Integer> liste = new ArrayList<Integer>();
        try {
            Statement stmt = Test.conn.createStatement();
            ResultSet rs = stmt.executeQuery("select numvol from numerovol");
            while(rs.next()){
                liste.add(rs.getInt(1));
            }
        }catch(Exception e){ e.getMessage(); }
        return liste;
    }

    private static int setNumVol(){
        String s = "Choisissez le numéro de vol :\n ";
        ArrayList<Integer> listeVols = Vol.getNumerosVol();
        for(int i=0; i<getNumerosVol().size(); i++){
            s+= listeVols.get(i) + "\n";
        }

        return LectureClavier.lireEntier(s);
    }

    private static int setNumAvion() {
        String s = "\n Saisissez le numero de l'avion qui va effectuer ce vol : \n";
        ArrayList<Integer> listeAvions = Vol.getNumerosAvion();
        for(int i=0; i<getNumerosAvion().size(); i++){
            s+=  listeAvions.get(i) + "\n";
        }
        return LectureClavier.lireEntier(s);

    }

    private static ArrayList<Integer> getNumerosAvion(){
        ArrayList<Integer> liste = new ArrayList<Integer>();
        try{
            Statement stmt = Test.conn.createStatement();
            ResultSet rs = stmt.executeQuery("select numavion from avion");
            while(rs.next()){
                liste.add(rs.getInt(1));
            }
        }catch(SQLException e) { e.getMessage(); }

        return liste;
    }

    private static LocalDateTime formatDate(String s) {
        String[] all = s.split(" ");
        String[] date = all[0].split("/", 10);
        String[] heure = all[1].split(":");

        LocalDateTime d = LocalDateTime.of(Integer.parseInt(date[2]), Integer.parseInt(date[1]), Integer.parseInt(date[0]), Integer.parseInt(heure[0]), Integer.parseInt(date[1]));


        return d;
    }

    public boolean firstDbInsert() {

        boolean ret = false;
        int id = -1;
        Timestamp t = Timestamp.valueOf(this.horaireDepart);
        String query = "select ajoutVol(CAST(" + this.numVol + " as varchar), CAST('" + this.aeroportDepart +
                "' as varchar), CAST( '" + this.aeroportArrivee + "' as varchar), CAST( '" + t + "' as Timestamp), " + this.distance + ", " + this.numAvion + ", " + this.duree + ");";
        try{
            Statement stmt = Test.conn.createStatement();

           stmt.executeQuery(query);
            ret = true;
            }catch(SQLException e) {
                System.out.println("Fail ajout : " + e.getMessage());
            }


        return ret;

    }



}
