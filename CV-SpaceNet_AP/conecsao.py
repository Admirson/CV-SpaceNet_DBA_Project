import pyodbc

# Conexão usando DSN configurado
conn = pyodbc.connect("DSN=PostgreSQL35W;UID=postgres;PWD=FzSecret@24")

cursor = conn.cursor()
cursor.execute("SELECT version();")

for row in cursor.fetchall():
    print(row)

conn.close()
# alteração for Gilson
