#!/bin/bash

# Optimized APK Build Script
# This script builds split APKs - one for each architecture
# Each APK is ~60-80MB instead of 270MB universal APK

echo "🚀 Building optimized split APKs..."
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
flutter pub get

echo ""
echo "🔨 Building split release APKs with optimizations..."
echo ""
echo "Optimizations applied:"
echo "  ✅ Split per ABI (3 separate APKs)"
echo "  ✅ Code minification (ProGuard)"
echo "  ✅ Resource shrinking"
echo "  ✅ Tree shaking (unused code removal)"
echo "  ✅ Debug symbols stripped"
echo "  ✅ Obfuscation enabled"
echo ""

# Build with all optimizations and ABI split
flutter build apk \
  --release \
  --split-per-abi \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols

echo ""
echo "✅ Build complete!"
echo ""

# Show APK locations and sizes
echo "📦 Generated APKs:"
echo ""

APK_DIR="build/app/outputs/flutter-apk"

if [ -f "$APK_DIR/app-armeabi-v7a-release.apk" ]; then
    SIZE=$(du -h "$APK_DIR/app-armeabi-v7a-release.apk" | cut -f1)
    echo "  📱 armeabi-v7a (32-bit, older devices): $SIZE"
fi

if [ -f "$APK_DIR/app-arm64-v8a-release.apk" ]; then
    SIZE=$(du -h "$APK_DIR/app-arm64-v8a-release.apk" | cut -f1)
    echo "  � arm64-v8a (64-bit, modern devices): $SIZE ⭐ RECOMMENDED"
fi

if [ -f "$APK_DIR/app-x86_64-release.apk" ]; then
    SIZE=$(du -h "$APK_DIR/app-x86_64-release.apk" | cut -f1)
    echo "  � x86_64 (emulators): $SIZE"
fi

echo ""
echo "💡 Tips:"
echo "  - Distribute arm64-v8a APK for 95% of users (modern devices)"
echo "  - Keep armeabi-v7a for older devices if needed"
echo "  - Each user only needs ONE APK for their device"
echo ""
echo "📲 Install command:"
echo "  adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"

