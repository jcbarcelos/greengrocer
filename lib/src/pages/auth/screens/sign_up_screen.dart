import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/const/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/auth/form/title_conteiner.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/validators/email_validator.dart';
import 'package:greengrocer/src/services/validators/input_null_validator.dart';
import 'package:greengrocer/src/services/validators/length_validator.dart';
import 'package:greengrocer/src/utils/format_input.dart';
import 'package:greengrocer/src/widget/custom_button/custom_button_widget.dart';
import 'package:greengrocer/src/widget/text_form_input/text_form_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  late bool obscureText;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cpfController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaSize.height,
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const TitleContainer(
                    nameTitle: 'Cadastro',
                  ),
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? email) {
                              emailValidator(email);
                              if (inputValidatorNull('Email', email) != null) {
                                return inputValidatorNull('Email', email);
                              }

                              return null;
                            },
                          ),
                          TextFormInputWidget(
                            controller: passwordController,
                            icon: const Icon(Icons.lock),
                            secret: true,
                            nameField: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? password) {
                              if (validatorLength('password', 7, password!) !=
                                  null) {
                                return validatorLength('password', 7, password);
                              }

                              return null;
                            },
                          ),
                          TextFormInputWidget(
                              controller: userController,
                              icon: const Icon(Icons.people),
                              nameField: 'Nome',
                              keyboardType: TextInputType.text,
                              validator: (String? name) {
                                if (inputValidatorNull('Nome', name) != null) {
                                  return inputValidatorNull('Nome', name);
                                }

                                return null;
                              }),
                          TextFormInputWidget(
                            controller: phoneController,
                            icon: const Icon(Icons.phone),
                            nameField: 'Celular',
                            keyboardType: TextInputType.number,
                            inputFormats: [phoneFormater],
                            validator: (String? celular) {
                              if (inputValidatorNull('Celular', celular) !=
                                  null) {
                                return inputValidatorNull('Celular', celular);
                              }

                              return null;
                            },
                          ),
                          TextFormInputWidget(
                            controller: cpfController,
                            icon: const Icon(Icons.file_copy),
                            nameField: 'CPF',
                            keyboardType: TextInputType.number,
                            inputFormats: [cpfFormater],
                            validator: (String? cpf) {
                              if (inputValidatorNull('CPF', cpf) != null) {
                                return inputValidatorNull('CPF', cpf);
                              }

                              // numberCpfValidator(cpf);
                              return null;
                            },
                          ),
                          GetX<AuthController>(
                            builder: (authcontroller) {
                              return SizedBox(
                                height: 50,
                                child: CustomButtonWidget(
                                  circularIndicator:
                                      authcontroller.isLoading.value,
                                  title: 'Salvar',
                                  icon: Icons.save,
                                  onPressed: authcontroller.isLoading.value
                                      ? () {}
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            authcontroller.signUp(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              fullname: userController.text,
                                              phone: phoneController.text,
                                              cpf: cpfController.text,
                                            );
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
                              onPressed: () {
                                Get.offNamed(PagesRoutes.signInRoutes);
                              },
                              child: Text(
                                'Já tem cadastro?',
                                style: TextStyle(
                                  color: CustomColors.customContrastColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
