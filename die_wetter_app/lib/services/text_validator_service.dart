import 'package:flutter_riverpod/flutter_riverpod.dart';

final textValidatorProvider =
    StateNotifierProvider<TextValidatorService, String>(
        (ref) => TextValidatorService());

class TextValidatorService extends StateNotifier<String> {
  TextValidatorService() : super('');

  //String isValid = '';

  void validateLocation(String name) {
    // at any time, we can get the text from _controller.value.text
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (name.isEmpty) {
      state = 'Can\'t be empty';
      //isValid = 'Can\'t be empty';
    }
    if (name.length < 4) {
      state = 'Too short';
      //isValid = 'Too short';
    }
    // return null if the text is valid
    state = 'null';
    //isValid = '';
  }
}
