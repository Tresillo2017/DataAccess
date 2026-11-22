# PRÁCTICA JDBC – Gestión de usuarios de Jueguicos

**Módulo:** Acceso a Datos  
**Tiempo:** 1 hora y 30 minutos  
**Material permitido:** chuleta JDBC  
**Entrega:** comprimir los archivos `.java` en una carpeta llamada `NombreApellido`.

Para aprobar es imprescindible un 5.

## Contexto
Una plataforma de videojuegos quiere gestionar sus usuarios desde una aplicación de consola.
Se te proporciona la base de datos `jueguicos.sql` y la clase `ConexionBBDD`, que ya
establece la conexión. No hace falta modificarla.

## Tareas

1. **Conexión a la base de datos (0,5 p).** Utiliza la clase `ConexionBBDD` proporcionada
   para conectarte a la BBDD `jueguicos`.

2. **Creación de clases (1 p).** Crea el modelo `Usuario` y el DAO `UsuarioDAO`.
   Únicamente se utilizarán estas columnas de la tabla `usuario`:
   - `id_usuario`: identificador único (clave primaria, autoincremental).
   - `nombre_usuario`: nombre del usuario (VARCHAR).
   - `email`: correo electrónico (VARCHAR).
   - `pais`: país del usuario (VARCHAR).

3. **Implementar un menú con las siguientes opciones:**
   - a. **Listar todos los usuarios (1 p).** Crea un método que devuelva el id, nombre, email
     y país de todos los usuarios almacenados.
   - b. **Buscar usuarios por país (1,5 p).** Crea un método que solicite un país por teclado
     y muestre los usuarios de ese país, ordenados alfabéticamente por nombre. Si no hay
     ninguno, se mostrará un mensaje.
   - c. **Insertar un nuevo usuario (2 p).** Crea un método que inserte un usuario pidiendo
     por teclado su nombre, email y país. El identificador se generará automáticamente.
     Tras insertarlo correctamente, se mostrarán todos los usuarios.
   - d. **Borrar un usuario (2 p).** Crea un método que elimine un usuario introduciendo su
     identificador por teclado. Antes de borrarlo se comprobará que existe, se mostrarán sus
     datos y se pedirá confirmación (S/N).

4. **Funcionalidad extra:**
   - a. Control de errores al introducir datos erróneos por teclado (0,5 p).
   - b. Validar que el email introducido contiene el carácter `@` (0,5 p).
   - c. Cerrar correctamente los recursos (`PreparedStatement`, `ResultSet`) y la conexión
     al finalizar (1 p).

## Requisitos generales
- Utiliza `PreparedStatement` en todas las consultas.
- Separa el código en conexión, modelo, DAO y menú principal.
- El menú debe seguir funcionando hasta que el usuario elija la opción de salir.

## AYUDA

**PreparedStatement** → permite ejecutar consultas SQL parametrizadas.
- `setXXX(n, valor)`: establece el valor de los parámetros de la consulta (n indica qué
  parámetro es y valor el dato que queremos poner).
- `executeQuery()`: ejecuta una consulta (SELECT).
- `executeUpdate()`: ejecuta una instrucción que modifica la BBDD (INSERT, UPDATE, DELETE).

**ResultSet** → almacena el conjunto de filas devueltas por una consulta SQL.
- `next()`: devuelve `true` si aún queda información devuelta por la consulta.
