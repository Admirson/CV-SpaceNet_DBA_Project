@echo off
setlocal enabledelayedexpansion

:: Configurações
set PATH=C:\Program Files\PostgreSQL\18\bin;%PATH%
set PGPASSWORD=Grupo_A@2026F
set BACKUP_DIR=E:\
set LOG_DIR=F:\PostgreSQL\Log_BCK
set DB_NAME=cv_spacenet
set DB_USER=postgres
set DB_PORT=50484
set DATE=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%

:: Corrigir TIME (remover espaços)
set HOUR=%TIME:~0,2%
if "%HOUR:~0,1%"==" " set HOUR=0%HOUR:~1,1%
set MINUTE=%TIME:~3,2%
set SECOND=%TIME:~6,2%
set TIME=%HOUR%%MINUTE%%SECOND%

set BACKUP_FILE=%BACKUP_DIR%\backup_%DB_NAME%_%DATE%_%TIME%.dump

:: Criar diretórios se não existirem
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

:: Log inicio
echo %DATE% %TIME% - Iniciando backup >> "%LOG_DIR%\backup.log"

:: Executar backup com saída detalhada no log
pg_dump -U %DB_USER% -p %DB_PORT% -F c -b -v -f "%BACKUP_FILE%" %DB_NAME% >> "%LOG_DIR%\backup.log" 2>&1

:: Verificar sucesso
if %ERRORLEVEL% EQU 0 (
    echo %DATE% %TIME% - Backup concluído: %BACKUP_FILE% >> "%LOG_DIR%\backup.log"
    for %%A in ("%BACKUP_FILE%") do echo %DATE% %TIME% - Tamanho: %%~zA bytes >> "%LOG_DIR%\backup.log"
    forfiles /p "%BACKUP_DIR%" /m "backup_*.dump" /d -7 /c "cmd /c del @file"
) else (
    echo %DATE% %TIME% - ERRO no backup! Código: %ERRORLEVEL% >> "%LOG_DIR%\backup.log"
)

:: Limpeza
set PGPASSWORD=
