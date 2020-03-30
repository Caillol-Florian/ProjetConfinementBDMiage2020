public class Modele {
    public String refModele;
    public int nbPilotes;
    public int distMax;
    public static DAOHelper<Modele> modeleDAOHelper = new DAOHelper<>(Modele.class);

    public String getRefModele() {
        return refModele;
    }

    public void setRefModele(String refModele) {
        this.refModele = refModele;
    }

    public int getNbPilotes() {
        return nbPilotes;
    }

    public void setNbPilotes(int nbPilotes) {
        this.nbPilotes = nbPilotes;
    }

    public int getDistMax() {
        return distMax;
    }

    public void setDistMax(int distMax) {
        this.distMax = distMax;
    }

    public Modele(String refModele, int nbPilotes, int distMax) {
        this.refModele = refModele;
        this.nbPilotes = nbPilotes;
        this.distMax = distMax;
    }

}
