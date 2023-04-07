import 'package:agenda_electronique/pages/name_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SubmittableText extends StatefulWidget {

  String label;
  String buttonLabel;
  double height;
  double width;
  Color textColor;

  void Function({required String text}) action;


  SubmittableText({ super.key,
    required this.label,
    required this.buttonLabel,
    required this.height,
    required this.width,
    required this.action,
    this.textColor = Colors.purple,
  });

  @override
  State<SubmittableText> createState() => _SubmittableTextState();
}

class _SubmittableTextState extends State<SubmittableText> {

  late TextEditingController _textEditingController;
  late NameNotifier _notifier;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _notifier = NameNotifier();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<NameNotifier>(
      create: (ctx) => _notifier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
                fontSize: 20
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: TextField(
                style: TextStyle(fontSize: 20.0, color: widget.textColor),
                controller: _textEditingController,
                textAlign: TextAlign.center,
                enableSuggestions: false,
                autofocus: true,
                inputFormatters: [ LengthLimitingTextInputFormatter(25) ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide()
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                      )
                  ),
                ),
                onChanged: (value) {
                  _notifyChange();
                },
              ),
            ),
          ),
          Consumer<NameNotifier>(
              builder: (context, notifier, child) {
                return SizedBox(
                  child: ElevatedButton(
                      onPressed: !notifier.filled ? null : () => _action(),
                      child: Text(widget.buttonLabel, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)
                  ),
                );
              }
          )

        ],
      ),
    );
  }

  void _action() {
    var value = _textEditingController.text;
    _textEditingController.clear();
    _notifyChange();
    widget.action(text: value);
  }

  void _notifyChange() {
    _notifier.filled = _textEditingController.text.isNotEmpty;
  }

}