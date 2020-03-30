import java.util.List;

public class Pilote extends Personnel{
    public float nbHeureVol;
    public List<PiloteModele> modelesPilotables;

    public Pilote(float nbHeureVol, List<PiloteModele> modeles) {
        super();
        this.nbHeureVol = nbHeureVol;
        this.modelesPilotables = modeles;
    }

    public float getNbHeureVol() {
        return nbHeureVol;
    }

    public void setNbHeureVol(float nbHeureVol) {
        this.nbHeureVol = nbHeureVol;
    }

    public List<PiloteModele> getModeles() {
        return modelesPilotables;
    }

}
