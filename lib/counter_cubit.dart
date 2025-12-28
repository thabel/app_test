import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(65); // letter A

  void increment() {
    if (state == (65 + 25)) // last later in alpahbet then
    {
      return emit(65);
    }
    return emit((state + 1));
  }

  void decrement() {
    if (state == 65) {
      return emit(state + 25);
    }

    return emit(state - 1);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    if (kDebugMode) {
      print("this change  $state");
    }
  }
}
