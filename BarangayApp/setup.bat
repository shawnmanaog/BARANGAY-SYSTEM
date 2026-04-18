@echo off
REM Barangay System - Automated Setup Script
REM This script sets up and runs the Flutter application

echo.
echo ========================================
echo Barangay Management System Setup
echo ========================================
echo.

REM Check if Flutter is installed
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Flutter is not installed or not in PATH
    echo.
    echo Please install Flutter from: https://flutter.dev/docs/get-started/install
    echo.
    pause
    exit /b 1
)

REM Navigate to project directory
cd /d "%~dp0"

echo [1/4] Checking Flutter version...
flutter --version
echo.

echo [2/4] Getting dependencies...
call flutter pub get
if errorlevel 1 (
    echo ERROR: Failed to get dependencies
    pause
    exit /b 1
)
echo Dependencies downloaded successfully!
echo.

echo [3/4] Running Flutter analysis...
call flutter analyze
echo.

echo [4/4] Starting the application...
echo.
echo Choose your platform:
echo 1) Android (default)
echo 2) iOS
echo 3) Web
echo 4) Windows
echo 5) Exit
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" (
    echo Starting on Android...
    call flutter run
) else if "%choice%"=="2" (
    echo Starting on iOS...
    call flutter run -d ios
) else if "%choice%"=="3" (
    echo Starting on Web...
    call flutter run -d chrome
) else if "%choice%"=="4" (
    echo Starting on Windows...
    call flutter run -d windows
) else if "%choice%"=="5" (
    echo Exiting...
    exit /b 0
) else (
    echo Invalid choice. Starting on Android (default)...
    call flutter run
)

pause
