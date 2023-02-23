import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/const/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/auth/screens/forget_password.dart';
import 'package:greengrocer/src/services/util_services.dart';
import 'package:greengrocer/src/services/validators/email_validator.dart';
import 'package:greengrocer/src/services/validators/input_null_validator.dart';
import 'package:greengrocer/src/services/validators/length_validator.dart';
import 'package:greengrocer/src/widget/custom_button/custom_button_widget.dart';
import 'package:greengrocer/src/widget/text_form_input/text_form_input_widget.dart';
import 'package:greengrocer/src/widget/text_rich_widget/text_rich_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UtilServices utilServices = UtilServices();
  late bool obscureText;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void changeObscureText() async {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaSize.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const TextRichWidget(
                      fontSize: 40,
                      primaryName: 'Green',
                      secundName: 'gracer',
                    ),
                    SizedBox(
                      height: 40,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            RotateAnimatedText(
                              'Frutas',
                              textStyle: const TextStyle(
                                fontSize: 32.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RotateAnimatedText(
                              'Verduras',
                              textStyle: const TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RotateAnimatedText(
                              'Legumes',
                              textStyle: const TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Form Login
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormInputWidget(
                        controller: emailController,
                        icon: const Icon(Icons.email),
                        nameField: 'Email',
                        keyboardType: TextInputType.text,
                        validator: emailValidator,
                      ),
                      TextFormInputWidget(
                        controller: passwordController,
                        icon: const Icon(Icons.lock),
                        secret: true,
                        nameField: 'Password',
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (inputValidatorNull('password', val) != null) {
                            return inputValidatorNull('password', val);
                          }
                          if (validatorLength('password', 7, val!) != null) {
                            return validatorLength('password', 7, val);
                          }

                          return null;
                        },
                      ),
                      GetX<AuthController>(
                        builder: (authcontroller) {
                          return SizedBox(
                            height: 50,
                            child: CustomButtonWidget(
                              circularIndicator: authcontroller.isLoading.value,
                              title: 'Entrar',
                              icon: Icons.login,
                              onPressed: authcontroller.isLoading.value
                                  ? () {}
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        authcontroller.signIn(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );

                                        Get.offNamed(PagesRoutes.baseRoutes);
                                      }
                                      FocusScope.of(context).unfocus();
                                    },
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                                context: context,
                                builder: (_) {
                                  return ForgotPasswordDialog(
                                    email: emailController.text,
                                  );
                                });
                            if (result ?? false) {
                              utilServices.showToast(
                                  message:
                                      'Um link de resuperação foi enviada para seu email');
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2.0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButtonWidget(
                        title: 'Criar Conta',
                        icon: Icons.add_circle,
                        onPressed: () {
                          Get.offNamed(PagesRoutes.signUpRoutes);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
