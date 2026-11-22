package dao;

import java.sql.*;
import java.util.*;

import modelo.Estadio;
import util.ConexionBD;
public class EstadioDAO {

    public ArrayList<Estadio> listarEstadios() {
        ArrayList<Estadio> estadios = new ArrayList<>();

        Connection conexion = ConexionBD.conectar();
        String consulta = "SELECT * FROM estadio ORDER BY id_estadio";

        try (PreparedStatement ps = conexion.prepareStatement(consulta);) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Estadio e = new Estadio();
                e.setIdEstadio(rs.getInt("id_estadio"));
                e.setNombre(rs.getString("nombre"));
                e.setCiudad(rs.getString("ciudad"));
                e.setPais(rs.getString("pais"));
                e.setAforo(rs.getInt("aforo"));
                estadios.add(e);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar los estadios: " + ex.getMessage());
        }
        return estadios;
    }

    public ArrayList<Estadio> buscarPorCiudad(String ciudad) {
        ArrayList<Estadio> estadios = new ArrayList<>();

        Connection conexion = ConexionBD.conectar();
        String consulta = "SELECT * FROM estadio WHERE ciudad = ?";

        try {
            PreparedStatement ps; ps = conexion.prepareStatement(consulta);
            ps.setString(1, ciudad);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Estadio e = new Estadio();
                e.setIdEstadio(rs.getInt("id_estadio"));
                e.setNombre(rs.getString("nombre"));
                e.setCiudad(rs.getString("ciudad"));
                e.setPais(rs.getString("pais"));
                e.setAforo(rs.getInt("aforo"));
                estadios.add(e);
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar estadios por ciudad: " + ex.getMessage());
        }
        return estadios;
    }

    public ArrayList<Estadio> buscarPorId(int id) {
        ArrayList<Estadio> estadios = new ArrayList<>();

        Connection conexion = ConexionBD.conectar();
        String consulta = "SELECT * FROM estadio WHERE id_estadio = ?";

        try {
            PreparedStatement ps; ps = conexion.prepareStatement(consulta);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Estadio e = new Estadio();
                e.setIdEstadio(rs.getInt("id_estadio"));
                e.setNombre(rs.getString("nombre"));
                e.setCiudad(rs.getString("ciudad"));
                e.setPais(rs.getString("pais"));
                e.setAforo(rs.getInt("aforo"));
                estadios.add(e);
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar el estadio por id: " + ex.getMessage());
        }
        return estadios;
    }

    public boolean insertarEstadio(Estadio e) {
        Connection conexion = ConexionBD.conectar();
        String consulta = "INSERT INTO estadio (nombre, ciudad, pais, aforo) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = conexion.prepareStatement(consulta);
            ps.setString(1, e.getNombre());
            ps.setString(2, e.getCiudad());
            ps.setString(3, e.getPais());
            ps.setInt(4, e.getAforo());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println("Error al insertar el estadio: " + ex.getMessage());
            return false;
        }
    }

    public boolean actualizarEstadio(Estadio e) {
        Connection conexion = ConexionBD.conectar();
        String consulta = "UPDATE estadio SET nombre = ?, ciudad = ?, pais = ?, aforo = ? WHERE id_estadio = ?";

        try {
            PreparedStatement ps = conexion.prepareStatement(consulta);
            ps.setString(1, e.getNombre());
            ps.setString(2, e.getCiudad());
            ps.setString(3, e.getPais());
            ps.setInt(4, e.getAforo());
            ps.setInt(5, e.getIdEstadio());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println("Error al actualizar el estadio: " + ex.getMessage());
            return false;
        }
    }

    public boolean borrarEstadio(int id) {
        Connection conexion = ConexionBD.conectar();
        String consulta = "DELETE FROM estadio WHERE id_estadio = ?";

        try {
            PreparedStatement ps = conexion.prepareStatement(consulta);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            if (ex.getErrorCode() == 1451) {
                System.out.println("No se puede borrar: el estadio es sede de algun evento");
            } else {
                System.out.println("Error al borrar el estadio: " + ex.getMessage());
            }
            return false;
        }
    }


}
