import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winhealth_admin/provider/question_provider.dart';

import '../../utils/constants.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final List<FormBuilderQuestion> formQuestions = [
    //dummy data
    FormBuilderQuestion(
      key: 1,
      type: 'text',
      question: 'What is your name?',
    ),
    FormBuilderQuestion(
      key: 2,
      type: 'slider',
      question: 'How old are you?',
    ),
    FormBuilderQuestion(
      key: 3,
      type: 'singlechoice',
      question: 'Which is your favourite color?',
      choices: [
        Choice(label: 'Choice 1'),
        Choice(label: 'Choice 2'),
        Choice(label: 'Choice 3'),
      ],
    ),
    FormBuilderQuestion(
      key: 4,
      type: 'multiChoice',
      question: 'Which are your favourite colors?',
      choices: [
        Choice(label: 'Choice 1'),
        Choice(label: 'Choice 2'),
        Choice(label: 'Choice 3'),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(context, "Add Form"),
        body: Consumer<QuestionProvider>(
          builder: (context,questionProvider,child) {
            return Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: SizedBox(
                    width: size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //form Name
                        tiltleTextFeild(),
                        //list of added and existing questions
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Questions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        formQuestions.isNotEmpty
                            ? SizedBox(
                                height: size.height / 2,
                                child: ListView.builder(
                                  itemCount: formQuestions.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: ListTile(
                                        title: Text(
                                            "${formQuestions[index].key}-${formQuestions[index].question}"),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            setState(() {
                                              formQuestions.removeAt(index);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const Text("No Questions Added"),
                        //create new or add existing button
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                //create new question
                                 Provider.of<QuestionProvider>(context, listen: false).deselectQuestion();
                              },
                              child: const Text("Create New"),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //add existing question
                              },
                              child: const Text("Add Existing"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                //to get data from new question or existing question
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "New Question",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //key of question
                        const Text("key*",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Key",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //question type
                        Row(
                          children: [
                            const Text(
                              "Type",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            DropdownButton<String>(
                              value: "text",
                              onChanged: (String? newValue) {
                                // setState(() {
                                //   dropdownValue = newValue!;
                                // });
                              },
                              items: <String>[
                                'text',
                                'slider',
                                'singlechoice',
                                'multiChoice'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.toUpperCase()),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //question
                        const Text(
                          "Question",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Enter Question",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // //choices
                        // const Text(
                        //   "Choices",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // TextFormField(
                        //   maxLines: 5,
                        //   decoration: InputDecoration(
                        //     hintText: "Enter Choices",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        //add question button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                //add question
                              },
                              child: const Text("Add Question"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ));
  }

  Widget tiltleTextFeild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name*",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Enter Form Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context, String title) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(2),
        child: Divider(
          color: Colors.grey,
          thickness: 2,
        ),
      ),
    );
  }
}

class Choice {
  final String label;
  IconData? icon;

  Choice({required this.label, this.icon});
}

// class QuestionWidget extends StatelessWidget {
//   final FormQuestionId question;

//   QuestionWidget({required this.question});

//   @override
//   Widget build(BuildContext context) {
//     switch (question.type) {
//       case 'text':
//         return TextQuestionWidget(question: question);
//       // case 'slider':
//       //   return SliderQuestionWidget(question: question);
//       // case 'singlechoice':
//       //   return SingleChoiceQuestionWidget(question: question);
//       // case 'multiChoice':
//       //   return MultiChoiceQuestionWidget(question: question);
//       default:
//         return Text('Unknown question type');
//     }
//   }
// }

class FormBuilderQuestion {
  final int key;
  final String type;
  final String question;
  final List<Choice>? choices;

  FormBuilderQuestion({
    required this.key,
    required this.type,
    required this.question,
    this.choices,
  });
}

// class TextQuestionWidget extends StatelessWidget {
//   final FormBuilderQuestion question;

//   TextQuestionWidget({required this.question});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: question.label,
//         hintText: question.hint,
//       ),
//     );
//   }
// }

// class SliderQuestionWidget extends StatefulWidget {
//   final Question question;

//   SliderQuestionWidget({required this.question});

//   @override
//   _SliderQuestionWidgetState createState() => _SliderQuestionWidgetState();
// }

// class _SliderQuestionWidgetState extends State<SliderQuestionWidget> {
//   double _value = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(widget.question.label),
//         Slider(
//           value: _value,
//           onChanged: (value) {
//             setState(() {
//               _value = value;
//             });
//           },
//         ),
//         Text(_value.toString()),
//       ],
//     );
//   }
// }

// class SingleChoiceQuestionWidget extends StatefulWidget {
//   final Question question;

//   SingleChoiceQuestionWidget({required this.question});

//   @override
//   _SingleChoiceQuestionWidgetState createState() =>
//       _SingleChoiceQuestionWidgetState();
// }
// class _SingleChoiceQuestionWidgetState
//     extends State<SingleChoiceQuestionWidget> {
//   Choice? _selectedChoice;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(widget.question.label),
//         ...widget.question.choices.map((choice) {
//           return RadioListTile(
//             title: Text(choice.label),
//             value: choice,
//             groupValue: _selectedChoice,
//             onChanged: (value) {
//               setState(() {
//                 _selectedChoice = value as Choice?;
//               });
//             },
//           );
//         }).toList(),
//       ],
//     );
//   }
// }

// class MultiChoiceQuestionWidget extends StatefulWidget {
//   final Question question;

//   MultiChoiceQuestionWidget({required this.question});

//   @override
//   _MultiChoiceQuestionWidgetState createState() =>
//       _MultiChoiceQuestionWidgetState();
// }
// class _MultiChoiceQuestionWidgetState
//     extends State<MultiChoiceQuestionWidget> {
//   List<Choice> _selectedChoices = [];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(widget.question.label),
//         ...widget.question.choices.map((choice) {
//           return CheckboxListTile(
//             title: Text(choice.label),
//             value: _selectedChoices.contains(choice),
//             onChanged: (value) {
//               setState(() {
//                 if (value == true) {
//                   _selectedChoices.add(choice);
//                 } else {
//                   _selectedChoices.remove(choice);
//                 }
//               });
//             },
//           );
//         }).toList(),
//       ],
//     );
//   }
// }
