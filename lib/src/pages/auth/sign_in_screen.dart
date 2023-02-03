import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/auth/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/widget/snackbar_widget/snackbar_widget.dart';
import 'package:greengrocer/src/widget/text_form_input/text_form_input_widget.dart';
import 'package:greengrocer/src/widget/text_rich_widget/text_rich_widget.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
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
                            WavyAnimatedText(
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
                        controller: userController,
                        icon: const Icon(Icons.people),
                        nameField: 'Name',
                        keyboardType: TextInputType.text,
                      ),
                      TextFormInputWidget(
                        controller: passwordController,
                        icon: const Icon(Icons.lock),
                        secret: true,
                        nameField: 'Password',
                        keyboardType: TextInputType.text,
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
                              SnackBarWidget(
                                context: context,
                                message: 'Login...',
                                color: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                actionLabelColor: Colors.white,
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return const BaseScreen();
                                  },
                                ),
                              );
                            }
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (_) {
                            //       return const BaseScreen();
                            //     },
                            //   ),
                            // );
                          },
                          icon: const Icon(Icons.save),
                          label: const Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
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
                      SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (build) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          )),
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
