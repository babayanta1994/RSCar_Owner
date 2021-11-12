import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'internal/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'),
      ],
      home: App(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
