package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import modelo.Jugador;
import util.ConexionBBDD;

public class JugadorDAO {

	// Convierte la fila actual del ResultSet en un objeto Jugador
	private Jugador mapear(ResultSet rs) throws SQLException {
		return new Jugador(rs.getInt("id_jugador"), rs.getString("nombre"), rs.getInt("edad"));
	}

	// a. Listar todos los jugadores
	public ArrayList<Jugador> listarJugadores() {
		ArrayList<Jugador> jugadores = new ArrayList<>();
		Connection conexion = ConexionBBDD.conectar();
		String consulta = "SELECT id_jugador, nombre, edad FROM jugador";

		try (PreparedStatement ps = conexion.prepareStatement(consulta);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				jugadores.add(mapear(rs));
			}
		} catch (SQLException e) {
			System.out.println("Error al listar los jugadores: " + e.getMessage());
		}
		return jugadores;
	}

	// b. Jugadores con edad >= edadMinima, de mayor a menor edad
	public ArrayList<Jugador> buscarJugadoresEdad(int edadMinima) {
		ArrayList<Jugador> jugadores = new ArrayList<>();
		Connection conexion = ConexionBBDD.conectar();
		String consulta = "SELECT id_jugador, nombre, edad FROM jugador WHERE edad >= ? ORDER BY edad DESC";

		try (PreparedStatement ps = conexion.prepareStatement(consulta)) {
			ps.setInt(1, edadMinima);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					jugadores.add(mapear(rs));
				}
			}
		} catch (SQLException e) {
			System.out.println("Error al buscar los jugadores: " + e.getMessage());
		}
		return jugadores;
	}

	// Buscar un jugador por id. Devuelve null si no existe
	public Jugador buscarJugadorPorId(int id) {
		Connection conexion = ConexionBBDD.conectar();
		String consulta = "SELECT id_jugador, nombre, edad FROM jugador WHERE id_jugador = ?";

		try (PreparedStatement ps = conexion.prepareStatement(consulta)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapear(rs);
				}
			}
		} catch (SQLException e) {
			System.out.println("Error al buscar el jugador: " + e.getMessage());
		}
		return null;
	}

	// c. Insertar un jugador (el id es AUTO_INCREMENT)
	public boolean insertarJugador(Jugador jugador) {
		Connection conexion = ConexionBBDD.conectar();
		String consulta = "INSERT INTO jugador (nombre, edad) VALUES (?, ?)";

		try (PreparedStatement ps = conexion.prepareStatement(consulta)) {
			ps.setString(1, jugador.getNombreJugador());
			ps.setInt(2, jugador.getEdadJugador());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.out.println("Error al insertar el jugador: " + e.getMessage());
			return false;
		}
	}

	// d. Actualizar nombre y edad de un jugador
	public boolean actualizarJugador(Jugador jugador) {
		Connection conexion = ConexionBBDD.conectar();
		String consulta = "UPDATE jugador SET nombre = ?, edad = ? WHERE id_jugador = ?";

		try (PreparedStatement ps = conexion.prepareStatement(consulta)) {
			ps.setString(1, jugador.getNombreJugador());
			ps.setInt(2, jugador.getEdadJugador());
			ps.setInt(3, jugador.getIdJugador());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.out.println("Error al actualizar el jugador: " + e.getMessage());
			return false;
		}
	}

	// e. Borrar un jugador por id
	public boolean borrarJugador(int id) {
		Connection conexion = ConexionBBDD.conectar();
		String consulta = "DELETE FROM jugador WHERE id_jugador = ?";

		try (PreparedStatement ps = conexion.prepareStatement(consulta)) {
			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.out.println("Error al borrar el jugador: " + e.getMessage());
			return false;
		}
	}
}
