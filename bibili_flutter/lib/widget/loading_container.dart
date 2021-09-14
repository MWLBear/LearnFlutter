import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key? key,
      this.isLoading = false,
      this.cover = false,
      required this.child})
      : super(key: key);

  Widget get _loadingView {
    return Center(child: Lottie.asset("lib/assets/loading.json"));
  }

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [child, isLoading ? _loadingView : Container()],
      );
    } else {
      return isLoading ? _loadingView : child;
    }
  }
}
