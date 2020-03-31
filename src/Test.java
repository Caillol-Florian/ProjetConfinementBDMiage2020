import java.sql.*;
import java.util.List;


public class Test{
    public static Connection conn=null;
    public static void main(String[] args){
        String url = "jdbc:postgresql:projetBD";
        String username = "postgres";
        String pass = "teo";
        try{
            Class.forName("org.postgresql.Driver");
        }catch (java.lang.ClassNotFoundException e) {
            System.out.println("Pas de driver postgres trouvé");
        }
        try  {
            conn = DriverManager.getConnection(url,username,pass);
            System.out.println("Connecté");
        }catch (SQLException e){
            throw new Error("Problem",e);
        }
        try{
            while(true){
                System.out.println("=== BIENVENUE DANS L'INTERFACE DE CONFINEMENT AIRLINES ===\n");
                System.out.println("> FONCTIONS DISPONIBLES : \n");
                System.out.println(">> [Gestion Planification des Vols]");
                System.out.println("1. Planifier un nouveau vol");
                System.out.println("2. Supprimer un vol");
                System.out.println("3. Modifier la planification d'un vol existant");
                System.out.println("4. Confirmer qu'un vol est bien arrivÃ© Ã  destination");
                System.out.println("5. Ajouter un personnel Ã  l'avion");
                System.out.println("6. Supprimer un personnel Ã  l'avion\n");
                System.out.println(">> [Gestion des RÃ©servations]");
                System.out.println("7. Consulter les commandes d'un client");
                System.out.println("8. Supprimer la rÃ©servation d'un client\n");
                System.out.println(">> [Partie Cliente]");
                System.out.println("9. Reserver un vol\n");
                System.out.println(">> [Autre]");
                System.out.println("10. Quitter l'application\n");

                int numFonc = LectureClavier.lireEntier("Veuillez rentrer le numero correspondant a  la fonctionnalite choisie :");
                while(numFonc < 1 || numFonc > 10){
                    System.out.println("Numero invalide !");
                    numFonc = LectureClavier.lireEntier("Veuillez rentrer a nouveau le numero correspondant a la fonctionnalite choisie :");
                }
                switch(numFonc) {
                    case 1:
                        // code block
                        Vol v = Vol.createVol();
                        v.firstDbInsert();
                        break;
                    case 2:
                        // code block
                        break;
                    case 3:
                        // code block
                        break;
                    case 4:
                        // code block
                        break;
                    case 5:
                        // code block
                        break;
                    case 6:
                        // code block
                        break;
                    case 7:
                        // code block
                        break;
                    case 8:
                        // code block
                        break;
                    case 9:
                        System.out.println("Voici la liste des vols disponibles : ");

                        break;
                    case 10:
                        System.exit(0);
                        break;
                    default:
                        break;
                }
            }


        }catch (Exception e){
            throw new Error("Problem",e);
        }
    }
}