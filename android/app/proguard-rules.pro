# -------------------------------
# Flutter & Dart Essential Rules
# -------------------------------
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.**

# Keep Flutter engine native methods
-keepclassmembers class * {
    @io.flutter.embedding.engine.dart.DartEntrypoint *;
}

# -------------------------------
# Firebase & Google Services
# -------------------------------
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Crashlytics
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# -------------------------------
# Dependency Injection (GetIt)
# -------------------------------
-keep class * {
    @injectable.annotation.* *;
}
-keepclassmembers class * {
    @injectable.annotation.* *;
}

# -------------------------------
# JSON Serialization
# -------------------------------
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
-keep,allowobfuscation @interface com.google.gson.annotations.SerializedName

# Keep JSON annotation classes
-keep class * {
    @json_annotation.JsonSerializable *;
}
-keep class * {
    @json_annotation.JsonKey *;
}

# -------------------------------
# OpenPath SDK ProGuard / R8 Rules
# -------------------------------

# Keep all classes and methods from OpenPath SDK
-keep class com.openpath.** { *; }

# Optional: Keep any other related services/libraries in your app
-keep class com.paychoice.** { *; }
-keep class com.system.** { *; }

# OpenPath SDK dependencies
-keep class org.spongycastle.** { *; }
-keep class org.bouncycastle.** { *; }
-keep class org.eclipse.paho.** { *; }

-dontwarn org.bouncycastle.**
-dontwarn org.eclipse.paho.**
-dontwarn javax.mail.**
-dontwarn java.lang.management.**
-dontwarn javax.activation.**
-dontwarn javax.xml.stream.**
-dontwarn org.apache.tika.**
-dontwarn com.michaelflisar.lumberjack.**

# android-jwt
-keep class com.auth0.android.jwt.** { *; }
-keep class org.spongycastle.** { *; }

# Keep specific members in Openpath core
-keepclassmembers class com.openpath.mobileaccesscore.OpenpathMobileAccessCore {
    private static void setSdkEventListener(...);
}

# Keep OpenPath public APIs and models
-keep class com.openpath.** { *; }
-dontwarn com.openpath.**
-keep class com.openpath.mobileaccesscore.** { *; }
-keep class com.openpath.mobileaccesssdk.** { *; }
-dontwarn com.openpath.mobileaccesscore.**

# Conscrypt (if present)
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**

# -------------------------------
# Networking & HTTP
# -------------------------------
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }
-dontwarn okhttp3.**
-dontwarn retrofit2.**

# -------------------------------
# Kotlin & Coroutines
# -------------------------------
-keep class kotlin.** { *; }
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.coroutines.**

# -------------------------------
# Your App Models & Data Classes
# -------------------------------
# Keep all your data models (adjust package name as needed)
-keep class com.PayChoice.Member360.** { *; }

# Keep Freezed generated classes
-keep class * {
    @freezed.annotation.* *;
}

# Keep BLoC classes
-keep class * extends bloc.BlocBase { *; }
-keep class * extends flutter_bloc.Cubit { *; }
