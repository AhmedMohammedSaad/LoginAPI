import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_login/features/authentication/presentation/screens/registerPage.dart';
import '../components/TextFormatField.dart';
import '../components/passwordFormField.dart';
import '../cubit/authentication_cubet_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String routName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> emailKey = GlobalKey();
  GlobalKey<FormState> passwordKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubetCubit, AuthenticationCubetState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/login.gif"),
                    ),
                  ),
                ),
                TextFromatField(
                  fKey: emailKey,
                  controller: context.read<AuthenticationCubetCubit>().email,
                  label: "email",
                ),
                PasswordFormatField(
                  fKey: passwordKey,
                  label: "password",
                  controller: context.read<AuthenticationCubetCubit>().password,
                ),
                state is AuthenticationLoding
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          if (emailKey.currentState!.validate() &&
                              passwordKey.currentState!.validate()) {
                            context.read<AuthenticationCubetCubit>().Login();
                          }
                        },
                        child: const Text(
                          "LogIn",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("If you don't have an account: "),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.routName);
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
