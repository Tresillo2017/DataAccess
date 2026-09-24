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

package acceso;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import datos.Jugador;

public class consultasJugador {

    public static List<Jugador> mostrarJugadores() {
        String consulta = "SELECT * FROM jugadores"; // Seleccionamos todos los jugadores de la tabla
        List<Jugador> listaJugadores = new ArrayList<Jugador>(); // Declaramos la lista donde vamos a almacenar los jugadores

        PreparedStatement ps = null; // Se encarga de gestionar la consulta y parametizarla
        ResultSet resultador = null; // Se encarga de almacenar el resultado de la consulta

        Connection conexion = ConnexionDB.conectar(); // Conectamos con la base de datos
        try {
            ps = conexion.prepareStatement(consulta); // Cargar la consulta en el preparedStatement
            resultador = ps.executeQuery(); // Ejecutamos la consulta y almacenamos el resultado en el resultSet
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        return null;
    }
}
