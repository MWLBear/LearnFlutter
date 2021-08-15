part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}
class TimerPaused extends TimerEvent {
  const TimerPaused();
}
class TimerResumed extends TimerEvent {
  const TimerResumed();
}
class TimerReset extends TimerEvent {
  const TimerReset();
}
//通知 TimerBloc 发生了一个滴答，需要相应地更新其状态
class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

