public enum Sexe {
    HOMME("H"),
    FEMME("F");

    private String s;

    Sexe(String s) {
        this.s = s;
    }

    public String getS() {
        return s;
    }

    public void setS(String s) {
        this.s = s;
    }
}
