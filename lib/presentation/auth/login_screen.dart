import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hwait_apps/core/components/components.dart';
import 'package:hwait_apps/core/components/spaces.dart';
import 'package:hwait_apps/core/core.dart';
import 'package:hwait_apps/data/model/request/auth/login_request_model.dart';
import 'package:hwait_apps/presentation/admin/admin_screen.dart';
import 'package:hwait_apps/presentation/auth/bloc/login/login_bloc.dart';
import 'package:hwait_apps/presentation/auth/register_screen.dart';
import 'package:hwait_apps/presentation/saver/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.darkTealGradient),
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpaceHeight(170),
                    Text(
                      "Hwait",
                      style: GoogleFonts.justAnotherHand(
                        color: AppColors.lightSheet,
                        fontSize: MediaQuery.of(context).size.width * 0.2,
                      )
                    ),
                    Text(
                      'Wujudkan impian liburanmu dengan\nmenabung',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.lightSheet,
                        fontSize: MediaQuery.of(context).size.width * 0.04
                      )
                    ),
                    const SpaceHeight(30),
                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.email),
                      ),
                    ),
                    const SpaceHeight(25),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      obscureText: !isShowPassword,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        icon: Icon(
                          isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SpaceHeight(30),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginFailure) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        } else if (state is LoginSucces) {
                          final role =
                              state.responseModel.data?.role?.toLowerCase();
                          if (role == 'admin') {
                            context.pushAndRemoveUntil(
                              const AdminScreen(),
                              (route) => false,
                            );
                          } else if (role == 'saver') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.responseModel.message!),
                              ),
                            );
                            context.pushAndRemoveUntil(
                              const HomeScreen(),
                              (route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Role tidak dikenal."),
                              ),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        return Button.filled(
                          onPressed:
                              state is LoginLoading
                                  ? null
                                  : () {
                                    if (_key.currentState!.validate()) {
                                      final request = LoginRequestModel(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      context.read<LoginBloc>().add(
                                        LoginRequested(requestModel: request),
                                      );
                                    }
                                  },
                          label: state is LoginLoading ? "Memuat..." : "Masuk",
                          fontSize: 18.0,
                        );
                      },
                    ),
                    const SpaceHeight(20),
                    Text.rich(
                      TextSpan(
                        text: 'Belum memiliki akun? Silahkan ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                        children: [
                          TextSpan(
                            text: 'Daftar disini!',
                            style: TextStyle(color: Colors.white60),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push(const RegisterScreen());
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
