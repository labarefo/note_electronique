import 'package:agenda_electronique/bloc/bloc_items.dart';
import 'package:agenda_electronique/bloc/bloc_provider.dart';
import 'package:agenda_electronique/models/item.dart';
import 'package:agenda_electronique/widgets/submittable_text.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  String name;


  ItemsPage({required this.name});

  late BlocItems bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<BlocItems>(context)!;
    var screenSize = MediaQuery.of(context).size;
    // var items = [Item(id: 0, name: 'Sortie'), Item(id: 1, name: 'Voyage')];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Agenda $name', style: const TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Mes idées", style: TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.teal, fontSize: 25),),
              ),

              StreamBuilder<List<Item>>(
                  stream: bloc.itemsDriver.stream,
                  builder: (cxt, snapshot) {

                    if(snapshot.hasError) {
                      return Text("Erreur de chargement");
                    }
                    if(!snapshot.hasData) {
                      return const SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      );
                    }
                    var items = snapshot.data!;
                    return _buildItems(items, screenSize);
                  }
              ),

              SubmittableText(
                  key: const Key("items_page"),
                  label: "Tâche",
                  buttonLabel: "Ajouter",
                  height: screenSize.height * .04,
                  width: screenSize.width * .30,
                  textColor: Colors.teal,
                  action: _addItem
              ),

            ],
          ),
        ),
      ),
    );
  }


  void _addItem({required String text}) {
    bloc.addItem(text);
  }

  void _deleteItem({required int id}) {
    bloc.removeItem(id);
  }

  Widget _buildItems(List<Item> items, Size screenSize) {
    return Container(
      height: screenSize.height * .60,
      width: screenSize.width * .90,
      color: Colors.white70,
      child: items.isEmpty ? const Center(child: Text("Aucune données", style: TextStyle(fontStyle: FontStyle.italic),)) :  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.map((item) => Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
            child: Container(
              color: Colors.blueGrey,
              child: ListTile(
                title: Text(item.name, style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                ),
                trailing: IconButton(
                    onPressed: () => _deleteItem(id: item.id),
                    icon: const Icon(Icons.delete_forever_rounded, color: Colors.redAccent,)),
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }
}