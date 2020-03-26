public class Avion {
    private int numAvion;
    private Modele modele;

    public Avion(int numAvion, Modele modele) {
        this.numAvion = numAvion;
        this.modele = modele;
    }

    public int getNumAvion() {
        return numAvion;
    }

    public void setNumAvion(int numAvion) {
        this.numAvion = numAvion;
    }

    public Modele getModele() {
        return modele;
    }

    public void setModele(Modele modele) {
        this.modele = modele;
    }
}
