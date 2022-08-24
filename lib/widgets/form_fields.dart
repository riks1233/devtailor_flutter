import 'dart:math';

import 'package:devtailor_task_richardas/appcolors.dart';
import 'package:devtailor_task_richardas/data/countries.dart';
import 'package:flutter/material.dart';

class CountrySelectFormField extends DropdownButtonFormField<String> {
  CountrySelectFormField({
    required String value,
    required Function(String?)? onChanged,
    Key? key,
  }) : super(
    key: key,
    value: value,
    items: Countries.codes.map(
      (code) => DropdownMenuItem<String>(
        value: code,
        child: Text(
          Countries.get(code),
          style: const TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      )).toList(),
    onChanged: onChanged,
    isExpanded: true,
    menuMaxHeight: 300,
    icon: Transform.rotate(angle: -90 * pi / 4, child: const Icon(Icons.arrow_back_ios_sharp)),
    iconSize: 18,
    decoration: InputDecoration(
      floatingLabelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.greyText,
      ),
      labelText: 'Country of residence',
      border: const OutlineInputBorder(),
      enabledBorder: formFieldBorder(
        color: AppColors.inputFieldBlank,
        focused: false),
      focusedBorder: formFieldBorder(
        color: AppColors.greyText,
        focused: true),
      contentPadding: const EdgeInsets.only(left: 18, right: 12),
    ),
  );
}

class EmailFormField extends FormField<String> {
  EmailFormField({
    FormFieldSetter<String>? onSaved,
    Key? key
  }) : super(
    key: key,
    onSaved: onSaved,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Email';
      }
      value = value.trim();

      const String emailPattern = r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""";
      final RegExp emailRegExp = RegExp(emailPattern);
      String? match = emailRegExp.stringMatch(value);
      if (match != value) {
        return 'Wrong email format';
      }

      return null;
    },
    builder: (fieldState) {
      return TextField(
        onChanged: (value) {
          fieldState.didChange(value);
        },
        cursorColor: Colors.black,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: 16,
            color: fieldState.errorText == null ? AppColors.greyText : AppColors.error,
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: fieldState.errorText == null ? AppColors.greyText : AppColors.error,
          ),
          labelText: fieldState.errorText ?? 'Email',
          border: const OutlineInputBorder(),
          enabledBorder: formFieldBorder(
            color: fieldState.errorText == null ? AppColors.inputFieldBlank : AppColors.error,
            focused: false),
          focusedBorder: formFieldBorder(
            color: fieldState.errorText == null ? Colors.grey.shade500 : AppColors.error,
            focused: true),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        keyboardType: TextInputType.emailAddress,
      );
    },
  );
}

class PasswordFormField extends FormField<String> {
  PasswordFormField({
    required TextEditingController controller,
    required VoidCallback onVisibilityTap,
    required bool obscurePassword,
    required String labelText,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    Key? key,
  }) : super(
    key: key,
    validator: validator,
    onSaved: onSaved,
    builder: (fieldState) {
      return TextField(
        onChanged: (value) {
          fieldState.didChange(value);
        },
        controller: controller,
        style: TextStyle(
          color: AppColors.darkText,
          fontWeight: FontWeight.w500,
          fontSize: obscurePassword ? 12 : 16,
          letterSpacing: obscurePassword ? 6 : 0,
        ),
        cursorColor: Colors.black,
        decoration: passwordFieldInputDecoration(
          labelText: labelText,
          errorText: fieldState.errorText,
          obscurePassword: obscurePassword,
          onVisibilityTap: onVisibilityTap,
        ),
        obscuringCharacter: '●',
        obscureText: obscurePassword,
      );
    }
  );
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    required bool value,
    required Function(bool) onChanged,
    FormFieldSetter<String>? onSaved,
    Key? key
  }) : super(
    key: key,
    validator: (value) {
      if (value == null || !value) {
        return "";
      }
      return null;
    },
    builder: (fieldState) {
      return CustomCheckbox(
        value: value,
        onChanged: (value) {
          fieldState.didChange(value);
          onChanged(value);
        },
        activeColor: AppColors.blueAccent,
        borderColor: fieldState.errorText != null ? AppColors.error : (value ? AppColors.blueAccent : AppColors.inputFieldBlank),
      );
    },
  );
}

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    required this.value,
    required this.onChanged,
    required this.activeColor,
    this.inactiveBackgroundColor = Colors.transparent,
    this.borderColor = AppColors.inputFieldBlank,
    this.size = 20,
    Key? key,
  }) : super(key: key);

  final bool value;
  final Function(bool) onChanged;
  final Color activeColor;

  final Color inactiveBackgroundColor;
  final Color borderColor;
  final double size;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onChanged(!widget.value),
          child: Container(
            decoration: BoxDecoration(
              color: widget.value ? widget.activeColor : widget.inactiveBackgroundColor,
              border: Border.all(
                color: widget.borderColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: !widget.value ?
              Container()
              :
              const FittedBox(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration passwordFieldInputDecoration({
  required String labelText,
  required String? errorText,
  required bool obscurePassword,
  required VoidCallback onVisibilityTap,
}) {
  return InputDecoration(
    labelStyle: TextStyle(
      color: errorText == null ? AppColors.greyText : AppColors.error,
      fontSize: 16,
      letterSpacing: 0,
    ),
    floatingLabelStyle: TextStyle(
      color: errorText == null ? AppColors.greyText : AppColors.error,
      fontSize: 18,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    labelText: errorText ?? labelText,

    border: const OutlineInputBorder(),
    enabledBorder: formFieldBorder(
      color: errorText == null ? AppColors.inputFieldBlank : AppColors.error,
      focused: false),
    focusedBorder: formFieldBorder(
      color: errorText == null ? AppColors.greyText : AppColors.error,
      focused: true),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18),

    suffixIcon: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onVisibilityTap(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.darkText,
          ),
        ),
      ),
    ),
    suffixIconConstraints: const BoxConstraints(),
  );
}

OutlineInputBorder formFieldBorder({required Color color, required bool focused}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: focused ? 2 : 1,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(6)),
  );
}
