package acceso;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionDB {

    // Proporcionar los parametros para conectarnos a la BBDD
    private static final String URL = "jdbc:mysql://localhost:3306/furboh";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "";

    // Crear nuestra variable de conexion que nos permita verificar si la conexion no esta activa
    private static Connection conexion = null;

    // Conectarnos a la BBDD
    public static Connection conectar() {
        if(conexion == null) {
            // Recogemos la conexion
            try {
                conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            } catch (SQLException e) {
                System.out.println("Error al conectar con la BBDD " + e.getMessage());
                e.printStackTrace();

            }
        }
        return conexion;
    }

    // Desconectarnos de la BBDD
    public static void desconectar() {
        if(conexion != null) {
            try {
                conexion.close(); // close cierra el canal de comunicacion entre la BBDD y el cliente JAVA
                System.out.println("Conexion cerrada correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                conexion = null; // Finally fuerza la ejecucion de las instrucciones descritas en su interior
                // Forzamos el cierre de la conexion poniendola a null
            }
        }

    }
}