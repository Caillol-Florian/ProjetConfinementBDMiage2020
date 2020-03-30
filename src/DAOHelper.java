import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.List;

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
                        }else if(fields[i].getType()== Date.class){
                            fields[i].set(newInstance,resultSet.getDate(i+1));
                        }else if(fields[i].getType()==boolean.class){
                            fields[i].set(newInstance,resultSet.getBoolean(i+1));
                        }else if(fields[i].getType()==List.class){
                        }else if(fields[i].getType()==Modele.class){
                            fields[i].set(newInstance,Modele.modeleDAOHelper.findOne(resultSet.getInt(i+1)));
                        }else if(fields[i].getType()==Avion.class){
                            fields[i].set(newInstance,Avion.avionDAOHelper.findOne(resultSet.getInt(i+1)));
                        }else if(fields[i].getType()==Sexe.class){
                            fields[i].set(newInstance,Sexe.valueOf(resultSet.getString((i+1))));
                        }
                        else if(fields[i].getType()==Client.class){
                            fields[i].set(newInstance,Client.clientDAOHelper.findOne(resultSet.getInt(i+1)));
                        }else if(fields[i].getType()==Vol.class){
                            fields[i].set(newInstance,Vol.volDAOHelper.findOne(resultSet.getInt(i+1)));
                        }else if(fields[i].getType()==Place.class){
                            fields[i].set(newInstance,Place.placeDAOHelper.findOne(resultSet.getInt(i+1)));
                        }else{
                            throw new Error("Manque implémentation de : " + fields[i].getType().toString());
                        }
                    }
                    if(type==Client.class) {
                        Field[] fieldsS = type.getSuperclass().getDeclaredFields();
                        String queryS = "SELECT * FROM PERSONNE WHERE idPersonne = " + fields[0].getInt(newInstance);
                        Statement smtmS = Test.conn.createStatement();
                        ResultSet resultSetS = smtmS.executeQuery(queryS);
                        ResultSetMetaData resultSetMetaData1 = resultSetS.getMetaData();
                        int nbColS = resultSetMetaData1.getColumnCount();
                        if (resultSetS.next()) {
                            for (int i = 0; i < nbColS; i++) {
                                if (fieldsS[i].getType() == int.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getInt(i + 1));
                                } else if (fieldsS[i].getType() == float.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getFloat(i + 1));
                                } else if (fieldsS[i].getType() == String.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getString(i + 1));
                                } else if (fieldsS[i].getType() == Date.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getDate(i + 1));
                                } else if (fieldsS[i].getType() == boolean.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getBoolean(i + 1));
                                }
                            }
                        }
                    }
                    if(type==Pilote.class || type==Hotesse.class){
                        Field[] fieldsS = type.getSuperclass().getSuperclass().getDeclaredFields();
                        String queryS = "SELECT * FROM PERSONNE WHERE idPersonne = " + fields[0].getInt(newInstance);
                        Statement smtmS = Test.conn.createStatement();
                        ResultSet resultSetS = stmt.executeQuery(queryS);
                        ResultSetMetaData resultSetMetaData1 = resultSetS.getMetaData();
                        int nbColS  =  resultSetMetaData1.getColumnCount();
                        if (resultSetS.next()) {
                            for (int i = 0; i < nbColS; i++) {
                                if (fieldsS[i].getType() == int.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getInt(i + 1));
                                } else if (fieldsS[i].getType() == float.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getFloat(i + 1));
                                } else if (fieldsS[i].getType() == String.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getString(i + 1));
                                } else if (fieldsS[i].getType() == Date.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getDate(i + 1));
                                } else if (fieldsS[i].getType() == boolean.class) {
                                    fieldsS[i].set(newInstance, resultSetS.getBoolean(i + 1));
                                }
                            }
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
