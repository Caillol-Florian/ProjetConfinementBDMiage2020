public enum Classe {
    PREMIERE("première"),
    AFFAIRE("affaire"),
    ECONOMIQUE("economique");

    private String classe;

    Classe(String classe) {
        this.classe = classe;
    }

    public String getClasse() {
        return classe;
    }
}
