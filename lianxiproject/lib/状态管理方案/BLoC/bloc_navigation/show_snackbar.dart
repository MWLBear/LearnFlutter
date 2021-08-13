import 'package:flutter/material.dart';
import 'package:lianxiproject/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86%E6%96%B9%E6%A1%88/BLoC/Stream/main.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//DataEvent
@immutable
abstract class DataEvent {}
class FetchData extends DataEvent {}

//DataState
@immutable
abstract class DataState {}
class Initial extends DataState {}
class Loading extends DataState {}
class Success extends DataState {}

//DataBlock
class DataBlock extends Bloc<DataEvent,DataState>{
  DataBlock(): super(Initial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if(event is FetchData){
      yield Loading();
      await Future.delayed(Duration(seconds: 2));
      yield Success();
    }
  }
}

//UILayer
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx)=>DataBlock(),
      child: MaterialApp(home: MyHome()),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BlocListener<DataBlock,DataState>(
          listener: (ctx,state){
            print("sate: $state");
            if (state is Success){
              ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Success"),
                ),
              );
            }
        },
        child: BlocBuilder<DataBlock,DataState>(
          builder: (ctx,state){
            if (state is Initial) {
              return Center(child: Text('Press the Button'));
            } else if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Success'));
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: (){
              BlocProvider.of<DataBlock>(context).add(FetchData());
            },
          ),
        ],
      ),
    );
  }
}









