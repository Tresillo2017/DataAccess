package acceso;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionDB {

    // Parametros para conectarnos a la BBDD
    private static final String URL = "jdbc:mysql://localhost:3306/plataforma_streaming?useSSL=false&characterEncoding=UTF-8";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "root";

    private static Connection conexion = null;

    public static Connection conectar() {
        if (conexion == null) {
            try {
                conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            } catch (SQLException e) {
                System.out.println("Error al conectar con la BBDD " + e.getMessage());
            }
        }
        return conexion;
    }

    public static void desconectar() {
        if (conexion != null) {
            try {
                conexion.close();
                System.out.println("Conexion cerrada correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                conexion = null;
            }
        }
    }
}
