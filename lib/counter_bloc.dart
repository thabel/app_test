
import 'package:hydrated_bloc/hydrated_bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  CounterBloc() : super(65) {
    on<CounterIncrementPressed>((event, emit) {
     if (state > (65 + 25)) // last later in alpahbet then
    {
      return emit(65);
    }
    return emit((state + 1));
    });
  }

   @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
  
}
