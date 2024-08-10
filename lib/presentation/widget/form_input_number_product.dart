import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_cart/presentation/widget/custom_button.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';

class FormInputNumberProduct extends StatefulWidget {
  const FormInputNumberProduct(
      {super.key, required this.submit, required this.initNumber});
  final Function(int) submit;
  final int initNumber;
  @override
  State<FormInputNumberProduct> createState() => _FormInputNumberProductState();
}

class _FormInputNumberProductState extends State<FormInputNumberProduct> {
  final _controller = TextEditingController();
  bool _isValid = false;
  bool _hasText = false;
  final key = GlobalKey<FormState>();
  String? _validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'This field is required';
    }
    final number = int.parse(text);
    if (number < 1) {
      return 'Must be a number more than 0';
    } else if (number > 999) {
      return 'Must be a number less than 999';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    _controller.text = widget.initNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Prodyct",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 16.w,
          ),
          Form(
            key: key,
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              validator: _validateText,
              decoration: InputDecoration(
                hintText: 'Enter your number',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: ColorConstants.primary,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: ColorConstants.primary,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: ColorConstants.primary,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.w,
          ),
          CustomButton(
            title: "Submit",
            onPressed: () {
              if (key.currentState?.validate() ?? false) {
                widget.submit(int.parse(_controller.text));
              }
            },
          )
        ],
      ),
    );
    ;
  }
}
