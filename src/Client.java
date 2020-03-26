import java.sql.Timestamp;
import java.util.List;

public class Client extends Personne {
    public int idPersonne;
    public String numPasseport;
    public float cumulHeureVol;
    private List<Reduction> reducs;
    public static DAOHelper<Client> clientDAOHelper = new DAOHelper<>(Client.class);


    public Client() {
        super();
    }

    public int getIdPersonne(){
        return idPersonne;
    }
    public void setIdPersonne(int idPersonne){
       this.idPersonne=idPersonne;

    }
    public String getNumPasseport() {
        return numPasseport;
    }

    public void setNumPasseport(String numPasseport) {
        this.numPasseport = numPasseport;
    }

    public float getCumulHeureVol() {
        return cumulHeureVol;
    }

    public void setCumulHeureVol(float cumulHeureVol) {
        this.cumulHeureVol = cumulHeureVol;
    }

    public List<Reduction> getReducs() {
        return reducs;
    }

    public void setReducs(List<Reduction> reducs) {
        this.reducs = reducs;
    }
}
