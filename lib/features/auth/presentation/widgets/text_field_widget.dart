import 'package:flutter/material.dart';

import '../mixin/mixin.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon
  });

  final dynamic textEditingController;
  final dynamic hintText;
  final dynamic labelText;
  final dynamic prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey,
      controller: textEditingController,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.focused)
              ? Colors.grey
              : Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(width: 1, color: Color(0xFF35B7B7)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFF35B7B7),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFF35B7B7),
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                width: 1,
              )),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          hintText: hintText,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color(0xFF35B7B7),
          )),
    );
  }
}

class TextFieldPasswordWidget extends StatefulWidget {
  const TextFieldPasswordWidget({
    super.key,
    required this.textEditingController,
    required this.hintTextController,
    required this.labelTextController,
  });

  final dynamic textEditingController;
  final dynamic hintTextController;
  final dynamic labelTextController;

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget>
    with SignInPageMixin {
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey,
      controller: widget.textEditingController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      focusNode: textFieldFocusNode,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_rounded, size: 24),
          prefixIconColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.focused)
              ? Colors.grey
              : Colors.grey),
          suffixIconColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.focused)
              ? Colors.grey
              : Colors.grey),
          suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: _toggleObscured,
                child: Icon(
                  _obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 24,
                ),
              )),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(width: 1, color: Color(0xFF35B7B7)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFF35B7B7),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFF35B7B7),
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                width: 1,
              )),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          hintText: widget.hintTextController,
          labelText: widget.labelTextController,
          labelStyle: const TextStyle(
            color: Color(0xFF35B7B7),
          )),
    );
  }
}
