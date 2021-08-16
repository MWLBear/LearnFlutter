import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/../complex_list.dart';
import '../../complex_repository.dart';



class ComplexListPage extends StatelessWidget {
  const ComplexListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complex List")),
      body: BlocProvider(
        create: (_) => ComplexListCubit(
            repository: context.read<Repository>()
        )..fetchList(),
        child: ComplexListView(),
      ),
    );
  }
}

class ComplexListView extends StatelessWidget {
  const ComplexListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //要检索实例并订阅后续状态更改，请使用
     final state = context.watch<ComplexListCubit>().state;
    // final state1 = BlocProvider.of<ComplexListCubit>(context,listen: true).state;

    switch(state.status){
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return ItemView(items:state.items);
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

class ItemView extends StatelessWidget {
  final List<Item> items;
  const ItemView({Key? key,required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(child: Text("no content"))
        : ListView.builder(
      itemBuilder: (context,index){
        return ItemTile(item: items[index], onDeletePressed: (id){
          context.read<ComplexListCubit>().deleteIem(id);
        });
        },
      itemCount: items.length,
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
    required this.onDeletePressed,
  }) : super(key: key);

  final Item item;
  final ValueSetter<String> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text('#${item.id}'),
        title: Text(item.value),
        trailing: item.isDeleting
            ? const CircularProgressIndicator()
            : IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDeletePressed(item.id),
        ),
      ),
    );
  }
}