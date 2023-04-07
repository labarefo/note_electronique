
import 'package:agenda_electronique/bloc/_abstract_data_driver.dart';
import 'package:agenda_electronique/bloc/bloc.dart';
import 'package:agenda_electronique/models/item.dart';

class BlocItems extends Bloc {

  final itemsDriver = AbstractDataDriver<List<Item>>();

  final List<Item> _items = [];


  BlocItems(){
    itemsDriver.send(_items);
  }

  void addItem(String name) {
    _items.add(Item(id: _items.length, name: name));
    itemsDriver.send(_items);
  }

  void removeItem(int id) {
    _items.removeWhere((element) => element.id == id);
    itemsDriver.send(_items);
  }

  @override
  void dispose() {
    itemsDriver.close();
  }

}