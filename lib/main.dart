import '../common/widgets/bottom_bar.dart';
import '../constants/global_variables.dart';
import '../features/admin/screens/admin_screen.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/auth/services/auth_service.dart';
import '../providers/user_provider.dart';
import '../router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App bán hàng',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 236, 20, 20),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.red),
        ),
      ),
      onGenerateRoute: (setttings) => generateRoute(setttings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? const BottomBar()
          : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
