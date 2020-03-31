public class Avion {
    public int numAvion;
    public String refModele;
    public static DAOHelper<Avion> avionDAOHelper = new DAOHelper<>(Avion.class);

    public Avion(int numAvion, String modele) {
        this.numAvion = numAvion;
        this.refModele = modele;
    }

    public int getNumAvion() {
        return numAvion;
    }

    public void setNumAvion(int numAvion) {
        this.numAvion = numAvion;
    }

    public String getModele() {
        return refModele;
    }

    public void setModele(String modele) {
        this.refModele = modele;
    }

}
