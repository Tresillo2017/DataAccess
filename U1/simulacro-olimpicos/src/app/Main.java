package app;

import java.util.ArrayList;
import java.util.Scanner;

import dao.EstadioDAO;
import modelo.Estadio;
import util.ConexionBD;
import util.EstadioXML;

public class Main {

    static Scanner sc = new Scanner(System.in);
    static EstadioDAO dao = new EstadioDAO();

    private static final String RUTA_XML = "exportaciones/estadios.xml";

    public static void main(String[] args) {

        if (ConexionBD.conectar() == null) {
            System.out.println("No se pudo conectar con la base de datos. Saliendo.");
            return;
        }

        int opcion;

        do {
            menu();
            opcion = leerEntero("Opción: ");

            switch (opcion) {
                case 1:
                    mostrarEstadios();
                    break;
                case 2:
                    buscarPorCiudad();
                    break;
                case 3:
                    insertarEstadio();
                    break;
                case 4:
                    modificarEstadio();
                    break;
                case 5:
                    eliminarEstadio();
                    break;
                case 0:
                    System.out.println("Saliendo de la aplicación");
                    break;
                default:
                    System.out.println("Opción no válida");
            }
        } while (opcion != 0);

        ConexionBD.desconectar();
    }

    private static void menu() {
        System.out.println("\n1. Mostrar todos los estadios");
        System.out.println("2. Buscar estadios por ciudad");
        System.out.println("3. Registrar un nuevo estadio");
        System.out.println("4. Modificar un estadio");
        System.out.println("5. Eliminar un estadio");
        System.out.println("0. Salir");
    }

    // ---------- Opciones del menú ----------

    private static void mostrarEstadios() {
        ArrayList<Estadio> estadios = dao.listarEstadios();
        mostrar(estadios);

        if (estadios.isEmpty()) {
            return;
        }

        if (confirmar("\n¿Quieres exportar los estadios a XML? (S/N): ")) {
            if (EstadioXML.exportarEstadios(estadios, RUTA_XML)) {
                System.out.println("XML generado correctamente en " + RUTA_XML);

                if (confirmar("¿Quieres leer el fichero XML? (S/N): ")) {
                    EstadioXML.leerXML(RUTA_XML);
                }
            } else {
                System.out.println("No se pudo generar el XML");
            }
        }
    }

    private static void buscarPorCiudad() {
        String ciudad = leerTexto("Ciudad: ");
        mostrar(dao.buscarPorCiudad(ciudad));
    }

    private static void insertarEstadio() {
        String nombre = leerTexto("Nombre: ");
        String ciudad = leerTexto("Ciudad: ");
        String pais = leerTexto("Pais: ");
        int aforo = leerPositivo("Aforo: ");

        Estadio e = new Estadio(nombre, ciudad, pais, aforo);

        if (dao.insertarEstadio(e)) {
            System.out.println("Estadio insertado");
        } else {
            System.out.println("No se pudo insertar");
        }
    }

    private static void modificarEstadio() {
        int id = leerPositivo("Id del estadio a modificar: ");
        if (dao.buscarPorId(id).isEmpty()) {
            System.out.println("No existe ese estadio");
            return;
        }
        String nombre = leerTexto("Nombre: ");
        String ciudad = leerTexto("Ciudad: ");
        String pais = leerTexto("Pais: ");
        int aforo = leerPositivo("Aforo: ");

        Estadio e = new Estadio(id, nombre, ciudad, pais, aforo);

        if (dao.actualizarEstadio(e)) {
            System.out.println("Estadio modificado");
        } else {
            System.out.println("No se modifico ningun registro");
        }
    }

    private static void eliminarEstadio() {
        int id = leerPositivo("Id del estadio a eliminar: ");

        ArrayList<Estadio> encontrados = dao.buscarPorId(id);
        if (encontrados.isEmpty()) {
            System.out.println("No existe ningún estadio con ese id");
            return;
        }

        System.out.println(encontrados.get(0));

        if (confirmar("¿Seguro que quieres eliminarlo? (S/N): ")) {
            if (dao.borrarEstadio(id)) {
                System.out.println("Estadio eliminado correctamente");
            } else {
                System.out.println("No se pudo eliminar el estadio");
            }
        } else {
            System.out.println("Operación cancelada");
        }
    }

    // ---------- Auxiliares ----------

    private static void mostrar(ArrayList<Estadio> estadios) {
        if (estadios.isEmpty()) {
            System.out.println("No se han encontrado estadios");
            return;
        }
        for (Estadio e : estadios) {
            System.out.println(e);
        }
    }

    // ---------- Lectura con validación ----------

    // Un entero cualquiera; si escribe texto, avisa y vuelve a pedirlo
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

    // Un entero MAYOR QUE CERO (para el aforo y los ids)
    private static int leerPositivo(String mensaje) {
        while (true) {
            int numero = leerEntero(mensaje);
            if (numero > 0) {
                return numero;
            }
            System.out.println("Error: debe ser mayor que cero");
        }
    }

    // Un texto que NO esté vacío (para nombre, ciudad y país)
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

    // Pregunta S/N y devuelve true si responde S
    private static boolean confirmar(String mensaje) {
        System.out.print(mensaje);
        return sc.nextLine().trim().equalsIgnoreCase("S");
    }
}
