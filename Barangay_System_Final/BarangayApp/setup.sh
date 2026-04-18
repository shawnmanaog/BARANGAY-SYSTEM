#!/bin/bash

# Barangay System - Automated Setup Script for macOS/Linux

echo ""
echo "========================================"
echo "Barangay Management System Setup"
echo "========================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "ERROR: Flutter is not installed or not in PATH"
    echo ""
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    echo ""
    exit 1
fi

# Navigate to project directory
cd "$(dirname "$0")"

echo "[1/4] Checking Flutter version..."
flutter --version
echo ""

echo "[2/4] Getting dependencies..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to get dependencies"
    exit 1
fi
echo "Dependencies downloaded successfully!"
echo ""

echo "[3/4] Running Flutter analysis..."
flutter analyze
echo ""

echo "[4/4] Starting the application..."
echo ""
echo "Choose your platform:"
echo "1) Android (default)"
echo "2) iOS"
echo "3) Web"
echo "4) macOS"
echo "5) Exit"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo "Starting on Android..."
        flutter run
        ;;
    2)
        echo "Starting on iOS..."
        flutter run -d ios
        ;;
    3)
        echo "Starting on Web..."
        flutter run -d chrome
        ;;
    4)
        echo "Starting on macOS..."
        flutter run -d macos
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Starting on Android (default)..."
        flutter run
        ;;
esac
