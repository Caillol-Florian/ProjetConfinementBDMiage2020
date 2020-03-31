import java.sql.Timestamp;
import java.util.List;

public class Client extends Personne {
    public int idPersonne;
    public String numPasseport;
    public float cumulHeureVol;
    private List<Reduction> reducs;
    public static DAOHelper<Client> clientDAOHelper = new DAOHelper<>(Client.class);


    public Client() {
        super();
    }

    public int getIdPersonne(){
        return idPersonne;
    }
    public void setIdPersonne(int idPersonne){
       this.idPersonne=idPersonne;

    }
    public String getNumPasseport() {
        return numPasseport;
    }

    public void setNumPasseport(String numPasseport) {
        this.numPasseport = numPasseport;
    }

    public float getCumulHeureVol() {
        return cumulHeureVol;
    }

    public void setCumulHeureVol(float cumulHeureVol) {
        this.cumulHeureVol = cumulHeureVol;
    }

    public List<Reduction> getReducs() {
        return reducs;
    }

    public void setReducs(List<Reduction> reducs) {
        this.reducs = reducs;
    }


    public void reserver(){
      Reservation r = new Reservation();
      System.out.println("Voici la liste des vols disponibles : ");
      System.out.println(getsVols());
      int numVol = LectureClavier.lireEntier("\n Veuillez choisir un vol en tapant son numéro (numVol) : ");
      System.out.println("Voici la liste des places disponibles : ");
      System.out.println(getsPlaces(numVol));
      System.out.println("\n Veuillez choisir votre place :");
      int numPlace = LectureClavier.lireEntier("\n Veuillez choisir une place en tapant son numéro idPlace : ");

    }

    private static ArrayList<Vol> getVols(){
        ArrayList<Vol> vols = Vol.volDAOHelper.findAll();
        return vols;
    }

    private static ArrayList<Place> getPlaces(int numVol){
        ArrayList<Place> places = Place.placeDAOHelper.findAll("numVol",""+numVol);
        return places;
    }

    public static Place choisirPlace(int numAvion) {
      Place p = new Place();

    }

}
