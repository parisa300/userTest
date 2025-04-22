import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/presentation/pages/login_page.dart';
import 'features/presentation/bloc/user/user_bloc.dart';
import 'features/presentation/bloc/user_list/user_list_bloc.dart';
import 'user_injection.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Setup dependencies
  await init(); // for core dependencies
  initUserFeature(); // for login feature

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<UserListBloc>(
          create: (_) => sl<UserListBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(), // This will later navigate to UserPage
      ),
    );
  }

}

