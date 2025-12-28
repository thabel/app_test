
import 'package:hydrated_bloc/hydrated_bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  CounterBloc() : super(65) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });
  }

   @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
  
}
