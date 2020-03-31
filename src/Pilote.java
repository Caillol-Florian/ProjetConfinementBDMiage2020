import java.util.List;

public class Pilote extends Personnel{
    public List<PiloteModele> modelesPilotables;

    public Pilote(List<PiloteModele> modeles) {
        super();
        this.modelesPilotables = modeles;
    }


    public List<PiloteModele> getModeles() {
        return modelesPilotables;
    }

    public String toString(){
        String s = "Id: " + this.idPersonne + ", " + this.nom + " " + this.prenom + ", modeles: ";
        for(PiloteModele p : modelesPilotables){
            s+= p.refModele + ",";
        }

        return s;
    }
}
