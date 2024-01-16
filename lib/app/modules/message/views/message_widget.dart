import 'package:flutter/material.dart';

class SenMessageField extends StatelessWidget {
  final TextEditingController? textController;
  const SenMessageField({Key? key, this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: const InputDecoration(
        labelText: 'Type your message here',
      ),
    );
  }
}
