plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // تأكد أن هذا الاسم يطابق معرف تطبيقك في المشروع
    namespace = "com.example.luqta_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // تم التحديث إلى Java 17 ليتوافق مع مكتبة image_cropper الحديثة
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // تم التحديث إلى JVM 17
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // معرف التطبيق الفريد
        applicationId = "com.example.luqta_app"

        // يعتمد على إعدادات فلاتر الافتراضية
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // إعدادات التوقيع لنسخة الـ Release
            signingConfig = signingConfigs.getByName("debug")

            // تحسين الكود وتقليل الحجم (اختياري)
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // يمكنك إضافة مكتبات أندرويد الأصلية هنا إذا احتجت مستقبلاً
    implementation("androidx.multidex:multidex:2.0.1")
}