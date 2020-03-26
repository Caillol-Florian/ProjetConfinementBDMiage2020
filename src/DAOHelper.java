import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class DAOHelper<T>  {
    private final Class<T> type;
    public DAOHelper(Class<T> type){
        this.type= type;
    }
    public T findOne(int id){
        try {
            T newInstance = type.newInstance();
            Field[] fields=type.getDeclaredFields();
            String query = "SELECT * FROM "+type.getName() + " WHERE " + fields[0].getName() + " = " + id;
            try {
                Statement stmt = Test.conn.createStatement();
                ResultSet resultSet = stmt.executeQuery(query);
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                int nbCol = resultSetMetaData.getColumnCount();
                if(resultSet.next()){
                    for(int i = 0;i<nbCol;i++){
                        if(fields[i].getType()==int.class){
                            fields[i].set(newInstance,resultSet.getInt(i+1));
                        }else if(fields[i].getType()==float.class){
                            fields[i].set(newInstance,resultSet.getFloat(i+1));
                        }else if(fields[i].getType()==String.class){
                           fields[i].set(newInstance,resultSet.getString(i+1));
                        }
                    }
                    return newInstance;
                }else{
                    return null;
                }
            }catch(SQLException e){
                throw new Error("Problem",e);
            }
        } catch (java.lang.Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
