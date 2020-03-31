import java.sql.*;


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
            String select = "SELECT * FROM Personne";
            Statement stmt = conn.createStatement();
            ResultSet resultSet = stmt.executeQuery(select);
            ResultSetMetaData metaData = resultSet.getMetaData();
            int nbCol = metaData.getColumnCount();
            if(nbCol==8){
                System.out.println("BD non initialisé");
            }
            Client client = Client.clientDAOHelper.findOne(1);
            System.out.println(client.nom);
        }catch (SQLException e){
            throw new Error("Problem",e);
        }
    }
}