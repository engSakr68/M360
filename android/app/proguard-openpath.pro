############################# Openpath ##################################
-keep class at.favre.lib.crypto.bcrypt.** { *; }

# AWS logs SDK uses reflection / Gson
-keep class com.amazonaws.** { *; }
-dontwarn com.amazonaws.**

# Google LocationClient & LocationRequest
-keep class com.google.android.gms.location.** { *; }
-dontwarn com.google.android.gms.location.**

# TrueTime reflection
-keep class com.instacart.library.truetime.** { *; }

# Nordic BLE (they use annotations + reflection)
-keep class no.nordicsemi.android.** { *; }
-dontwarn no.nordicsemi.android.**

-keep class com.openpath.mobileaccesscore.** { *; }
-dontwarn com.openpath.mobileaccesscore.**

# SpongyCastle LDAP helper pulls in javax.naming
-dontwarn javax.naming.**
#######################################################################
