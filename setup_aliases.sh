#!/bin/bash

# Add these aliases to your ~/.zshrc for quick builds

echo "Adding Flutter build aliases to ~/.zshrc..."

# Check if aliases already exist
if grep -q "alias build-apk=" ~/.zshrc 2>/dev/null; then
    echo "Aliases already exist in ~/.zshrc"
else
    # Add aliases to .zshrc
    cat >> ~/.zshrc << 'EOF'

# Flutter Build Aliases for Say Hello App
alias build-apk='flutter build apk --release --split-per-abi'
alias build-aab='flutter build appbundle --release'
alias build-opt='cd ~/StudioProjects/say_hello && ./build_optimized.sh'
alias install-apk='adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk'
EOF

    echo "✅ Aliases added to ~/.zshrc"
    echo ""
    echo "Run: source ~/.zshrc"
    echo ""
    echo "Then you can use:"
    echo "  build-apk     → Build split APKs (98MB)"
    echo "  build-aab     → Build App Bundle (Play Store)"
    echo "  build-opt     → Run optimized build script"
    echo "  install-apk   → Install arm64 APK to device"
fi
