package acceso;

import datos.Pelicula;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class consultasPelicula {

    // a. Listar todas las peliculas
    public static List<Pelicula> mostrarPeliculas() {
        List<Pelicula> lista = new ArrayList<>();
        Connection conexion = ConnexionDB.conectar();
        try (PreparedStatement ps = conexion.prepareStatement("SELECT * FROM pelicula ORDER BY id_pelicula");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Pelicula(
                        rs.getInt("id_pelicula"), rs.getString("titulo"), rs.getString("sinopsis"),
                        rs.getString("fecha_estreno"), rs.getInt("duracion_min"), rs.getString("idioma_original"),
                        rs.getString("clasificacion_edad"), rs.getDouble("presupuesto"), rs.getDouble("recaudacion"),
                        rs.getInt("id_genero_principal"),
                        (Integer) rs.getObject("id_genero_secundario"), (Integer) rs.getObject("id_pelicula_secuela")));
            }
        } catch (SQLException e) {
            System.out.println("Error al listar las peliculas: " + e.getMessage());
        }
        return lista;
    }

    // b. Insertar una pelicula
    public static boolean insertarPelicula(Pelicula p) {
        String sql = "INSERT INTO pelicula (titulo, sinopsis, fecha_estreno, duracion_min, idioma_original, "
                + "clasificacion_edad, presupuesto, recaudacion, id_genero_principal, id_genero_secundario, "
                + "id_pelicula_secuela) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try (PreparedStatement ps = ConnexionDB.conectar().prepareStatement(sql)) {
            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getSinopsis());
            ps.setString(3, p.getFechaEstreno());
            ps.setInt(4, p.getDuracionMin());
            ps.setString(5, p.getIdiomaOriginal());
            ps.setString(6, p.getClasificacionEdad());
            ps.setDouble(7, p.getPresupuesto());
            ps.setDouble(8, p.getRecaudacion());
            ps.setInt(9, p.getIdGeneroPrincipal());
            ps.setObject(10, p.getIdGeneroSecundario());
            ps.setObject(11, p.getIdPeliculaSecuela());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar la pelicula: " + e.getMessage());
            return false;
        }
    }

    // c. Actualizar un campo de una pelicula. El nombre de columna no se puede parametrizar,
    // por eso el Main solo lo deja pasar si esta en su lista de campos validos.
    public static boolean actualizarPelicula(int id, String campo, String valor) {
        String sql = "UPDATE pelicula SET " + campo + " = ? WHERE id_pelicula = ?";
        try (PreparedStatement ps = ConnexionDB.conectar().prepareStatement(sql)) {
            ps.setString(1, valor); // valor null => NULL en la BBDD
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar la pelicula: " + e.getMessage());
            return false;
        }
    }

    // d. Borrar una pelicula
    public static boolean borrarPelicula(int id) {
        try (PreparedStatement ps = ConnexionDB.conectar().prepareStatement("DELETE FROM pelicula WHERE id_pelicula = ?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al borrar la pelicula: " + e.getMessage());
            return false;
        }
    }
}
