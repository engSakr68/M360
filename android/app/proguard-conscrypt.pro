###############################################################################
# Conscrypt references two internal socket-impl classes that are provided by
# the Android framework at runtime but are NOT present in your app’s  DEX.
# We simply ask R8 to keep the symbols and stop analysing them.
###############################################################################

# new(er) Android stacks (KitKat+)
-keep class com.android.org.conscrypt.SSLParametersImpl { *; }

# very old pre-KitKat stacks (harmony)
-keep class org.apache.harmony.xnet.provider.jsse.SSLParametersImpl { *; }

# …and don’t waste time/warnings trying to trace them
-dontwarn com.android.org.conscrypt.**
-dontwarn org.apache.harmony.xnet.provider.jsse.**
