package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

	// Parametros para conectarnos a la BBDD
	private static final String URL = "jdbc:mysql://localhost:3306/juegos_olimpicos?useSSL=false";
	private static final String USUARIO = "root";
	private static final String PASS = "mysql";

	private static Connection conexion = null;

	// Conectarnos a la BBDD
	public static Connection conectar() {
		if (conexion == null) {
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
		if (conexion != null) {
			try {
				conexion.close();
				System.out.println("Conexión cerrada correctamente.");
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conexion = null;
			}
		}
	}
}
