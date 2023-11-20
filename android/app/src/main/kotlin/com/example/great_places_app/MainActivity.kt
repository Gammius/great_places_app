package com.example.great_places_app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("Ru_ru")
        MapKitFactory.setApiKey("f6467aeb-0ccd-4720-a96a-a861b009d1cd")
        super.configureFlutterEngine(flutterEngine)
    }
}