import 'package:catefavor/core/model/meal_model.dart';
import 'package:catefavor/core/services/meal_requset.dart';
import 'base_view_model.dart';

class LZMealViewModel extends LZBaseViewModel {

  LZMealViewModel(){
    LZMealRequest.getMetalData().then((res){
      print("ret ; $res");
      meals = res;
    });
  }
}