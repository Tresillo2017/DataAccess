/*
 * Copyright (c) 2026.  Tomas Palma Sanchez
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionDB {

    // Proporcionar los parametros para conectarnos a la DB
    private static final String URL = "jdbc:mysql://localhost:3306/furboh";
    private static final String USUARIO = "root";
    private static final String PASS = "root";

    // Crenar nuestra variable de conexion que nos permita verificar si la connexion no esta activada
    private static Connection conexion = null;

    // Connectarnos a la DB
    public static Connection conectar() {
        if (conexion == null) {
            // Recogemos la conexion
            try {
                conexion = DriverManager.getConnection(URL, USUARIO, PASS);
            } catch (SQLException e) {
                System.out.println("Error while connecting to DB " + e.getMessage());
                e.printStackTrace();
            }
        }
    } return conexion;

    public static void desconectar() {
        if(conexion != null) {
            try {
                conexion.close();
                System.out.println("Connection closed successfully");
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                conexion = null;
            }
        }
    }
}
