import 'package:empty_feature_folder/constants/constants.dart';
import 'package:empty_feature_folder/features/auth/presentation/widgets/global_button.dart';
import 'package:empty_feature_folder/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../routes/name_routes.dart';
import '../../../../main/presentation/pages/main_page/main_page.dart';
import '../../bloc/auth_bloc.dart';
import '../../mixin/mixin.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInPageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainPage();
              } else {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    leading: Container(),
                    backgroundColor: const Color(0xff36B8B8),
                    centerTitle: true,
                    title: const Text('Chat App'),
                    elevation: 0,
                  ),
                  body: ListView(
                    children: [
                      Container(
                          height: 180,
                          color: const Color(0xff36B8B8),
                          child: Image.asset(AppImages.logo)),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: TextFieldWidget(
                          textEditingController: emailController,
                          hintText: 'Enter your email',
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.mail),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextFieldPasswordWidget(
                          textEditingController: passwordController,
                          hintTextController: 'Enter your Password',
                          labelTextController: 'Password',
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: GlobalButton(
                            buttonName: 'Sign In',
                            onTap: () {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                context.read<AuthBloc>().add(SignInEmailEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              }
                            }),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            '- OR Continue with -',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF575757),
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 150, right: 150),
                        child: GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(SignUpGoogleEvent());
                          },
                          child: Container(
                            height: 88,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF35B7B7).withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  AppImages.google,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 110, right: 20),
                        child: RichText(
                            text: TextSpan(
                                text: "Create An Account ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                text: ' Sign Up',
                                style: const TextStyle(
                                  color: Color(0xFF35B7B7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, RouteName.signUp);
                                  },
                              ),
                            ])),
                      )
                    ],
                  ),
                );
              }
            });
      },
    );
  }
}
