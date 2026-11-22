package dao;

import java.sql.*;
import java.util.ArrayList;

import modelo.Usuario;
import util.ConexionBBDD;

public class UsuarioDAO {
    public ArrayList<Usuario> listarUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<>();

        Connection conexion = ConexionBBDD.conectar();
        String consulta = "SELECT * FROM usuario";

        try {
            PreparedStatement ps = conexion.prepareStatement(consulta);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setEmail(rs.getString("email"));
                u.setPais(rs.getString("pais"));
                usuarios.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar los usuarios: " + e.getMessage());
        }
        return usuarios;
    }

    public ArrayList<Usuario> buscarPorPais(String pais) {
        ArrayList<Usuario> usuarios = new ArrayList<>();

        Connection conexion = ConexionBBDD.conectar();
        String consulta = "SELECT * FROM usuario WHERE pais = ? ORDER BY nombre_usuario";

        try {
            PreparedStatement ps = conexion.prepareStatement(consulta);
            ps.setString(1, pais);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setEmail(rs.getString("email"));
                u.setPais(rs.getString("pais"));
                usuarios.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar los usuarios: " + e.getMessage());
        }
        return usuarios;
    }

    public Usuario buscarPorId(int id) {

        Connection conexion = ConexionBBDD.conectar();
        String consulta = "SELECT * FROM usuario WHERE id_usuario = ?";

        try {
            PreparedStatement ps = conexion.prepareStatement(consulta);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setEmail(rs.getString("email"));
                u.setPais(rs.getString("pais"));
                return u;
            }

        } catch (SQLException e) {
            System.out.println("Error al listar los usuarios: " + e.getMessage());
       }
        return null;
    }

    public boolean insertarUsuario(Usuario u) {
        Connection conexion = ConexionBBDD.conectar();
        String consular = "INSERT INTO usuario (nombre_usuario, email, pais) VALUES (?, ?, ?)";

        try {
            PreparedStatement ps = conexion.prepareStatement(consular);
            ps.setString(1, u.getNombreUsuario());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPais());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar usuario: " + e.getMessage());
            return false;
        }
    }

    public boolean borrarUsuario(Usuario u) {
        Connection conexion = ConexionBBDD.conectar();
        String consular = "DELETE FROM usuario WHERE id_usuario = ?";

        try {
            PreparedStatement ps = conexion.prepareStatement(consular);
            ps.setInt(1, u.getIdUsuario());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }
}
