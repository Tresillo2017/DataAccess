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

package objectos;

import acceso.ConnexionDB;

import java.util.Scanner;

public class Main {

    private static Scanner scInt = new Scanner(System.in);

    public static void main(String[] args) {
        ConnexionDB.conectar();
        menu();

        int opcion;

        do {
            menu();
            opcion = scInt.nextInt();

            switch (opcion) {
                case 1:
                    mostrarJugadores();
                    break;
                case 2:
                    buscarJugadores();
                    break;
                case 3:
                    insertarJugadores();
                    break;
                case 4:
                    modificarJugadores();
                    break;
                case 5:
                    eliminarJugadores();
                    break;
                default:
                    System.out.print("Opcion invalida");
                    break;
            }

        } while (opcion != 0);

        ConnexionDB.desconectar();
    }
    private static void menu() {
        System.out.println("1. Mostrar todos los jugadores");
        System.out.println("2. Buscar jugador por nombre");
        System.out.println("3. Insertar jugador");
        System.out.println("4. Modificar jugador");
        System.out.println("5. Borrar un jugador");
    }

    private static void mostrarJugadores() {
    }
    private static void buscarJugadores() {
    }
    private static void insertarJugadores() {
    }
    private static void modificarJugadores() {
    }
    private static void eliminarJugadores() {
    }
}