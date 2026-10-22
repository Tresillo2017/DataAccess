package objectos;

import acceso.ConnexionDB;
import acceso.consultasPelicula;
import datos.Pelicula;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class Main {

    private static final Scanner sc = new Scanner(System.in);
    private static final List<String> CLASIFICACIONES = Arrays.asList("TP", "7+", "12+", "16+", "18+");
    private static final String FORMATO = "%-4s %-38s %-10s %-5s %-12s %-5s %14s %14s %-4s %-4s %-7s%n";

    // Campos actualizables: columna -> tipo (T texto, I entero, D decimal, F fecha, C clasificacion)
    private static final Map<String, Character> CAMPOS = new LinkedHashMap<>();
    // Campos que admiten NULL (se dejan en blanco)
    private static final List<String> NULABLES = Arrays.asList("sinopsis", "id_genero_secundario", "id_pelicula_secuela");

    static {
        CAMPOS.put("titulo", 'T');
        CAMPOS.put("sinopsis", 'T');
        CAMPOS.put("fecha_estreno", 'F');
        CAMPOS.put("duracion_min", 'I');
        CAMPOS.put("idioma_original", 'T');
        CAMPOS.put("clasificacion_edad", 'C');
        CAMPOS.put("presupuesto", 'D');
        CAMPOS.put("recaudacion", 'D');
        CAMPOS.put("id_genero_principal", 'I');
        CAMPOS.put("id_genero_secundario", 'I');
        CAMPOS.put("id_pelicula_secuela", 'I');
    }

    public static void main(String[] args) {
        if (ConnexionDB.conectar() == null) {
            return;
        }
        int opcion;
        do {
            menu();
            opcion = leerEntero("Opcion: ");
            switch (opcion) {
                case 1: listarPeliculas(); break;
                case 2: insertarPelicula(); break;
                case 3: actualizarPelicula(); break;
                case 4: borrarPelicula(); break;
                case 5: exportarPeliculas(); break;
                case 0: break;
                default: System.out.println("Opcion invalida");
            }
        } while (opcion != 0);
        ConnexionDB.desconectar();
    }

    private static void menu() {
        System.out.println("\n===== UCAMFLIX =====");
        System.out.println("1. Listar peliculas");
        System.out.println("2. Insertar pelicula");
        System.out.println("3. Actualizar pelicula");
        System.out.println("4. Borrar pelicula");
        System.out.println("5. Exportar peliculas a TXT y CSV");
        System.out.println("0. Salir");
    }

    // ---------- Opciones del menu ----------

    private static void listarPeliculas() {
        List<Pelicula> peliculas = consultasPelicula.mostrarPeliculas();
        System.out.print(tabla(peliculas));
        System.out.println(peliculas.size() + " peliculas");
    }

    private static void insertarPelicula() {
        String titulo = leerTexto("Titulo: ", false);
        String sinopsis = leerTexto("Sinopsis (vacio = ninguna): ", true);
        String fecha = leerValor("Fecha de estreno (yyyy-MM-dd): ", 'F', false);
        int duracion = Integer.parseInt(leerValor("Duracion (min): ", 'I', false));
        String idioma = leerTexto("Idioma original: ", false);
        String clasificacion = leerValor("Clasificacion " + CLASIFICACIONES + ": ", 'C', false);
        double presupuesto = Double.parseDouble(leerValor("Presupuesto: ", 'D', false));
        double recaudacion = Double.parseDouble(leerValor("Recaudacion: ", 'D', false));
        int generoPrincipal = Integer.parseInt(leerValor("Id genero principal: ", 'I', false));
        String gen2 = leerValor("Id genero secundario (vacio = ninguno): ", 'I', true);
        String secuela = leerValor("Id pelicula de la que es secuela (vacio = ninguna): ", 'I', true);

        Pelicula p = new Pelicula(0, titulo, sinopsis, fecha, duracion, idioma, clasificacion, presupuesto,
                recaudacion, generoPrincipal, gen2 == null ? null : Integer.valueOf(gen2),
                secuela == null ? null : Integer.valueOf(secuela));
        System.out.println(consultasPelicula.insertarPelicula(p) ? "Pelicula insertada" : "No se inserto la pelicula");
    }

    private static void actualizarPelicula() {
        int id = leerEntero("Id de la pelicula a actualizar: ");
        String campo;
        do {
            campo = leerTexto("Campo a modificar " + CAMPOS.keySet() + ": ", false).toLowerCase();
            if (!CAMPOS.containsKey(campo)) {
                System.out.println("Campo no valido");
            }
        } while (!CAMPOS.containsKey(campo));

        boolean nulable = NULABLES.contains(campo);
        String valor = leerValor("Nuevo valor" + (nulable ? " (vacio = NULL)" : "") + ": ", CAMPOS.get(campo), nulable);
        System.out.println(consultasPelicula.actualizarPelicula(id, campo, valor)
                ? "Pelicula actualizada" : "No se actualizo la pelicula");
    }

    private static void borrarPelicula() {
        int id = leerEntero("Id de la pelicula a borrar: ");
        System.out.println(consultasPelicula.borrarPelicula(id) ? "Pelicula borrada" : "No se borro la pelicula");
    }

    private static void exportarPeliculas() {
        List<Pelicula> peliculas = consultasPelicula.mostrarPeliculas();
        File carpeta = new File("exportaciones");
        carpeta.mkdirs();
        try (BufferedWriter txt = Files.newBufferedWriter(new File(carpeta, "peliculas.txt").toPath(), StandardCharsets.UTF_8);
             BufferedWriter csv = Files.newBufferedWriter(new File(carpeta, "peliculas.csv").toPath(), StandardCharsets.UTF_8)) {
            txt.write(tabla(peliculas));
            csv.write("id_pelicula,titulo,sinopsis,fecha_estreno,duracion_min,idioma_original,clasificacion_edad,"
                    + "presupuesto,recaudacion,id_genero_principal,id_genero_secundario,id_pelicula_secuela");
            csv.newLine();
            for (Pelicula p : peliculas) {
                csv.write(String.join(",", String.valueOf(p.getIdPelicula()), csv(p.getTitulo()), csv(p.getSinopsis()),
                        csv(p.getFechaEstreno()), String.valueOf(p.getDuracionMin()), csv(p.getIdiomaOriginal()),
                        csv(p.getClasificacionEdad()), String.valueOf(p.getPresupuesto()),
                        String.valueOf(p.getRecaudacion()), String.valueOf(p.getIdGeneroPrincipal()),
                        csv(p.getIdGeneroSecundario()), csv(p.getIdPeliculaSecuela())));
                csv.newLine();
            }
            System.out.println("Exportadas " + peliculas.size() + " peliculas en " + carpeta.getAbsolutePath());
        } catch (IOException e) {
            System.out.println("Error al exportar: " + e.getMessage());
        }
    }

    // ---------- Formato ----------

    private static String tabla(List<Pelicula> peliculas) {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(FORMATO, "ID", "TITULO", "ESTRENO", "MIN", "IDIOMA", "EDAD", "PRESUPUESTO",
                "RECAUDACION", "GEN1", "GEN2", "SECUELA"));
        sb.append("-".repeat(130)).append(System.lineSeparator());
        for (Pelicula p : peliculas) {
            sb.append(String.format(FORMATO, p.getIdPelicula(), recortar(p.getTitulo(), 38), p.getFechaEstreno(),
                    p.getDuracionMin(), recortar(p.getIdiomaOriginal(), 12), p.getClasificacionEdad(),
                    String.format("%,.2f", p.getPresupuesto()), String.format("%,.2f", p.getRecaudacion()),
                    p.getIdGeneroPrincipal(), p.getIdGeneroSecundario() == null ? "-" : p.getIdGeneroSecundario(),
                    p.getIdPeliculaSecuela() == null ? "-" : p.getIdPeliculaSecuela()));
        }
        return sb.toString();
    }

    private static String recortar(String s, int max) {
        if (s == null) return "";
        return s.length() <= max ? s : s.substring(0, max - 1) + "…";
    }

    private static String csv(Object o) {
        if (o == null) return "";
        if (o instanceof Number) return o.toString();
        return "\"" + o.toString().replace("\"", "\"\"") + "\"";
    }

    // ---------- Lectura de teclado con control de errores ----------

    private static int leerEntero(String mensaje) {
        while (true) {
            System.out.print(mensaje);
            try {
                return Integer.parseInt(sc.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Introduce un numero entero");
            }
        }
    }

    private static String leerTexto(String mensaje, boolean nulable) {
        while (true) {
            System.out.print(mensaje);
            String s = sc.nextLine().trim();
            if (!s.isEmpty()) return s;
            if (nulable) return null;
            System.out.println("El campo no puede estar vacio");
        }
    }

    // Lee un valor del tipo indicado; devuelve el String validado (o null si es nulable y se deja vacio)
    private static String leerValor(String mensaje, char tipo, boolean nulable) {
        while (true) {
            String s = leerTexto(mensaje, nulable);
            if (s == null) return null;
            try {
                switch (tipo) {
                    case 'I': Integer.parseInt(s); break;
                    case 'D': Double.parseDouble(s); break;
                    case 'F': LocalDate.parse(s); break;
                    case 'C':
                        if (!CLASIFICACIONES.contains(s)) throw new IllegalArgumentException();
                        break;
                    default: break;
                }
                return s;
            } catch (NumberFormatException | DateTimeParseException e) {
                System.out.println("Valor invalido");
            } catch (IllegalArgumentException e) {
                System.out.println("Debe ser uno de " + CLASIFICACIONES);
            }
        }
    }
}
