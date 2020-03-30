import java.util.Date;

public class Place {

    public int idPlace;
    public Classe classe;
    public String position;
    public float prix;
    public Date dateChgtPrix;
    public Avion numAvion;
    public static DAOHelper <Place> placeDAOHelper = new DAOHelper<>(Place.class);

}
