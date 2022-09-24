import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushit/common/bottom_nav_bar.dart';
import 'package:pushit/constants/global_variables.dart';
import 'package:pushit/features/admin/views/admin_screen.dart';
import 'package:pushit/features/auth/controller/authController.dart';
import 'package:pushit/features/auth/views/authscreen.dart';
import 'package:pushit/provider/user_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _authController.getData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push it',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home:Provider.of<UserProvider>(context).getUser.token.isNotEmpty
          ? Provider.of<UserProvider>(context).getUser.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
