import java.sql.Timestamp;

public class PiloteModele {
    private int numPilote;
    private String refModele;
    private Timestamp nbHeureTotal;

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

    public Timestamp getNbHeureTotal() {
        return nbHeureTotal;
    }

    public void setNbHeureTotal(Timestamp nbHeureTotal) {
        this.nbHeureTotal = nbHeureTotal;
    }

    public PiloteModele(int numPilote, String refModele, Timestamp nbHeureTotal) {
        this.numPilote = numPilote;
        this.refModele = refModele;
        this.nbHeureTotal = nbHeureTotal;
    }


}
