import 'package:flutter/material.dart';
import 'package:winhealth_admin/screens/form_builder/add_form.dart';

class QuestionProvider with ChangeNotifier {
  FormBuilderQuestion? _selectedQuestion;

 FormBuilderQuestion? get selectedQuestion => _selectedQuestion;

  void selectQuestion(FormBuilderQuestion question) {
    _selectedQuestion = question;
    notifyListeners();
  }

  void deselectQuestion() {
    _selectedQuestion = null;
    notifyListeners();
  }
}