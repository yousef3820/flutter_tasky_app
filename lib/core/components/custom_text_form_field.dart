import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key , required this.title , required this.hintText , required this.controller , this.validator , this.maxlines});
  final String title;
  final String hintText;
  final int? maxlines;
  final TextEditingController controller;
  final Function? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller ,
          style: TextStyle(color: Color(0xFFFFFCFC)),
          cursorColor: Color(0xFFFFFCFC),
          maxLines: maxlines,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: validator != null ?  (String? value ) => validator!(value) : null
        ),
        ],
    );
  }
}