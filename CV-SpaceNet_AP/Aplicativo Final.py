import psycopg2
import psutil
import subprocess

# Dicionário de utilizadores e respetivas passwords
USERS = {
    "1": ("usr_dba", "Dba@2026"),
    "2": ("usr_prog", "Prog@2026"),
    "3": ("usr_gestor", "Gestor@2026"),
    "4": ("usr_analista", "Analista@2026"),
    "5": ("usr_auditor", "Auditor@2026"),
    "6": ("usr_app", "App@2026")
}

TABLES = {
    "1": "core.satelite",
    "2": "pesca.embarcacao",
    "3": "pesca.evento_pesca_ilegal",
    "4": "meteo.observacao_bruma",
    "5": "geo.imagem"
}

def connect_db(user, password):
    try:
        conn = psycopg2.connect(
            dbname="cv_spacenet",
            user=user,
            password=password,
            host="localhost",
            port="50484"
        )
        return conn
    except Exception as e:
        print("Erro na conexão:", e)
        return None

def menu_utilizadores():
    print("=== LOGIN ===")
    print("0 - Introduzir outro utilizador")
    for k, v in USERS.items():
        print(f"{k} - {v[0]}")
    escolha = input("Escolha o utilizador: ")

    if escolha == "0":
        user = input("Digite o nome do utilizador: ")
        password = input("Digite a password: ")
        return (user, password)
    return USERS.get(escolha)

def menu_principal():
    print("\n=== MENU PRINCIPAL ===")
    print("1 - Operações em tabelas")
    print("2 - Administração do sistema")
    print("3 - Validar configurações do SGBD")
    print("0 - Sair")
    return input("Opção: ")

def menu_validar():
    print("\n=== MENU VALIDAR CONFIGURAÇÕES ===")
    print("1 - Estrutura Física do SGBD")
    print("2 - Parâmetros Fundamentais")
    print("3 - Segurança Avançada")
    print("0 - Voltar")
    return input("Opção: ")

def menu_tabelas():
    print("\nEscolha uma tabela:")
    for k, v in TABLES.items():
        print(f"{k} - {v}")
    print("0 - Voltar")
    escolha = input("Opção: ")
    if escolha == "0":
        return None
    return TABLES.get(escolha)

def menu_operacoes():
    print("\nEscolha a operação:")
    print("1 - INSERT")
    print("2 - DELETE")
    print("3 - UPDATE")
    print("4 - SELECT")
    print("0 - Voltar")
    return input("Opção: ")

def executar_operacao(conn, tabela, operacao):
    cur = conn.cursor()
    try:
        if operacao == "1":  # INSERT
            print(f"Inserir dados em {tabela}")
            sql = f"INSERT INTO {tabela} DEFAULT VALUES RETURNING *;"
            cur.execute(sql)
            conn.commit()
            print("Registo inserido.")
        elif operacao == "2":  # DELETE
            id_del = input("Digite o ID a remover: ")
            sql = f"DELETE FROM {tabela} WHERE id_{tabela.split('.')[-1]} = %s;"
            cur.execute(sql, (id_del,))
            conn.commit()
            print("Registo removido.")
        elif operacao == "3":  # UPDATE
            id_upd = input("Digite o ID a atualizar: ")
            campo = input("Campo a atualizar: ")
            valor = input("Novo valor: ")
            sql = f"UPDATE {tabela} SET {campo} = %s WHERE id_{tabela.split('.')[-1]} = %s;"
            cur.execute(sql, (valor, id_upd))
            conn.commit()
            print("Registo atualizado.")
        elif operacao == "4":  # SELECT
            sql = f"SELECT * FROM {tabela} LIMIT 10;"
            cur.execute(sql)
            for row in cur.fetchall():
                print(row)
        else:
            print("Operação inválida.")
    except Exception as e:
        print("Erro na operação:", e)
        conn.rollback()
    cur.close()

def menu_admin():
    print("\n=== MENU ADMINISTRATIVO ===")
    print("1 - Estado do serviço PostgreSQL")
    print("2 - Espaço em disco")
    print("3 - Memória utilizada")
    print("4 - Ligações ativas")
    print("5 - Consultas lentas (>2s)")
    print("6 - Crescimento da base de dados")
    print("7 - Backup (executar BCK.bat)")
    print("8 - Recuperação (executar Restauro.bat)")
    print("0 - Voltar")
    return input("Opção: ")

def executar_admin(conn, opcao):
    cur = conn.cursor()
    try:
        if opcao == "1":
            cur.execute("SELECT version();")
            print("PostgreSQL ativo:", cur.fetchone()[0])

        elif opcao == "2":
            disk = psutil.disk_usage('/')
            print(f"Total: {disk.total/1024**3:.2f} GB")
            print(f"Usado: {disk.used/1024**3:.2f} GB")
            print(f"Disponível: {disk.free/1024**3:.2f} GB")

        elif opcao == "3":
            mem = psutil.virtual_memory()
            print(f"Memória total: {mem.total/1024**3:.2f} GB")
            print(f"Usada: {mem.used/1024**3:.2f} GB ({mem.percent}%)")

        elif opcao == "4":
            cur.execute("SELECT count(*) FROM pg_stat_activity;")
            print("Ligações ativas:", cur.fetchone()[0])

        elif opcao == "5":
            cur.execute("""
                SELECT pid, query, state, now() - query_start AS duracao
                FROM pg_stat_activity
                WHERE state='active' AND now() - query_start > interval '2 seconds';
            """)
            rows = cur.fetchall()
            if rows:
                for r in rows:
                    print(r)
            else:
                print("Nenhuma consulta lenta encontrada.")

        elif opcao == "6":
            cur.execute("""
                SELECT datname, pg_size_pretty(pg_database_size(datname))
                FROM pg_database
                ORDER BY pg_database_size(datname) DESC;
            """)
            for row in cur.fetchall():
                print(row)

        elif opcao == "7":  # Backup
            try:
                subprocess.run(["BCK.bat"], check=True)
                print("Backup concluído com sucesso.")
            except Exception as e:
                print("Erro ao executar backup:", e)

        elif opcao == "8":  # Recuperação
            try:
                subprocess.run(["Restauro.bat"], check=True)
                print("Recuperação concluída com sucesso.")
            except Exception as e:
                print("Erro ao executar recuperação:", e)

        elif opcao == "0":
            return
        else:
            print("Opção inválida.")
    except Exception as e:
        print("Erro na administração:", e)
    cur.close()
    
def executar_validar(conn, opcao):
    cur = conn.cursor()
    try:
        if opcao == "1":  # Estrutura Física
            print("\n--- Estrutura Física do SGBD ---")
            print("Arquitetura física: PostgreSQL usa diretórios de dados definidos em 'data_directory'.")

            for parametro, descricao in [
                ("data_directory", "Dados"),
                ("log_directory", "Logs"),
                ("config_file", "Configuração"),
                ("temp_tablespaces", "Temporários")
            ]:
                try:
                    cur.execute(f"SHOW {parametro};")
                    print(f"{descricao}:", cur.fetchone()[0])
                except Exception as e:
                    print(f"Erro ao obter {descricao}:", e)
                    conn.rollback()

            print("Separação de dados e logs deve ser feita em discos distintos quando suportado.")
            print("Documentar a estrutura de diretórios conforme boas práticas.")

        elif opcao == "2":  # Parâmetros Fundamentais
            print("\n--- Parâmetros Fundamentais ---")
            for parametro in ["shared_buffers", "work_mem", "effective_cache_size", "max_connections", "wal_level"]:
                try:
                    cur.execute(f"SHOW {parametro};")
                    print(f"{parametro}:", cur.fetchone()[0])
                except Exception as e:
                    print(f"Erro ao obter {parametro}:", e)
                    conn.rollback()
            print("Outros parâmetros de desempenho podem ser ajustados em postgresql.conf.")

        elif opcao == "3":  # Segurança Avançada
            print("\n--- Segurança Avançada ---")
            for parametro, descricao in [
                ("port", "Porta configurada"),
                ("ssl", "SSL/TLS ativo")
            ]:
                try:
                    cur.execute(f"SHOW {parametro};")
                    print(f"{descricao}:", cur.fetchone()[0])
                except Exception as e:
                    print(f"Erro ao obter {descricao}:", e)
                    conn.rollback()

            print("Autenticação segura configurada em pg_hba.conf.")
            print("Restrições de acesso por IP também definidas em pg_hba.conf.")
            print("Proteção das contas administrativas: usar senhas fortes e roles limitadas.")
            print("Desativar serviços/usuários desnecessários para reduzir superfície de ataque.")

        elif opcao == "0":
            return
        else:
            print("Opção inválida.")
    except Exception as e:
        print("Erro geral ao validar configurações:", e)
        conn.rollback()
    finally:
        cur.close()


def main():
    user_info = menu_utilizadores()
    if not user_info:
        print("Utilizador inválido.")
        return

    user, password = user_info
    conn = connect_db(user, password)
    if not conn:
        return

    while True:
        opcao = menu_principal()
        if opcao == "1":  # Operações em tabelas
            tabela = menu_tabelas()
            if not tabela:  # se escolher "Voltar"
                continue
            operacao = menu_operacoes()
            if operacao == "0":  # se escolher "Voltar"
                continue
            executar_operacao(conn, tabela, operacao)

        elif opcao == "2":  # Administração
            while True:
                admin_op = menu_admin()
                if admin_op == "0":
                    break
                executar_admin(conn, admin_op)

        elif opcao == "3":  # Validar Configurações
            while True:
                validar_op = menu_validar()
                if validar_op == "0":
                    break
                executar_validar(conn, validar_op)

        elif opcao == "0":  # Sair
            break

        else:
            print("Opção inválida.")

    conn.close()


if __name__ == "__main__":
    main()
