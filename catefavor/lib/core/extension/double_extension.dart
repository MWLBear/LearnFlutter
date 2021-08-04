import 'package:catefavor/ui/shared/LZSizeFit.dart';

extension DoubleFit on double {
  double get px {
    return LZSizeFit.setPx(this);
  }

  double get rpx {
    return LZSizeFit.setRpx(this);
  }
}
