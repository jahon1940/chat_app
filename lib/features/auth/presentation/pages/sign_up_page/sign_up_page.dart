import 'package:empty_feature_folder/features/auth/presentation/widgets/global_button.dart';
import 'package:empty_feature_folder/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../routes/name_routes.dart';
import '../../bloc/auth_bloc.dart';
import '../../mixin/mixin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignInPageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
appBar: AppBar(
  title: const Text('Sign In',style: TextStyle(color: Colors.white),),
  backgroundColor: const Color(0xFF35B7B7),
  elevation: 0,
),
          body: ListView(
            children: [

              const SizedBox(
                height: 20,
              ),
              state.file == null
                  ? SizedBox(
                      height: 115,
                      width: 115,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 140, right: 140),
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: const ShapeDecoration(
                                shape: OvalBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFF35B7B7)),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  minRadius: 60,
                                  maxRadius: 60,
                                  child: Icon(Icons.person, size: 50,color: Colors.white,),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(GetImageEvent());
                                  },
                                  elevation: 2.0,
                                  fillColor: const Color(0xFFF5F6F9),
                                  padding: const EdgeInsets.all(10.0),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color(0xFF35B7B7),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  : MaterialButton(
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Container(
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF35B7B7)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.file(
                                state.file!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(GetImageEvent());
                      },
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFieldWidget(
                  textEditingController: nameController,
                  hintText: 'Enter your name',
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFieldWidget(
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFieldPasswordWidget(
                  textEditingController: passwordController,
                  hintTextController: 'Enter your Password',
                  labelTextController: 'Password',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GlobalButton(
                    buttonName: 'Sign Up',
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          nameController.text.isNotEmpty) {
                        context.read<AuthBloc>().add(SignUpEmailEvent(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            photo: state.file));
                      }

                      Navigator.pushNamed(context, RouteName.signIn);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
