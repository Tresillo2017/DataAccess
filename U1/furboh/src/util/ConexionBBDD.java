package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBBDD {

	// Proporcionar los parámetros para conectarnos a la BBDD
	private static final String URL = "jdbc:mysql://localhost:3306/furboh?useSSL=false";
	private static final String USUARIO = "root";
	private static final String PASS = "root";
	
	// Crear nuestra variable de conexión que nos permita verificar si la consexión no está activa
	private static Connection conexion = null;
	
	// Conectarnos a la BBDD
	public static Connection conectar() {
		if(conexion == null) {
			// Recogemos la conexón
			try {
				conexion = DriverManager.getConnection(URL, USUARIO, PASS);
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
				conexion.close(); // close() cierra el canal de comunicación ntre la BBDD y el cliente JAVA
				System.out.println("Conexión cerrada correctamente.");
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conexion = null; // Finally fuerza la ejecución de las instrucciones descritar en su interior
									// Forzamos el cierre de la conexión poniéndola a null
			}
			
		}
	}
}
