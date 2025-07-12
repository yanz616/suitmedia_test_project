import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_project1/blocs/polindrome/palindrome_bloc.dart';
import 'package:suitmedia_project1/blocs/user/user_bloc.dart';
import 'package:suitmedia_project1/repositories/user_repository.dart';
import 'package:suitmedia_project1/screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PalindromeBloc>(create: (_) => PalindromeBloc()),
        BlocProvider(create: (_) => UserBloc(UserRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstScreen(),
      ),
    );
  }
}
