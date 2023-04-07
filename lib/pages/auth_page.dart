import 'package:agenda_electronique/pages/name_selection_page.dart';
import 'package:agenda_electronique/widgets/single_code_box.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthPageState();

}

class _AuthPageState extends State<AuthPage> {
  final _secret = "1230";
  late int _max;
  final Map<int, String> _values = {};
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _max = _secret.length;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentification", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.orange.shade600,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_max, (index) => index).map((index) =>
              SingleCodeBox(
                index: index,
                register: _registerValue,
                error: _error,
              )).toList(),
        ),
      ),
    );
  }

  void _registerValue({required int index, required String value}) {
    // _values.putIfAbsent(index, () => value);
    _values[index] = value;

    if(_isCodeValid()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return NameSelectionPage();
      }));
    } else {
      if(_values.length >= _max) {
        setState(() {
          _error = true;
          _values.clear();
        });
      }
    }
  }

  bool _isCodeValid() {
    String code = "";
    for(int index = 0; index < _max; index++) {
      String? currentValue = _values[index];
      if(currentValue == null) {
        return false;
      }
      code = "$code$currentValue";
    }
    return code == _secret;
  }
}
