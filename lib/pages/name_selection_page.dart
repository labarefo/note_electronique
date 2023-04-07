import 'package:agenda_electronique/bloc/bloc_items.dart';
import 'package:agenda_electronique/bloc/bloc_provider.dart';
import 'package:agenda_electronique/pages/items_page.dart';
import 'package:agenda_electronique/widgets/submittable_text.dart';
import 'package:flutter/material.dart';

class NameSelectionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NameSelectionPageState();

}

class _NameSelectionPageState extends State<NameSelectionPage> {



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenu", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.yellow.shade700,
      ),
      body: Center(
        child: SubmittableText(
            key: const Key("name_page"),
            label: "Nom",
            buttonLabel: "OK",
            height: size.height * .04,
            width: size.width * .30,
            action: _navigateToItemsPage
        ),
      ),

    );
  }


  void _navigateToItemsPage({required String text}) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => BlocProvider(bloc: BlocItems(), child: ItemsPage(name: text)))
    );
  }
}