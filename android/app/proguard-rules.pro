#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# ISW classes
-keep public class com.interswitchng.iswmobilesdk.IswMobileSdk {
    public protected *;
}

-keep public interface com.interswitchng.iswmobilesdk.IswMobileSdk$IswPaymentCallback {*;}

-keep public class com.interswitchng.iswmobilesdk.shared.models.core.** {
    public protected *;
    !transient <fields>;
}
-keep public class com.interswitchng.iswmobilesdk.shared.models.payment.** {
    public protected *;
    !transient <fields>;
}

# SC provider
-keep class org.spongycastle.**
-dontwarn org.spongycastle.jce.provider.X509LDAPCertStoreSpi
-dontwarn org.spongycastle.x509.util.LDAPStoreHelper