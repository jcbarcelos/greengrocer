import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/services/validators/email_validator.dart';
import 'package:greengrocer/src/widget/custom_button/custom_button_widget.dart';
import 'package:greengrocer/src/widget/text_form_input/text_form_input_widget.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();

  ForgotPasswordDialog({
    required String email,
    Key? key,
  }) : super(key: key) {
    emailController.text = email;
  }

  final _formFieldkey = GlobalKey<FormFieldState>();
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // Descrição
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),

                // Campo de email

                TextFormInputWidget(
                  formFieldkey: _formFieldkey,
                  controller: emailController,
                  icon: const Icon(Icons.email),
                  nameField: 'Email',
                  keyboardType: TextInputType.text,
                  validator: emailValidator,
                ),
                // Confirmar

                CustomButtonWidget(
                  title: 'Recuperar',
                  icon: Icons.attach_email_rounded,
                  onPressed: () {
                    if (_formFieldkey.currentState!.validate()) {
                      authController.resetPassword(emailController.text);
                      Get.back(result: true);
                    }
                  },
                ),
              ],
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
