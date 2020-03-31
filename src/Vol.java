import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Vol {
    public int idVol;
    public int numVol;
    public String aeroportDepart;
    public String aeroportArrivee;
    public Date horaireDepart;
    public String duree;
    public int distance;
    public Avion numAvion;
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

    public Date getHoraireDepart() {
        return horaireDepart;
    }

    public void setHoraireDepart(Date horaireDepart) {
        this.horaireDepart = horaireDepart;
    }

    public String getDuree() {
        return duree;
    }

    public void setDuree(String duree) {
        this.duree = duree;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public Avion getAvion() {
        return numAvion;
    }

    public void setAvion(Avion avion) {
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
        v.duree = LectureClavier.lireEntier("Saisir le temps de vol en minute : ");




    }


    private static ArrayList<Integer> getNumeroVol()  {
        ArrayList<Integer> liste = new ArrayList<Integer>();
        liste.add(1);
        liste.add(2);
        return liste;
    }

    private static int setNumVol(){
        String s = "Choisissez le numéro de vol :\n ";
        ArrayList<Integer> listeVols = Vol.getNumeroVol();
        for(int i=0; i<getNumeroVol().size(); i++){
            s+=  i+1 + "- " + listeVols.get(i) + "\n";
        }
        return LectureClavier.lireEntier(s);
    }

    private static Date formatDate(String s) {
        String[] all = s.split(" ");
        String[] date = all[0].split("/", 10);
        String[] heure = all[1].split(":");

        Date d = new Date();
        d.setYear(Integer.parseInt(date[2]));
        d.setMonth(Integer.parseInt(date[1]));
        d.setDate(Integer.parseInt(date[0]));
        d.setHours(Integer.parseInt(heure[0]));
        d.setMinutes(Integer.parseInt(heure[1]));

        return d;
    }

}
