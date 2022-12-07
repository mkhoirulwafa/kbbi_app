import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<List<String>> {
  HomeCubit() : super(['']);

  void setResult(List<String> text) => emit(text);
}
