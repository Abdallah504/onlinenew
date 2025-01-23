import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onlinenew/api/firebase-api.dart';
import 'package:onlinenew/logic/main-app-provider.dart';
import 'package:onlinenew/screens/home-screen.dart';
import 'package:onlinenew/screens/notify-screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rnsdrleocpbvzjnbomze.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJuc2RybGVvY3BidnpqbmJvbXplIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0ODI1MTUsImV4cCI6MjA1MzA1ODUxNX0.qtJZ7b2SACWwnUkPsLzXVDvWzSD2o4rci5cmi8MeLis',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>MainAppProvider()..getAllImages())
      ],
    child:  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      navigatorKey: navigatorKey,
      routes: {
        NotifyScreen.route:(context)=> NotifyScreen()
      },
    ),
    );
  }
}

