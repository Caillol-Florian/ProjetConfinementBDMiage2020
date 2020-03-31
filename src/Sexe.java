public enum Sexe {
    HOMME("M"),
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
    public static Sexe fromString(String text) {
        for (Sexe b : Sexe.values()) {
            if (b.s.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }
    public static String EtoString(Sexe s){
        if(s == HOMME){
            return "M";
        }else{
            return "F";
        }
    }
}
