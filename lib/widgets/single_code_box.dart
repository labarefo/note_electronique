import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SingleCodeBox extends StatefulWidget {
  final int index;
  bool error;
  final void Function({required int index, required String value}) register;

  SingleCodeBox({
    required this.index,
    required this.register,
    this.error = false,
  }) : super(key: UniqueKey());

  @override
  State<SingleCodeBox> createState() => _SingleCodeBoxState();

  void send(String value) {
    register.call(index: index, value: value);
  }

}

class _SingleCodeBoxState extends State<SingleCodeBox> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.index == 0) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.8),
      child: SizedBox(
        width: 40,
        height: 40,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) {
            if (value.isNotEmpty) {
              widget.send(_controller.text);
              _focusNode.nextFocus();
            }
          },
          onTap: () {
            _controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controller.text.length,
            );
          },
          showCursor: true,
          textAlign: TextAlign.center,
          enableSuggestions: false,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.horizontal()
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                  color: widget.error ? Colors.red : Colors.black
              )
            )
          ),
        ),
      ),
    );
  }
}
