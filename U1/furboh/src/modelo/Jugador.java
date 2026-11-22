package modelo;

public class Jugador {

	private int idJugador;
	private String nombreJugador;
	private int edadJugador;
	
	public Jugador() {
		super();
	}

	public Jugador(int idJugador, String nombreJugador, int edadJugador) {
		super();
		this.idJugador = idJugador;
		this.nombreJugador = nombreJugador;
		this.edadJugador = edadJugador;
	}

	public Jugador(String nombreJugador, int edadJugador) {
		super();
		this.nombreJugador = nombreJugador;
		this.edadJugador = edadJugador;
	}

	public int getIdJugador() {
		return idJugador;
	}

	public void setIdJugador(int idJugador) {
		this.idJugador = idJugador;
	}

	public String getNombreJugador() {
		return nombreJugador;
	}

	public void setNombreJugador(String nombreJugador) {
		this.nombreJugador = nombreJugador;
	}

	public int getEdadJugador() {
		return edadJugador;
	}

	public void setEdadJugador(int edadJugador) {
		this.edadJugador = edadJugador;
	}

	@Override
	public String toString() {
		return "Jugador [idJugador=" + idJugador + ", nombreJugador=" + nombreJugador + ", edadJugador=" + edadJugador
				+ "]";
	}
	
	
	
}
