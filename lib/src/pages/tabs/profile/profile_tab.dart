import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/utils/format_input.dart';
import 'package:greengrocer/src/widget/custom_button/custom_button_widget.dart';
import 'package:greengrocer/src/widget/text_form_input/text_form_input_widget.dart';
import 'package:greengrocer/src/config/db/mock/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final AuthController authcontroller = AuthController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              authcontroller.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          TextFormInputWidget(
            initialValue: app_data.user.email,
            //controller: emailController,
            keyboardType: TextInputType.emailAddress,
            icon: const Icon(Icons.email),
            nameField: 'Email',
            readOnly: true,
          ),
          TextFormInputWidget(
            initialValue: app_data.user.name,
            //controller: userController,
            keyboardType: TextInputType.name,
            icon: const Icon(Icons.person),
            nameField: 'Name',
            readOnly: true,
          ),
          TextFormInputWidget(
            initialValue: app_data.user.phone,
            //   controller: phoneController,
            keyboardType: TextInputType.phone,
            icon: const Icon(Icons.phone_android),
            nameField: 'Celular',
            inputFormats: [phoneFormater],
            readOnly: true,
          ),
          TextFormInputWidget(
            initialValue: app_data.user.cpf,
            //   controller: cpfController,
            keyboardType: TextInputType.number,
            icon: const Icon(Icons.file_copy),
            nameField: 'CPF',
            secret: true,
            inputFormats: [cpfFormater],
            readOnly: true,
          ),
          CustomButtonWidget(
            title: 'Atualizar Conta',
            icon: Icons.update_outlined,
            onPressed: () {
              updatePassword();
            },
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() async {
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Text(
                        'Atualização de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormInputWidget(
                      //   controller: cpfController,
                      keyboardType: TextInputType.text,
                      icon: const Icon(Icons.lock_outline),
                      nameField: 'Senha Atual',
                      secret: true,
                      readOnly: false,
                    ),
                    TextFormInputWidget(
                      //   controller: cpfController,
                      keyboardType: TextInputType.text,
                      icon: const Icon(Icons.lock),
                      nameField: 'Nova senha',
                      secret: true,
                      readOnly: false,
                    ),
                    TextFormInputWidget(
                      //   controller: cpfController,
                      keyboardType: TextInputType.text,
                      icon: const Icon(Icons.lock),
                      nameField: 'Confirmar nova senha',
                      secret: true,
                      readOnly: false,
                    ),
                    CustomButtonWidget(
                      title: 'Atualizar',
                      icon: Icons.update_outlined,
                      onPressed: () {
                        updatePassword();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
