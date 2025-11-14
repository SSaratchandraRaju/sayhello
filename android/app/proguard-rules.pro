# Agora RTC Engine ProGuard rules
-keep class io.agora.**{*;}
-dontwarn io.agora.**

# Agora Video SDK
-keep class io.agora.rtc.** { *; }
-keep class io.agora.rtc2.** { *; }
-keep class io.agora.base.** { *; }

# WebRTC
-keep class org.webrtc.** { *; }
-dontwarn org.webrtc.**
