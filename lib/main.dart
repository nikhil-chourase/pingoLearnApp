import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearnapp/utils/remote_config.dart';
import 'package:pingolearnapp/controllers/auth/auth_service.dart';
import 'package:pingolearnapp/controllers/product/product_provider.dart';
import 'package:pingolearnapp/utils/price_calculator.dart';
import 'package:pingolearnapp/view/auth/login_screen.dart';
import 'package:pingolearnapp/view/products/products_screen.dart';
import 'package:provider/provider.dart';


Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => PriceCalculator()),        
        ChangeNotifierProvider(create: (_) => RemoteConfigService()),
         
      ],
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            home: authService.isUserLoggedIn() ? const ProductScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}

