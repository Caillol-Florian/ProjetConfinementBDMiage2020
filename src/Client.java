import java.sql.Timestamp;
import java.util.List;

public class Client extends Personne {
    private String numPasseport;
    private Timestamp cumulHeureVol;
    private List<Reduction> reducs;



    public Client() {
        super();
    }

    public String getNumPasseport() {
        return numPasseport;
    }

    public void setNumPasseport(String numPasseport) {
        this.numPasseport = numPasseport;
    }

    public Timestamp getCumulHeureVol() {
        return cumulHeureVol;
    }

    public void setCumulHeureVol(Timestamp cumulHeureVol) {
        this.cumulHeureVol = cumulHeureVol;
    }

    public List<Reduction> getReducs() {
        return reducs;
    }

    public void setReducs(List<Reduction> reducs) {
        this.reducs = reducs;
    }
}
