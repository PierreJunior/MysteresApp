package com.kalani.rosary;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.applovin.sdk.AppLovinPrivacySettings;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL =
            "com.kalani.rosary/mediation-channel";
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // Set up a method channel for calling APIs in the AppLovin SDK.
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            switch (call.method) {
                                case "setIsAgeRestrictedUser":
                                    AppLovinPrivacySettings.setIsAgeRestrictedUser(call.argument("isAgeRestricted"), context);
                                    result.success(null);
                                    break;
                                case "setHasUserConsent":
                                    AppLovinPrivacySettings.setHasUserConsent(call.argument("hasUserConsent"), context);
                                    result.success(null);
                                    break;
                                default:
                                    result.notImplemented();
                                    break;
                            }
                        }
                );
    }
}
