import java.sql.Timestamp;
import java.util.List;

public class Pilote extends Personnel{
    private Timestamp nbHeureVol;
    private List<PiloteModele> modelesPilotables;

    public Pilote(Timestamp nbHeureVol, List<PiloteModele> modeles) {
        super();
        this.nbHeureVol = nbHeureVol;
        this.modelesPilotables = modeles;
    }

    public Timestamp getNbHeureVol() {
        return nbHeureVol;
    }

    public void setNbHeureVol(Timestamp nbHeureVol) {
        this.nbHeureVol = nbHeureVol;
    }

    public List<PiloteModele> getModeles() {
        return modelesPilotables;
    }

}
