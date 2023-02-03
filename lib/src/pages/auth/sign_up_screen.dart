import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/auth/form/title_conteiner.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/widget/text_form_input/text_form_input_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  final cpfFormater = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final phoneFormater = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

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
                          ),
                          TextFormInputWidget(
                            controller: passwordController,
                            icon: const Icon(Icons.lock),
                            secret: true,
                            nameField: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          TextFormInputWidget(
                            controller: userController,
                            icon: const Icon(Icons.people),
                            nameField: 'Nome',
                            keyboardType: TextInputType.text,
                          ),
                          TextFormInputWidget(
                            controller: phoneController,
                            icon: const Icon(Icons.phone),
                            nameField: 'Celular',
                            keyboardType: TextInputType.number,
                            inputFormats: [phoneFormater],
                          ),
                          TextFormInputWidget(
                            controller: cpfController,
                            icon: const Icon(Icons.file_copy),
                            nameField: 'CPF',
                            keyboardType: TextInputType.number,
                            inputFormats: [cpfFormater],
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.login),
                              label: const Text(
                                'Salvar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
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
