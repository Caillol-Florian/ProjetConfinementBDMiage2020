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


}
