@echo off
REM Script to fix ESP-IDF Python environment paths for multi-version setup
REM This script ensures each ESP-IDF version has its Python environment in the expected location
REM
REM PROBLEM:
REM - ESP-IDF install.bat installs Python envs to C:\Users\seand\.espressif\python_env\idfX.X_py3.12_env
REM - But export.bat expects them at C:\Espressif\tools\python\vX.X\venv
REM - This causes activation failures when running multiple ESP-IDF versions
REM
REM SOLUTION:
REM - Create junctions (directory symlinks) from expected paths to actual paths
REM - Each ESP-IDF version maintains its own isolated Python environment
REM - Multiple terminals can activate different ESP-IDF versions without conflicts

echo Fixing ESP-IDF Python environment paths for multi-version setup...
echo(

REM Fix v5.5.4
echo Checking ESP-IDF v5.5.4 Python environment...
if not exist "C:\Espressif\tools\python\v5.5.4" (
    echo Creating C:\Espressif\tools\python\v5.5.4
    mkdir "C:\Espressif\tools\python\v5.5.4"
)

if exist "C:\Espressif\tools\python\v5.5.4\venv" (
    echo Removing existing v5.5.4\venv
    rmdir /S /Q "C:\Espressif\tools\python\v5.5.4\venv" 2>nul
    if exist "C:\Espressif\tools\python\v5.5.4\venv" (
        echo Using junction removal for v5.5.4\venv
        rmdir "C:\Espressif\tools\python\v5.5.4\venv"
    )
)

if exist "C:\Users\seand\.espressif\python_env\idf5.5_py3.12_env" (
    echo Creating junction for v5.5.4 Python environment
    mklink /J "C:\Espressif\tools\python\v5.5.4\venv" "C:\Users\seand\.espressif\python_env\idf5.5_py3.12_env" >nul
    if exist "C:\Espressif\tools\python\v5.5.4\venv" (
        echo [OK] v5.5.4 Python environment junction created
    ) else (
        echo [WARN] Failed to create junction for v5.5.4
    )
) else (
    echo [WARN] v5.5.4 Python environment not found at expected location
)

echo(

REM Fix v6.0.1
echo Checking ESP-IDF v6.0.1 Python environment...
if not exist "C:\Espressif\tools\python\v6.0.1" (
    echo Creating C:\Espressif\tools\python\v6.0.1
    mkdir "C:\Espressif\tools\python\v6.0.1"
)

if exist "C:\Espressif\tools\python\v6.0.1\venv" (
    echo Removing existing v6.0.1\venv
    rmdir /S /Q "C:\Espressif\tools\python\v6.0.1\venv" 2>nul
    if exist "C:\Espressif\tools\python\v6.0.1\venv" (
        echo Using junction removal for v6.0.1\venv
        rmdir "C:\Espressif\tools\python\v6.0.1\venv"
    )
)

if exist "C:\Users\seand\.espressif\python_env\idf6.0_py3.12_env" (
    echo Creating junction for v6.0.1 Python environment
    mklink /J "C:\Espressif\tools\python\v6.0.1\venv" "C:\Users\seand\.espressif\python_env\idf6.0_py3.12_env" >nul
    if exist "C:\Espressif\tools\python\v6.0.1\venv" (
        echo [OK] v6.0.1 Python environment junction created
    ) else (
        echo [WARN] Failed to create junction for v6.0.1
    )
) else (
    echo [WARN] v6.0.1 Python environment not found at expected location
)

echo(
echo ============================================================
echo Python environment paths fixed.
echo(
echo You can now activate ESP-IDF versions in separate terminals:
echo(
echo   Terminal 1 (v5.5.4):
echo     C:\esp\v5.5.4\esp-idf\export.bat
echo(
echo   Terminal 2 (v6.0.1):
echo     C:\esp\v6.0.1\esp-idf\export.bat
echo(
echo Each version uses its own isolated Python environment.
echo ============================================================
pause

