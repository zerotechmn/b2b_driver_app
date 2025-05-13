import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OTPInput extends StatefulWidget {
  final void Function(String) onFinished;
  const OTPInput({super.key, required this.onFinished});

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final int _maxLength = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 0,
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: true,
                keyboardType: TextInputType.number,
                autofillHints: [AutofillHints.oneTimeCode],
                maxLength: _maxLength,
                onChanged: (value) {
                  if (value.length == _maxLength) {
                    widget.onFinished(value);
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double boxSize = constraints.maxWidth / 8;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_maxLength, (index) {
                  String digit =
                      _controller.text.length > index
                          ? _controller.text[index]
                          : "";

                  return GestureDetector(
                    onTap: () => _focusNode.requestFocus(),
                    child: Container(
                      width: boxSize,
                      height: boxSize * 1.2,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors(context).backgroundSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        digit,
                        style: textTheme(
                          context,
                        ).titleSmall!.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
