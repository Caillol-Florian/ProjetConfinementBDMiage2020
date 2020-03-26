public class Modele {
    private String refModele;
    private int nbPilotes;
    private int distMax;

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
