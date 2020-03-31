public class Avion {
    public int numAvion;
    public Modele refModele;
    public static DAOHelper<Avion> avionDAOHelper = new DAOHelper<>(Avion.class);

    public Avion(int numAvion, Modele modele) {
        this.numAvion = numAvion;
        this.refModele = modele;
    }

    public int getNumAvion() {
        return numAvion;
    }

    public void setNumAvion(int numAvion) {
        this.numAvion = numAvion;
    }

    public Modele getModele() {
        return refModele;
    }

    public void setModele(Modele modele) {
        this.refModele = modele;
    }

}
