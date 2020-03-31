import java.lang.reflect.Field;
import java.nio.channels.ScatteringByteChannel;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAOHelper<T>  {
    private final Class<T> type;
    public DAOHelper(Class<T> type){
        this.type= type;
    }
    public T findOne(String id){
        try {
            T newInstance = type.newInstance();
            Field[] fields=type.getDeclaredFields();
            String query = "SELECT * FROM "+type.getName() + " WHERE " + fields[0].getName() + " = " +"'"+ id+"'";
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
                            fields[i].set(newInstance,Modele.modeleDAOHelper.findOne(Integer.toString(resultSet.getInt(i+1))));
                        }else if(fields[i].getType()==Avion.class){
                            fields[i].set(newInstance,Avion.avionDAOHelper.findOne(Integer.toString(resultSet.getInt(i+1))));
                        }else if(fields[i].getType()==Sexe.class){
                            fields[i].set(newInstance,Sexe.valueOf(resultSet.getString((i+1))));
                        }
                        else if(fields[i].getType()==Client.class){
                            fields[i].set(newInstance,Client.clientDAOHelper.findOne(Integer.toString(resultSet.getInt(i+1))));
                        }else if(fields[i].getType()==Vol.class){
                            fields[i].set(newInstance,Vol.volDAOHelper.findOne(Integer.toString(resultSet.getInt(i+1))));
                        }else if(fields[i].getType()==Place.class){
                            fields[i].set(newInstance,Place.placeDAOHelper.findOne(Integer.toString(resultSet.getInt(i+1))));
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
                                } else if(fieldsS[i].getType() == Sexe.class ){
                                    fieldsS[i].set(newInstance,Sexe.fromString(resultSetS.getString(i+1)));
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
                                } else if(fieldsS[i].getType() == Sexe.class ){
                                    fieldsS[i].set(newInstance,Sexe.fromString(resultSetS.getString(i+1)));
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

    public List<T> findAll(String key, String selection) {
        List<T> list = new ArrayList<>();
        try {

            String query = "SELECT * FROM " + type.getName() + " WHERE " + key + " = " + "'" + selection + "' ";
            Statement statement = Test.conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
            int nbCols = resultSetMetaData.getColumnCount();
            if (resultSet.next()) {
                try {
                    T newInstance = type.newInstance();
                    Field fields[] = type.getFields();
                    for (int i = 0; i < nbCols; i++) {
                        if (fields[i].getType() == int.class) {
                            fields[i].set(newInstance, resultSet.getInt(i + 1));
                        } else if (fields[i].getType() == float.class) {
                            fields[i].set(newInstance, resultSet.getFloat(i + 1));
                        } else if (fields[i].getType() == String.class) {
                            fields[i].set(newInstance, resultSet.getString(i + 1));
                        } else if (fields[i].getType() == Date.class) {
                            fields[i].set(newInstance, resultSet.getDate(i + 1));
                        } else if (fields[i].getType() == boolean.class) {
                            fields[i].set(newInstance, resultSet.getBoolean(i + 1));
                        } else if (fields[i].getType() == List.class) {
                        } else if (fields[i].getType() == Modele.class) {
                            fields[i].set(newInstance, Modele.modeleDAOHelper.findOne(Integer.toString(resultSet.getInt(i + 1))));
                        } else if (fields[i].getType() == Avion.class) {
                            fields[i].set(newInstance, Avion.avionDAOHelper.findOne(Integer.toString(resultSet.getInt(i + 1))));
                        } else if (fields[i].getType() == Sexe.class) {
                            fields[i].set(newInstance, Sexe.fromString(resultSet.getString((i + 1))));
                        } else if (fields[i].getType() == Client.class) {
                            fields[i].set(newInstance, Client.clientDAOHelper.findOne(Integer.toString(resultSet.getInt(i + 1))));
                        } else if (fields[i].getType() == Vol.class) {
                            fields[i].set(newInstance, Vol.volDAOHelper.findOne(Integer.toString(resultSet.getInt(i + 1))));
                        } else if (fields[i].getType() == Place.class) {
                            fields[i].set(newInstance, Place.placeDAOHelper.findOne(Integer.toString(resultSet.getInt(i + 1))));
                        } else {
                            throw new Error("Manque implémentation de : " + fields[i].getType().toString());
                        }
                    }
                    if (type == Client.class) {
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
                                }else if(fieldsS[i].getType() == Sexe.class ){
                                    fieldsS[i].set(newInstance,Sexe.fromString(resultSet.getString(i+1)));
                                }
                            }
                        }
                    }
                    if (type == Pilote.class || type == Hotesse.class) {
                        Field[] fieldsS = type.getSuperclass().getSuperclass().getDeclaredFields();
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
                                }else if(fieldsS[i].getType() == Sexe.class){
                                    fieldsS[i].set(newInstance,Sexe.fromString(resultSet.getString(i+1)));
                                }
                            }
                        }
                    }
                    list.add(newInstance);
                } catch (java.lang.Exception e) {
                    e.printStackTrace();
                }
            }

        } catch (SQLException e) {
            throw new Error("Problem", e);
        }
        return list;
    }

    public Boolean save(T saveThis) {
        if (type == Langue.class) {
            try {
                String query = new String("INSERT INTO LANGUE VALUES ( ") + ((Langue) saveThis).intitule + ")";
                Statement statement = Test.conn.createStatement();
                int nbCol = statement.executeUpdate(query);
                if (nbCol > 0) {
                    return true;
                } else {
                    return false;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if(type==Reservation.class){
            try{
                Reservation res = (Reservation)  saveThis;
                String query = new String("INSERT INTO RESERVATION VALUES (")+res.Vol.idVol+","+res.iencli.idPersonne+","+res.place.idPlace+","+res.dateReserv.toString()+","+")";
                Statement statement = Test.conn.createStatement();
                int nbCol = statement.executeUpdate(query);
            }catch (SQLException e){
                throw new Error(e);
            }
        } else {
            Field[] fields = type.getFields();
            try {
                if ((int) fields[0].get(saveThis) == 0) {
                    StringBuilder queryS = new StringBuilder("INSERT INTO " + type.getName() + " VALUES (,");
                    int nbFields = fields.length-1;
                    for (int i = 1; i < nbFields; i++) {
                        if (fields[i].getType() == int.class || fields[i].getType() == float.class || fields[i].getType() == String.class || fields[i].getType() == Date.class || fields[i].getType() == boolean.class) {
                            queryS.append(fields[i].get(saveThis)).append(",");
                        } else if (fields[i].getType() == Modele.class) {
                            Modele mod = (Modele) fields[i].get(saveThis);
                            queryS.append(mod.refModele).append(",");
                        } else if (fields[i].getType() == Avion.class) {
                            Avion avion = (Avion) fields[i].get(saveThis);
                            queryS.append(avion.numAvion).append(",");
                        } else if (fields[i].getType() == Sexe.class) {
                            Sexe sexe = (Sexe) fields[i].get(saveThis);
                            queryS.append(sexe.toString()).append(",");
                        } else if (fields[i].getType() == Client.class) {
                            Client client = (Client) fields[i].get(saveThis);
                            queryS.append(client.idPersonne).append(",");
                        } else if (fields[i].getType() == Vol.class) {
                            Vol vol = (Vol) fields[i].get(saveThis);
                            queryS.append(vol.idVol).append(",");
                        } else if (fields[i].getType() == Place.class) {
                            Place place = (Place) fields[i].get(saveThis);
                            queryS.append(place.idPlace).append(",");

                        } else if(fields[i].getType()==List.class){

                        }else if(fields[i].getType()==DAOHelper.class){

                        }
                        else {
                            throw new Error("Type pas implémenté");
                        }
                    }
                    queryS.append(")");
                    try {
                        Statement statement = Test.conn.createStatement();
                        int nb = statement.executeUpdate(queryS.toString());
                        if (nb > 0) {
                            return true;
                        } else {
                            return false;
                        }
                    } catch (SQLException e) {
                        throw new Error(e);
                    }
                } else {
                    StringBuilder queryS = new StringBuilder("update " + type.getName() + " set ");
                    int nbFields = type.getDeclaredFields().length-1;
                    for (int i = 1; i < nbFields; i++) {
                        try {
                            if (fields[i].getType() == int.class || fields[i].getType() == float.class || fields[i].getType() == String.class || fields[i].getType() == Date.class || fields[i].getType() == boolean.class) {
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(fields[i].get(saveThis)).append("'").append(",").append("\n");
                            } else if (fields[i].getType() == Modele.class) {
                                Modele mod = (Modele) fields[i].get(saveThis);
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(mod.refModele).append("'").append(",").append("\n");
                            } else if (fields[i].getType() == Avion.class) {
                                Avion avion = (Avion) fields[i].get(saveThis);
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(avion.numAvion).append("'").append(",").append("\n");
                            } else if (fields[i].getType() == Sexe.class) {
                                Sexe sexe = (Sexe) fields[i].get(saveThis);
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(sexe.toString()).append("'").append(",").append("\n");
                            } else if (fields[i].getType() == Client.class) {
                                Client client = (Client) fields[i].get(saveThis);
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(client.idPersonne).append("'").append(",").append("\n");
                            } else if (fields[i].getType() == Vol.class) {
                                Vol vol = (Vol) fields[i].get(saveThis);
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(vol.idVol).append("'").append(",").append("\n");
                            } else if (fields[i].getType() == Place.class) {
                                Place place = (Place) fields[i].get(saveThis);
                                queryS.append(fields[i].getName()).append(" = ").append("'").append(place.idPlace).append("'").append(",").append("\n");
                            } else if(fields[i].getType()==List.class){
                            }else if(fields[i].getType()==DAOHelper.class){

                            }else{
                                throw new Error("type pas implémenté");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    try {
                        queryS.deleteCharAt(queryS.length()-2);
                        queryS.append("WHERE " + fields[0].getName() + " = " + "'" + fields[0].get(saveThis) + "'");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    int nbS = 0;
                    if (type == Client.class || type == Hotesse.class || type == Pilote.class) {
                        if (type == Client.class) {
                            Field[] fieldsS = type.getSuperclass().getFields();
                        } else {
                            Field[] fieldsS = type.getSuperclass().getSuperclass().getFields();
                        }
                        StringBuilder querySS = new StringBuilder("update " + " personne " + "set ");
                        int nbFieldsS = type.getFields().length;
                        for (int i = nbFields+1; i < nbFieldsS; i++) {
                            try {
                                if(fields[i].getType()==Sexe.class){
                                    Sexe sexe = (Sexe) fields[i].get(saveThis);
                                    String sexeS = Sexe.EtoString(sexe);
                                    querySS.append(fields[i].getName()).append(" = ").append("'").append(sexeS).append("'").append(",").append("\n");
                                }else{
                                    querySS.append(fields[i].getName()).append(" = ").append("'").append(fields[i].get(saveThis)).append("'").append(",").append("\n");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        querySS.deleteCharAt(querySS.length()-2);
                        querySS.append("WHERE idPersonne = ").append("'").append(fields[nbFields].get(saveThis)).append("'");
                        try {
                            Statement statement = Test.conn.createStatement();
                            nbS = statement.executeUpdate(querySS.toString());
                        } catch (SQLException e) {
                            throw new Error("problem", e);
                        }
                    }
                    try {
                        Statement statement = Test.conn.createStatement();
                        int nb = statement.executeUpdate(queryS.toString());
                        if (type == Client.class || type == Hotesse.class || type == Pilote.class) {
                            if (nb > 0 && nbS > 0) {
                                return true;
                            } else {
                                return false;
                            }
                        } else {
                            if (nb > 0) {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    } catch (SQLException e) {
                        throw new Error("problem", e);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }


}
