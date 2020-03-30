
public class PiloteModele {
    public int numPilote;
    public String refModele;
    public float nbHeureTotal;

    public int getNumPilote() {
        return numPilote;
    }

    public void setNumPilote(int numPilote) {
        this.numPilote = numPilote;
    }

    public String getRefModele() {
        return refModele;
    }

    public void setRefModele(String refModele) {
        this.refModele = refModele;
    }

    public float getNbHeureTotal() {
        return nbHeureTotal;
    }

    public void setNbHeureTotal(float nbHeureTotal) {
        this.nbHeureTotal = nbHeureTotal;
    }

    public PiloteModele(int numPilote, String refModele, float nbHeureTotal) {
        this.numPilote = numPilote;
        this.refModele = refModele;
        this.nbHeureTotal = nbHeureTotal;
    }


}
