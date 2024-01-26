import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/core/util/validator.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/presentation/pages/assessments.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_state.dart';

class Login extends StatefulWidget {
  static String id = 'login_screen';

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = true;
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Login to Synapsis",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 21,
                                      color: Colors.black87),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  cursorColor:
                                      Color.fromARGB(255, 31, 160, 201),
                                  validator: (value) {
                                    return Validator.validateEmail(value ?? "");
                                  },
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 236, 236, 236),
                                    hintText: "Email",
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 223, 222, 222)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 31, 160, 201)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Password",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: _showPassword,
                                  controller: passwordController,
                                  cursorColor:
                                      Color.fromARGB(255, 31, 160, 201),
                                  validator: (value) {
                                    return Validator.validatePassword(
                                        value ?? "");
                                  },
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() =>
                                            _showPassword = !_showPassword);
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 25,
                                      ),
                                    ),
                                    hintText: "Password",
                                    isDense: true,
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 236, 236, 236),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 223, 222, 222)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 31, 160, 201)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                              ])),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 2,
                          ),
                          Checkbox(
                            value: _isChecked,
                            side: BorderSide(color: Colors.black38),
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value;
                              });
                            },
                            activeColor: Color.fromARGB(255, 31, 160, 201),
                          ),
                          const Text(
                            "Remember me",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      SubmitLogin(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          _isChecked!),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      backgroundColor:
                                          Color.fromARGB(255, 31, 160, 201),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15)),
                                  child: state is LoginLoading
                                      ? CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Log in",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "or",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 31, 160, 201),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    foregroundColor:
                                        Color.fromARGB(255, 31, 160, 201),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 160, 201),
                                        width: 1)),
                                child: const Text(
                                  "Fingerprint",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 31, 160, 201),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ]),
                  ))));
    }, listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return AssessmentsPage();
        }));
      }
      if (state is LoginError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error!),
          backgroundColor: Colors.red.shade300,
        ));
      }
    });
  }
}
