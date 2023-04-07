
import 'package:agenda_electronique/bloc/bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {

  // bloc en question
  final T bloc;

  // le child qui va s'occuper du bloc
  final Widget child;

  BlocProvider({
    required this.bloc,
    required this.child
  });

  // configurer le bloc
  static T? of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T>? provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider?.bloc;
  }


  @override
  State<StatefulWidget> createState() => _BlocProviderState();

}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

}