import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<List<String>> {
  CounterCubit() : super(['']);

  void setResult(List<String> text) => emit(text);
}
