plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.vikrasoftech.sayhello"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    packaging {
        resources {
            // Fix duplicate native libraries between agora_rtm and agora_rtc_engine
            pickFirst("lib/arm64-v8a/libaosl.so")
            pickFirst("lib/armeabi-v7a/libaosl.so")
            pickFirst("lib/x86_64/libaosl.so")
            pickFirst("lib/x86/libaosl.so")
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.vikrasoftech.sayhello"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24  // Agora SDK 6.x requires minSdk 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // Enable multidex for large apps
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            
            // Enable code shrinking and obfuscation
            isMinifyEnabled = true
            isShrinkResources = true  // Remove unused resources
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Strip native debug symbols completely for smaller APK
            ndk {
                debugSymbolLevel = "NONE"
            }
        }
        
        debug {
            // No minification or splits for debug builds
            isMinifyEnabled = false
        }
    }
    
    // Add optimization configurations
    buildFeatures {
        buildConfig = true
    }
}

// Only split APKs for release builds (not debug)
// This is handled automatically by the --split-per-abi flag
// Comment out the splits block to avoid conflicts with debug builds
/*
splits {
    abi {
        isEnable = true
        reset()
        include("armeabi-v7a", "arm64-v8a", "x86_64")
        isUniversalApk = false
    }
}
*/

flutter {
    source = "../.."
}
