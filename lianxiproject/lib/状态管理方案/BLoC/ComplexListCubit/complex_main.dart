import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'complex_repository.dart';
import 'simple_bloc_observer.dart';
import 'complex_app.dart';

void main(){
  Bloc.observer = SimpleBlocObserver();
  runApp(App(repository:Repository()));
}