import pyodbc

# Configuração de conexão (ajuste conforme necessário)
SERVER = "localhost"
PORT = 50484  # porta alterada conforme informado
DATABASE = "postgres"
UID = "postgres"
PWD = "********"

def try_pyodbc_connect():
    drivers = pyodbc.drivers()
    # tenta encontrar um driver PostgreSQL instalado
    candidate = None
    for d in drivers:
        if "postgre" in d.lower() or "psql" in d.lower():
            candidate = d
            break

    if not candidate:
        raise RuntimeError(
            "Nenhum driver ODBC PostgreSQL encontrado. Instale o driver ODBC para PostgreSQL ou use psycopg2."
        )

    driver_braced = "{" + candidate + "}"
    conn_str = (
        f"DRIVER={driver_braced};SERVER={SERVER};PORT={PORT};"
        f"DATABASE={DATABASE};UID={UID};PWD={PWD};"
    )
    print(f"Tentando conectar via ODBC -> {SERVER}:{PORT} database={DATABASE} (driver={candidate})")
    return pyodbc.connect(conn_str, timeout=5)

def try_psycopg2_connect():
    try:
        import psycopg2
    except Exception as e:
        raise RuntimeError("psycopg2 não está instalado.") from e

    print(f"Tentando conectar via psycopg2 -> {SERVER}:{PORT} database={DATABASE}")
    conn = psycopg2.connect(host=SERVER, port=PORT, dbname=DATABASE, user=UID, password=PWD, connect_timeout=5)
    return conn


def main():
    conn = None
    used = None
    try:
        try:
            conn = try_pyodbc_connect()
            used = "pyodbc"
        except Exception as e_pyodbc:
            print("pyodbc falhou:", e_pyodbc)
            try:
                conn = try_psycopg2_connect()
                used = "psycopg2"
            except Exception as e_psycopg2:
                print("psycopg2 falhou:", e_psycopg2)
                raise RuntimeError(
                    "Não foi possível conectar. Instale um driver ODBC PostgreSQL ou psycopg2 e verifique credenciais/porta."
                )

        if used == "pyodbc":
            cursor = conn.cursor()
            cursor.execute("SELECT version();")
            ver = cursor.fetchone()
            print("Servidor:", ver[0] if ver else ver)

            for tabela in ("Usuario", "satelite"):
                try:
                    print(f"\nConsultando tabela: {tabela}")
                    cursor.execute(f"SELECT * FROM {tabela} LIMIT 20;")
                    rows = cursor.fetchall()
                    print(f"Registros retornados: {len(rows)}")
                    for r in rows:
                        print(r)
                except Exception as qt:
                    print(f"Erro ao consultar {tabela}:", qt)

        else:  # psycopg2
            cur = conn.cursor()
            cur.execute("SELECT version();")
            ver = cur.fetchone()
            print("Servidor:", ver[0] if ver else ver)

            for tabela in ("Usuario", "satelite"):
                try:
                    print(f"\nConsultando tabela: {tabela}")
                    cur.execute(f"SELECT * FROM {tabela} LIMIT 20;")
                    rows = cur.fetchall()
                    print(f"Registros retornados: {len(rows)}")
                    for r in rows:
                        print(r)
                except Exception as qt:
                    print(f"Erro ao consultar {tabela}:", qt)

    except Exception as e:
        print("Falha na conexão:", e)
    finally:
        if conn:
            try:
                conn.close()
            except Exception:
                pass
            print("Conexão fechada")


if __name__ == "__main__":
    main()
