import java.util.List;

public class Hotesse extends Personnel{
    public List<Langue> langues;

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

}
