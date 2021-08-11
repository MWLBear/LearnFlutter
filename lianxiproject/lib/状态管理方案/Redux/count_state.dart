import 'package:flutter/material.dart';

/**
 * State中所有属性都应该是只读的
 */

@immutable
class CountState{
  int _count;
  get count => _count;
  CountState(this._count);

  CountState.initState(): _count = 0;
}
/**
 * 定义操作该State的全部Action
 * 这里只有增加count一个动作
 */

enum LZActions{ Increment }

//reducer是我们的状态生成器，它接收一个我们原来的状态，然后接收一个action，再匹配这个action生成一个新的状态。
/**
 * reducer会根据传进来的action生成新的CountState
 */
CountState reducer(CountState state, action){
  if(action == LZActions.Increment){
    return CountState(state.count + 1);
  }
  return state;
}