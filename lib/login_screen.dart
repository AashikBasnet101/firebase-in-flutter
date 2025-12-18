import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/core/constants/string_const.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_bloc.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_event.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_state.dart';
import 'package:newprojectfirebase/features/auth/model/user.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';
import 'package:newprojectfirebase/forgot_password.dart';
import 'package:newprojectfirebase/signup_screen.dart';
import 'package:newprojectfirebase/signout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadedState) {
              // Navigate on successful login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GoogleSignout()),
              );
            } else if (state is AuthErrorState) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.asset("assets/yatra.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3D8DB5),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Once more, destiny calls you forth.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xA0161411),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.71,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ---------------- Email ----------------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTextform(
                        labelText: 'Enter your email',
                        onChanged: (val) => email = val,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ---------------- Password ----------------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTextform(
                        labelText: 'Enter your password',
                        obscureText: true,
                        onChanged: (val) => password = val,
                      ),
                    ],
                  ),

                  // ---------------- Forgot Password ----------------
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ForgotPassword()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 92, 88, 88),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ---------------- Login Button ----------------
                  CustomElevatedButton(
                    width: double.infinity,
                    backgroundColor: const Color(0xFF3D8DB5),
                    onPressed: isLoading
                        ? null
                        : () {
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(
                                UserLogin(email: email, password: password),
                              ),
                            );
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),

                  const SizedBox(height: 6),

                  // ---------------- Sign Up Info ----------------
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 92, 88, 88),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  // ---------------- OR Divider ----------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                      ],
                    ),
                  ),

                  // ---------------- Google Sign-In Button ----------------
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: CustomElevatedButton(
                  //     width: double.infinity,
                  //     backgroundColor: Colors.white,
                  //     foregroundColor: Colors.black,
                  //     onPressed: isLoading
                  //         ? null
                  //         : () async {
                  //             bool ok = await context.read<AuthBloc>().signInWithGoogle();
                  //             if (ok) {
                  //               Navigator.pushReplacement(
                  //                 context,
                  //                 MaterialPageRoute(builder: (_) => const GoogleSignout()),
                  //               );
                  //             } else {
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 const SnackBar(content: Text("Google Sign-In Failed")),
                  //               );
                  //             }
                  //           },
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(
                  //           "assets/google_logo.png",
                  //           width: 22,
                  //           height: 22,
                  //         ),
                  //         const SizedBox(width: 10),
                  //         const Text("Sign In with Google"),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
