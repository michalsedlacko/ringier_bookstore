import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ringier_bookstore/config/constant.dart';
import 'package:ringier_bookstore/router/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    RouteGenerator routeGenerator = RouteGenerator(currentContext: context);
    return MaterialApp(
      title: 'Ringier book store',
      theme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            color: bgColor,
            toolbarTextStyle: TextStyle(color: Colors.white),
          ),
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
                  headlineLarge: TextStyle(color: Colors.white)))
              .apply(
            bodyColor: Colors.white,
          ),
          canvasColor: secondaryColor,
          primaryColor: primaryColor),

      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      onGenerateRoute: routeGenerator.generateRoute,
    );
  }
}
