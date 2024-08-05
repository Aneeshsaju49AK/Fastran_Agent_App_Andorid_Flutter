

import 'package:fastran_agent_app_android/export/export.dart';

void main() {
  // Ensure that the app only runs in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fastran Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        // Define common text styles
        // textTheme: const TextTheme(
        //   bodyText1: TextStyle(color: Colors.black, fontSize: 16),
        //   bodyText2: TextStyle(color: Colors.black, fontSize: 14),
        //   headline1: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        //   headline2: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        // ),
        // Define the default scaffold background color
        scaffoldBackgroundColor: Colors.white,
        // Define the default app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white, // Text color
        ),
        // Define the default button styles
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.grey, // Background color
        //     onPrimary: Colors.white, // Text color
        //   ),
        // ),
        // Define the default input decoration theme
        // inputDecorationTheme: const InputDecorationTheme(
        //   filled: true,
        //   fillColor: Colors.white,
        //   border: OutlineInputBorder(),
        //   focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.grey),
        //   ),
        // ),
      ),
      home: const HomeLoginScreen(
        labelChoosen: "Log In",
        underLineLabel: "Access your existing account",
      ),
    );
  }
}
