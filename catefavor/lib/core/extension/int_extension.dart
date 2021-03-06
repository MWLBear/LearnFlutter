import 'package:catefavor/ui/shared/size_fit.dart';

extension IntFit on int {
  double get px {
    return LZSizeFit.setPx(this.toDouble());
  }
  
  double get rpx {
    return LZSizeFit.setRpx(this.toDouble());
  }
}