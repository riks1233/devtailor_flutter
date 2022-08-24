import 'dart:developer';

import 'package:devtailor_task_richardas/appcolors.dart';
import 'package:devtailor_task_richardas/data/countries.dart';
import 'package:devtailor_task_richardas/widgets/form_fields.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({ Key? key }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstPasswordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool termsChecked = false;

  // Form values.
  String country = Countries.first;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CountrySelectFormField(
            value: country,
            onChanged: (code) {
              setState(() {
                country = code ?? Countries.first;
              });
            },
          ),
          const SizedBox(height: 40,),
          EmailFormField(
            onSaved: (fieldValue) {
              email = fieldValue?.trim() ?? '';
            },
          ),
          const SizedBox(height: 40),
          PasswordFormField(
            controller: firstPasswordController,
            obscurePassword: obscurePassword,
            labelText: 'Create your password',
            onSaved: (fieldValue) {
              password = fieldValue ?? '';
            },
            onVisibilityTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Create your password';
              }

              if (firstPasswordController.text != secondPasswordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),
          const SizedBox(height: 40),
          PasswordFormField(
            controller: secondPasswordController,
            obscurePassword: obscurePassword,
            labelText: 'Re-enter password',
            onVisibilityTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            validator: (value) {
              if (value == null
                  || value.isEmpty
                  || firstPasswordController.text != secondPasswordController.text
              ) {
                return 'Re-enter password';
              }

              return null;
            },
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              CheckboxFormField(
                value: termsChecked,
                onChanged: (value) {
                  setState(() {
                    termsChecked = value;
                  });
                },
              ),
              const SizedBox(width: 20,),
              const Text(
                'I agree with ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      backgroundColor: MaterialStateProperty.all(AppColors.blueAccent),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final isValid = formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      formKey.currentState!.save();
                      // Utilize form values.
                      log('$country : $email : $password');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
