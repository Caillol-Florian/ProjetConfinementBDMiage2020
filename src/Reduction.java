public class Reduction {
    private int idReduc;
    private Client client;
    private boolean utilise;

    public Reduction(int idReduc, Client client, boolean utilise) {
        this.idReduc = idReduc;
        this.client = client;
        this.utilise = utilise;
    }

    public int getIdReduc() {
        return idReduc;
    }

    public void setIdReduc(int idReduc) {
        this.idReduc = idReduc;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public boolean isUtilise() {
        return utilise;
    }

    public void setUtilise(boolean utilise) {
        this.utilise = utilise;
    }

}
