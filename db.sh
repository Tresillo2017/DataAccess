#!/usr/bin/env bash
# MySQL local (binario oficial descargado en db/server, sin Homebrew ni Docker) con datos dentro del proyecto (db/data).
# Uso: ./db.sh [start|stop|reset|status|shell]
#   start  -> descarga MySQL 8.4 (binario oficial, sin Homebrew) si falta, inicializa,
#             arranca e importa db/*.sql
#   stop   -> para el servidor
#   reset  -> borra db/data y lo reimporta todo desde cero
# Conexion: jdbc:mysql://localhost:3306/<bbdd>  usuario: root  password: root
set -euo pipefail
cd "$(dirname "$0")"

VERSION="8.4.11"
PLATFORM="macos15-x86_64"
PKG="mysql-$VERSION-$PLATFORM"
URL="https://cdn.mysql.com/Downloads/MySQL-8.4/$PKG.tar.gz"
SERVER_DIR="$PWD/db/server"
PORT="${DB_PORT:-3306}"
PASSWORD="${DB_PASSWORD:-root}"
DATADIR="$PWD/db/data"
SOCKET="/tmp/dataaccess-mysql.sock"
PIDFILE="$DATADIR/mysqld.pid"
LOGFILE="$PWD/db/mysql.log"

ensure_mysql() {
  BIN="$SERVER_DIR/$PKG/bin"
  if [ -x "$BIN/mysqld" ]; then return; fi
  echo "Descargando MySQL $VERSION (~170 MB)..."
  mkdir -p "$SERVER_DIR"
  curl -fL --progress-bar -o "$SERVER_DIR/$PKG.tar.gz" "$URL"
  tar -xzf "$SERVER_DIR/$PKG.tar.gz" -C "$SERVER_DIR"
  rm -f "$SERVER_DIR/$PKG.tar.gz"
}

mysql_cmd() { "$BIN/mysql" -uroot -p"$PASSWORD" --socket="$SOCKET" "$@"; }

is_running() { [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; }

import_sql() {
  for f in db/*.sql; do
    echo "Importando $f"
    mysql_cmd < "$f"
  done
}

start() {
  ensure_mysql
  if is_running; then echo "Ya esta en marcha"; return; fi

  local first_run=0
  if [ ! -d "$DATADIR/mysql" ]; then
    first_run=1
    echo "Inicializando datos en $DATADIR"
    "$BIN/mysqld" --initialize-insecure --datadir="$DATADIR" >"$LOGFILE" 2>&1
  fi

  # mysql_native_password: necesario para el driver mysql-connector-java 5.1.47
  nohup "$BIN/mysqld" --datadir="$DATADIR" --port="$PORT" --socket="$SOCKET" \
    --mysqlx=OFF --bind-address=127.0.0.1 --mysql-native-password=ON \
    --pid-file="$PIDFILE" >>"$LOGFILE" 2>&1 &

  echo -n "Esperando a MySQL"
  for _ in $(seq 1 30); do
    "$BIN/mysqladmin" -uroot --socket="$SOCKET" ping --silent >/dev/null 2>&1 && break
    "$BIN/mysqladmin" -uroot -p"$PASSWORD" --socket="$SOCKET" ping --silent >/dev/null 2>&1 && break
    echo -n "."; sleep 1
  done
  echo

  if [ "$first_run" = 1 ]; then
    "$BIN/mysql" -uroot --socket="$SOCKET" -e \
      "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$PASSWORD';
       CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY '$PASSWORD';
       GRANT ALL ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    import_sql
  fi
  echo "Listo -> jdbc:mysql://localhost:$PORT/  usuario: root  password: $PASSWORD"
}

stop() {
  ensure_mysql
  if is_running; then
    "$BIN/mysqladmin" -uroot -p"$PASSWORD" --socket="$SOCKET" shutdown && echo "Parado"
  else
    echo "No estaba en marcha"
  fi
}

case "${1:-start}" in
  start)  start ;;
  stop)   stop ;;
  reset)  stop || true; rm -rf "$DATADIR"; start ;;
  status) if is_running; then echo "En marcha (pid $(cat "$PIDFILE"))"; else echo "Parado"; fi ;;
  shell)  ensure_mysql; mysql_cmd ;;
  *) echo "Uso: $0 [start|stop|reset|status|shell]"; exit 1 ;;
esac
