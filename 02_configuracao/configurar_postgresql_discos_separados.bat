@echo off
:: ============================================================
:: SCRIPT COMPLETO - SEPARAÇÃO DE DADOS E LOGS (WAL)
:: PostgreSQL 18 - Grupo A - CV-SpaceNet
:: Autor: Admirson
:: ============================================================

echo ============================================================
echo      CONFIGURACAO DO POSTGRESQL 18 - SEPARAR DADOS E LOGS
echo ============================================================

:: Verificar se está como Administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Este script deve ser executado como ADMINISTRADOR!
    pause
    exit /b 1
)

echo.
echo [1/10] Parando o serviço PostgreSQL...
net stop postgresql-18

echo.
echo [2/10] Criando diretórios nos discos E: e F: ...
mkdir "E:\PostgreSQL\Data"
mkdir "F:\PostgreSQL\WAL"

echo.
echo [3/10] Copiando DATA DIRECTORY para E:\PostgreSQL\Data ...
robocopy "C:\Program Files\PostgreSQL\18\data" "E:\PostgreSQL\Data" /E /COPY:DAT

echo.
echo [4/10] Movendo WAL para F:\PostgreSQL\WAL ...
move "E:\PostgreSQL\Data\pg_wal" "F:\PostgreSQL\WAL"

echo.
echo [5/10] Criando JUNCTION POINT para pg_wal ...
cmd /c mklink /J "E:\PostgreSQL\Data\pg_wal" "F:\PostgreSQL\WAL"

echo.
echo [6/10] Ajustando permissões NTFS para o serviço PostgreSQL...
set svc=NT AUTHORITY\NETWORK SERVICE
icacls "E:\PostgreSQL" /grant "%svc%":F /T
icacls "F:\PostgreSQL" /grant "%svc%":F /T

echo.
echo [7/10] Backup dos arquivos de configuracao...
copy "C:\Program Files\PostgreSQL\18\data\postgresql.conf" "C:\Program Files\PostgreSQL\18\data\postgresql.conf.bak"
copy "C:\Program Files\PostgreSQL\18\data\pg_hba.conf" "C:\Program Files\PostgreSQL\18\data\pg_hba.conf.bak"

echo.
echo [8/10] Atualizando postgresql.conf para novo DATA DIRECTORY...
powershell -Command ^
"(Get-Content 'C:\Program Files\PostgreSQL\18\data\postgresql.conf') ^
-replace 'data_directory = .*', 'data_directory = ''E:/PostgreSQL/Data''' ^
| Set-Content 'C:\Program Files\PostgreSQL\18\data\postgresql.conf'"

echo.
echo [9/10] Iniciando o serviço PostgreSQL...
net start postgresql-18

echo.
echo [10/10] Validando configuracoes...
"C:\Program Files\PostgreSQL\18\bin\psql" -U postgres -p 5433 -c "SHOW data_directory;"
"C:\Program Files\PostgreSQL\18\bin\psql" -U postgres -p 5433 -c "SELECT pg_ls_dir('pg_wal');"

echo ============================================================
echo CONFIGURACAO CONCLUIDA COM SUCESSO!
echo Dados -> E:\PostgreSQL\Data
echo Logs/WAL -> F:\PostgreSQL\WAL
echo ============================================================
pause
