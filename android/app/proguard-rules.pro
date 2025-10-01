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

# (Optional) If your build minifies Kotlin stdlib/OkHttp/Gson/JSONObject, keep these
# -keep class kotlin.** { *; }
# -keep class okhttp3.** { *; }
# -keep class org.json.** { *; }
