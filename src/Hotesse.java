import java.util.List;

public class Hotesse extends Personnel{
    public List<Langue> langues;
    public static DAOHelper<Hotesse> hotesseDAOHelper = new DAOHelper<>(Hotesse.class);

    public Hotesse(List<Langue> langues) {
        super();
        this.langues = langues;
    }

    public List<Langue> getLangues() {
        return langues;
    }

    public void setLangues(List<Langue> langues) {
        this.langues = langues;
    }

    public String toString(){
        String s = "Id: " + this.idPersonne + ", " + this.nom + " " + this.prenom + ", langues: ";
        for(Langue l : langues){
            s+= l.intitule+",";
        }

        return s;

    }
}
