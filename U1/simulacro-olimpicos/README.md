# Simulacro examen JDBC + XML (juegos olímpicos)

Lo que daría el profesor:
- `PRÁCTICA FULL JUEGOS OLÍMPICOS.pdf` – enunciado
- `juegos_olimpicos.sql` – base de datos
- `src/util/ConexionBD.java` – clase de conexión (ya hecha)
- `lib/mysql-connector-java-5.1.47.jar` – driver JDBC

Tú creas: `modelo/Estadio.java`, `dao/EstadioDAO.java`, `util/EstadioXML.java` (o `xml/`), `app/Main.java`.

Arrancar la BBDD: `DB_PASSWORD=mysql ./db.sh start` (desde la raíz del repo).
Si el servidor ya estaba en marcha, importa la BBDD con:
`./db.sh shell` y luego `source db/juegos_olimpicos.sql`
