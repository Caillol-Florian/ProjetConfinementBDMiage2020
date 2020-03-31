public class Interface {
    public static void main(String[] args) {
        int numFonc = 0;
        while (numFonc != 10){
          System.out.println("=== BIENVENUE DANS L'INTERFACE DE CONFINEMENT AIRLINES ===\n");
          System.out.println("> FONCTIONS DISPONIBLES : \n");
          System.out.println(">> [Gestion Planification des Vols]");
          System.out.println("1. Planifier un nouveau vol");
          System.out.println("2. Supprimer un vol");
          System.out.println("3. Modifier la planification d'un vol existant");
          System.out.println("4. Confirmer qu'un vol est bien arrivé à destination");
          System.out.println("5. Ajouter un personnel à l'avion");
          System.out.println("6. Supprimer un personnel à l'avion\n");
          System.out.println(">> [Gestion des Réservations]");
          System.out.println("7. Consulter les commandes d'un client");
          System.out.println("8. Supprimer la réservation d'un client\n");
          System.out.println(">> [Partie Cliente]");
          System.out.println("9. Réserver un vol\n");
          System.out.println(">> [Autre]");
          System.out.println("10. Quitter l'application\n");

          int numFonc = LectureClavier.lireEntier("Veuillez rentrer le numéro correspondant à la fonctionnalité choisie :");
          while(numFonc < 1 || numFonc > 10){
              System.out.println("Numéro invalide !");
              numFonc = LectureClavier.lireEntier("Veuillez rentrer à nouveau le numéro correspondant à la fonctionnalité choisie :");
          }
          switch(numFonc) {
              case 1:
                  // code block
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
                  // code block
                  break;
              case 10:
                  // code block
                  break;
              default:
                  break;
          }
        }
    }
}
