import java.util.Date;

public class Reservation {
    private Vol Vol;
    private Place place;
    private Client iencli;
    private Date dateReserv;
    private int numReserv;

    public Vol getVol() {
        return Vol;
    }

    public void setVol(Vol vol) {
        Vol = vol;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public Client getIencli() {
        return iencli;
    }

    public void setIencli(Client iencli) {
        this.iencli = iencli;
    }

    public Date getDateReserv() {
        return dateReserv;
    }

    public void setDateReserv(Date dateReserv) {
        this.dateReserv = dateReserv;
    }

    public int getNumReserv() {
        return numReserv;
    }

    public void setNumReserv(int numReserv) {
        this.numReserv = numReserv;
    }
}
