package app;

import java.util.Scanner;
import java.util.ArrayList;

import dao.UsuarioDAO;
import modelo.Usuario;
import util.ConexionBBDD;
public class Main {
    static Scanner sc = new Scanner(System.in);
    static UsuarioDAO dao = new UsuarioDAO();
    public static void main(String[] args) {
        int opcion;

        do {
            menu();
            opcion = leerEntero("Opcion: ");
            switch (opcion) {
                case 1:
                    listarUsuarios();
                    break;
                case 2:
                    buscarPorPais();
                    break;
                case 3:
                    insertarUsuario();
                    break;
                case 4:
                    borrarUsuario();
                    break;
                case 0:
                    System.out.println("Saliendo de la aplicacion");
                    break;
                default:
                    System.out.println("Opcion no valida");
            }
        } while (opcion != 0);

        ConexionBBDD.desconectar();
    }

    private static void menu() {
        System.out.println("\n1. Listar usuarios");
        System.out.println("2. Buscar por pais");
        System.out.println("3. Insertar usuario");
        System.out.println("4. Eliminar usuario");
        System.out.println("0. Salir");
    }

    // Opciones del menu
    private static void listarUsuarios() {
        ArrayList<Usuario> listaUsuarios = dao.listarUsuarios();
        mostrar(listaUsuarios);
    }

    private static void buscarPorPais() {
        System.out.println("Pais: ");
        String pais = sc.nextLine();
        ArrayList<Usuario> listaUsuarios = dao.buscarPorPais(pais);
        mostrar(listaUsuarios);
    }

    private static void insertarUsuario() {
        System.out.println("Nombre: ");
        String nombre = sc.nextLine().trim();
        System.out.println("Email: ");
        String email = sc.nextLine().trim();
        System.out.println("Pais: ");
        String pais = sc.nextLine().trim();

        Usuario u = new Usuario(nombre, email, pais);

        if (dao.insertarUsuario(u)) {
            System.out.println("Usuario insertado");
            listarUsuarios();
        } else  {
            System.out.println("Error al insertar usuario");
        }
    }

    private static void borrarUsuario() {
        int id = leerEntero("Id del usuario a borrar:");
        Usuario u = dao.buscarPorId(id);
        if (u == null) {
            System.out.println("Usuario no encontrado");
            return;
        }
        System.out.println(u);
        System.out.println("Seguro que quieres borrarlo? (S/N): ");
        String respuesta = sc.nextLine().trim();

        if (respuesta.equalsIgnoreCase("S")) {
            if (dao.borrarUsuario(u)) {
                System.out.println("Usuario borrado");
            } else  {
                System.out.println("Error al borrar usuario");
            }
        } else {
            System.out.println("Operacion Cancelada");
        }
    }


    // Auiliares

    private static void mostrar(ArrayList<Usuario> usuarios) {
        if (usuarios.isEmpty()) {
            System.out.println("No existen usuarios");
            return;
        }
        for (Usuario u : usuarios) {
            System.out.println(u);
        }
    }

    private static int leerEntero(String mensaje) {
        while (true) {
            System.out.print(mensaje);
            try {
                return Integer.parseInt(sc.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Error: introduce un numero entero");
            }
        }
    }
}
