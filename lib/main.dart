import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/config/theme/app_themes..dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/pages/login.dart';
import 'package:synapsis_mobile_engineer_challenge/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(BlocProvider<LoginBloc>(
      create: (context) => sl()..add(LoginInitialize()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider<RemoteAssessmentsBloc>(
    //   create: (context) => sl()..add(const GetAsssessments()),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: theme(),
    //     home: const Assessments(),
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const Login(),
    );
  }
}
