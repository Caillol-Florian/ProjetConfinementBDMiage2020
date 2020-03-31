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
          Vol v = Vol.createVol();
          v.firstDbInsert();
          System.out.println("Réussi");

        }catch (Exception e){
            throw new Error("Problem",e);
        }
    }
}