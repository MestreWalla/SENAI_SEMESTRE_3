package webapp.contatojdbc.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
    private static final String url = "jdbc:postgresql://localhost:5432/maycon";
    private static final String user = "postgres";
    private static final String password = "<postgres>";

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            throw new RuntimeException("Erro ao obter conecção com o banco de dados: " + e.getMessage());
        }
    }
    public static void closeConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            } 
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
