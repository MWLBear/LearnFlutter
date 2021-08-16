
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complex_repository.dart';
import 'complex_list/complex_list.dart';

class App extends MaterialApp {
  App({required Repository repository})
      : super(
    //RepositoryProvider 将存储库的单个实例提供给子树中的多个小部件
    home: RepositoryProvider(
      create: (context) => repository,
      child: const ComplexListPage(),
    )


    // RepositoryProvider.value(
    //     value: repository,
    //   child: const ComplexListPage(),
    // )
  );
}
/**
 * 存储库提供者
    RepositoryProvider是一个 Flutter 小部件，它通过RepositoryProvider.of<T>(context).
    它用作依赖注入 (DI) 小部件，以便可以将存储库的单个实例提供给子树中的多个小部件。
    BlocProvider应该用于提供块，而RepositoryProvider应该只用于存储库。

    RepositoryProvider(
      create: (context) => RepositoryA(),
      child: ChildA(),
    );
    然后ChildA我们可以使用以下方法检索Repository实例：

    // with extensions
    context.read<RepositoryA>();

    // without extensions
    RepositoryProvider.of<RepositoryA>(context)
 *
 *
 *
 *
 * */