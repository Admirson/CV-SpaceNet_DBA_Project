@echo off
setlocal enabledelayedexpansion

:: Configurações
set PATH=C:\Program Files\PostgreSQL\18\bin;%PATH%
set PGPASSWORD=Grupo_A@2026F
set DB_USER=postgres
set DB_PORT=50484
set LOG_DIR=F:\PostgreSQL\Log_BCK

:: Criar diretório de log se não existir
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

:: Perguntar ao usuário qual arquivo de backup usar
echo Digite o caminho completo do arquivo .dump para restaurar:
set /p BACKUP_FILE=Arquivo: 

:: Perguntar ao usuário o nome da base de dados onde restaurar
echo Digite o nome da base de dados de destino:
set /p DB_NAME=Base: 

:: Log inicio
echo %DATE% %TIME% - Iniciando restauração na base %DB_NAME% >> "%LOG_DIR%\restore.log"

:: Criar base de destino (se não existir)
createdb -U %DB_USER% -p %DB_PORT% %DB_NAME% >> "%LOG_DIR%\restore.log" 2>&1

:: Restaurar backup selecionado pelo usuário
pg_restore -U %DB_USER% -p %DB_PORT% -d %DB_NAME% -v "%BACKUP_FILE%" >> "%LOG_DIR%\restore.log" 2>&1

:: Verificar sucesso
if %ERRORLEVEL% EQU 0 (
    echo %DATE% %TIME% - Restauração concluída com sucesso na base %DB_NAME% >> "%LOG_DIR%\restore.log"
) else (
    echo %DATE% %TIME% - ERRO na restauração! Código: %ERRORLEVEL% >> "%LOG_DIR%\restore.log"
)

:: Limpeza
set PGPASSWORD=
