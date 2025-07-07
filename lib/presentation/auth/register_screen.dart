import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/core/components/components.dart';
import 'package:hwait_apps/core/components/spaces.dart';
import 'package:hwait_apps/core/constants/colors.dart';
import 'package:hwait_apps/core/extensions/extensions.dart';
import 'package:hwait_apps/data/model/request/auth/register_request_model.dart';
import 'package:hwait_apps/presentation/auth/bloc/register/register_bloc.dart';
import 'package:hwait_apps/presentation/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController = TextEditingController();
    _key.currentState?.dispose();
    super.dispose();
  }

  String? _validatePasswordMatch(String? value) {
    if (value != passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpaceHeight(170),
                  Text(
                    'DAFTAR AKUN BARU',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SpaceHeight(30),
                  CustomTextField(
                    controller: usernameController,
                    label: 'Username',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person),
                    ),
                  ),
                  const SpaceHeight(25),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  const SpaceHeight(20),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          prefixIcon: Icon(Icons.lock),
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
                          onChanged: (_) {
                            if (passwordConfirmController.text.isNotEmpty) {
                              _key.currentState?.validate();
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: passwordConfirmController,
                          label: 'Confirm Password',
                          validator: _validatePasswordMatch,
                          prefixIcon: Icon(Icons.lock),
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
                      ),
                    ],
                  ),
                  const SpaceHeight(50),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        context.pushAndRemoveUntil(
                          const LoginScreen(),
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      } else if (state is RegisterFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: AppColors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Button.filled(
                        onPressed: state is RegisterLoading
                            ? null
                            : () {
                                if (_key.currentState!.validate()) {
                                  final request = RegisterRequestModel(
                                    username: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  context.read<RegisterBloc>().add(
                                        RegisterRequested(requestModel: request),
                                      );
                                }
                              },
                        label: state is RegisterLoading ? 'Memuat...' : 'Daftar',
                      );
                    },
                  ),
                  const SpaceHeight(20),
                  Text.rich(
                    TextSpan(
                      text: 'Sudah memiliki akun? Silahkan ',
                      style: TextStyle(color: AppColors.primary),
                      children: [
                        TextSpan(
                          text: 'Login disini!',
                          style: TextStyle(color: AppColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushAndRemoveUntil(
                                const LoginScreen(),
                                (route) => false,
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
