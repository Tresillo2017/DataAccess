package app;

import java.util.ArrayList;
import java.util.Scanner;

import dao.JugadorDAO;
import modelo.Jugador;
import util.ConexionBBDD;

public class Main {

	// Un unico Scanner: todo se lee con nextLine() y se convierte despues
	private static final Scanner sc = new Scanner(System.in);
	private static final JugadorDAO jugadorDAO = new JugadorDAO();

	private static final int EDAD_MIN = 15;
	private static final int EDAD_MAX = 50;

	public static void main(String[] args) {

		if (ConexionBBDD.conectar() == null) {
			System.out.println("No se pudo conectar. Saliendo.");
			return;
		}

		int opcion;
		do {
			menu();
			opcion = leerEntero("Opción: ");

			switch (opcion) {
			case 1:
				listarJugadores();
				break;
			case 2:
				buscarJugadoresEdad();
				break;
			case 3:
				insertarJugador();
				break;
			case 4:
				actualizarJugador();
				break;
			case 5:
				borrarJugador();
				break;
			case 0:
				System.out.println("Saliendo de la aplicación");
				break;
			default:
				System.out.println("Opción no válida");
			}
		} while (opcion != 0);

		sc.close();
		ConexionBBDD.desconectar();
	}

	private static void menu() {
		System.out.println("\n1. Listar jugadores");
		System.out.println("2. Buscar jugadores por edad mínima");
		System.out.println("3. Insertar jugador");
		System.out.println("4. Actualizar jugador");
		System.out.println("5. Borrar jugador");
		System.out.println("0. Salir");
	}

	// ---------- Opciones del menú ----------

	private static void listarJugadores() {
		mostrar(jugadorDAO.listarJugadores());
	}

	private static void buscarJugadoresEdad() {
		int edadMinima = leerEdad("Introduce la edad mínima: ");
		mostrar(jugadorDAO.buscarJugadoresEdad(edadMinima));
	}

	private static void insertarJugador() {
		String nombre = leerTexto("Nombre del nuevo jugador: ");
		int edad = leerEdad("Edad del nuevo jugador: ");

		if (jugadorDAO.insertarJugador(new Jugador(nombre, edad))) {
			System.out.println("Jugador insertado correctamente\n");
			listarJugadores();
		} else {
			System.out.println("Error. Jugador no insertado");
		}
	}

	private static void actualizarJugador() {
		int id = leerEntero("Id del jugador a modificar: ");

		// Comprobamos que existe antes de modificarlo
		Jugador jugador = jugadorDAO.buscarJugadorPorId(id);
		if (jugador == null) {
			System.out.println("No existe ningún jugador con ese id");
			return;
		}
		System.out.println("Jugador actual: " + jugador);

		System.out.println("¿Qué quieres modificar? 1. Nombre  2. Edad");
		int campo = leerEntero("Opción: ");

		if (campo == 1) {
			jugador.setNombreJugador(leerTexto("Nuevo nombre: "));
		} else if (campo == 2) {
			jugador.setEdadJugador(leerEdad("Nueva edad: "));
		} else {
			System.out.println("Opción no válida");
			return;
		}

		if (jugadorDAO.actualizarJugador(jugador)) {
			System.out.println("Jugador actualizado correctamente");
			// Mostramos el jugador leyéndolo de la BBDD para comprobar el cambio
			System.out.println(jugadorDAO.buscarJugadorPorId(id));
		} else {
			System.out.println("No se pudo actualizar el jugador");
		}
	}

	private static void borrarJugador() {
		int id = leerEntero("Id del jugador a borrar: ");

		Jugador jugador = jugadorDAO.buscarJugadorPorId(id);
		if (jugador == null) {
			System.out.println("No existe ningún jugador con ese id");
			return;
		}

		System.out.println(jugador);
		System.out.print("¿Seguro que quieres borrarlo? (S/N): ");

		if (sc.nextLine().trim().equalsIgnoreCase("S")) {
			if (jugadorDAO.borrarJugador(id)) {
				System.out.println("Jugador borrado correctamente");
			} else {
				System.out.println("No se pudo borrar el jugador");
			}
		} else {
			System.out.println("Operación cancelada");
		}
	}

	// ---------- Auxiliares ----------

	private static void mostrar(ArrayList<Jugador> jugadores) {
		if (jugadores.isEmpty()) {
			System.out.println("No se han encontrado jugadores");
			return;
		}
		for (Jugador jugador : jugadores) {
			System.out.println(jugador);
		}
	}

	// ---------- Lectura de teclado con control de errores ----------

	private static int leerEntero(String mensaje) {
		while (true) {
			System.out.print(mensaje);
			try {
				return Integer.parseInt(sc.nextLine().trim());
			} catch (NumberFormatException e) {
				System.out.println("Error: introduce un número entero");
			}
		}
	}

	// Pide un entero hasta que esté dentro del rango de edades válido
	private static int leerEdad(String mensaje) {
		while (true) {
			int edad = leerEntero(mensaje);
			if (edad >= EDAD_MIN && edad <= EDAD_MAX) {
				return edad;
			}
			System.out.println("Error: la edad debe estar entre " + EDAD_MIN + " y " + EDAD_MAX);
		}
	}

	private static String leerTexto(String mensaje) {
		while (true) {
			System.out.print(mensaje);
			String texto = sc.nextLine().trim();
			if (!texto.isEmpty()) {
				return texto;
			}
			System.out.println("Error: el campo no puede estar vacío");
		}
	}
}
