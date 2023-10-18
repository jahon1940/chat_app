import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

mixin SignInPageMixin  {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final textFieldFocusNode = FocusNode();

}