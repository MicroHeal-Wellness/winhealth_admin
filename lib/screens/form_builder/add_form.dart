import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winhealth_admin/provider/question_provider.dart';
import 'package:winhealth_admin/utils/helper_function.dart';

import '../../utils/constants.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final keyController = TextEditingController();
  final questionController = TextEditingController();
  final choiceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? choicedIcon;

  void addChoice(Choice choice, QuestionProvider questionProvider) {
    questionProvider.choices.add(choice);
    setState(() {});
  }

  void addQuestion(QuestionProvider questionProvider) {
    if (questionProvider.tempFormQuestion == null) {
      HelperFunctions.showToast("Please fill all the fields");
      return;
    }

    if (questionProvider.tempFormQuestion.type == "singleChoice" ||
        questionProvider.tempFormQuestion.type == "multiChoice") {
      if (questionProvider.choices.isEmpty) {
        HelperFunctions.showToast("Please add choices");
        return;
      }
    }

    final choice = questionProvider.choices;
    final formQuestion = FormBuilderQuestion(
      key: int.parse(keyController.text),
      type: questionProvider.tempFormQuestion.type,
      question: questionController.text,
      choices: choice.isEmpty ? null : choice,
    );
    questionProvider.addQuestion(formQuestion);
    HelperFunctions.showToast("Question Added");
    setToDefalut(questionProvider);
  }

  void deleteQuesiton(int index, QuestionProvider questionProvider) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.formQuestions.removeAt(index);
  }

  void setToDefalut(QuestionProvider questionProvider) {
    keyController.clear();
    questionController.clear();
    questionProvider.choices.clear();

    questionProvider.questionType = "text";
    setState(() {});
  }

  @override
  void dispose() {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    keyController.dispose();
    questionController.dispose();
    choiceController.dispose();
    questionProvider.questionType = "text";
    setToDefalut(questionProvider);

    questionProvider.choices.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(context, "Add Form"),
        body: Consumer<QuestionProvider>(
            builder: (context, questionProvider, child) {
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
                      questionProvider.formQuestions.isNotEmpty
                          ? questionListBuilder()
                          : const Text("No Questions Added"),
                      //create new or add existing button
                      const Spacer(),
                      createExistingButtons(),
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
                child: Consumer<QuestionProvider>(
                    builder: (context, questionProvider, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
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
                            controller: keyController,
                            decoration: InputDecoration(
                              hintText: "Enter Key",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter key";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(
                            height: 8,
                          ),
                          //question
                          const Text(
                            "Question*",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            maxLines: 5,
                            controller: questionController,
                            decoration: InputDecoration(
                              hintText: "Enter Question",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter question";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          //question type
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                value: questionProvider.tempFormQuestion.type,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    questionProvider
                                        .changeTypeOfTempFormQuesiton(
                                            newValue!);
                                    debugPrint(
                                        "Question Type: ${questionProvider.tempFormQuestion.type}");
                                  });
                                },
                                items: <String>[
                                  'text',
                                  'slider',
                                  'singleChoice',
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
                          //choices
                          questionProvider.tempFormQuestion.type ==
                                      "singleChoice" ||
                                  questionProvider.tempFormQuestion.type ==
                                      "multiChoice"
                              ? singleChoiceQuesitonChoiceBuilder(
                                  questionProvider)
                              : const SizedBox(),

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
                                  if (_formKey.currentState!.validate()) {
                                    //add question
                                    if ((keyController.text.isNotEmpty &&
                                        questionController.text.isNotEmpty)) {
                                      addQuestion(questionProvider);
                                    } else {
                                      HelperFunctions.showToast(
                                          "Please fill all the fields");
                                    }
                                  }
                                },
                                child: const Text("Add Question"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        }));
  }

  Column singleChoiceQuesitonChoiceBuilder(QuestionProvider questionProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choices*",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        questionProvider.choices.isNotEmpty
            ? Wrap(
                spacing: 8,
                runSpacing: 8,
                children: questionProvider.choices.map((choice) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Chip(
                      label: Text("${choice.label}"),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(
                          () {
                            questionProvider.choices.remove(choice);
                          },
                        );
                      },
                    ),
                  );
                }).toList())
            : const Text("No Choices Added"),
        //add choice
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
                //add choice
                //open dialog box to take choice input
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text("Add Choice Item"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Label*"),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: choiceController,
                              decoration: const InputDecoration(
                                hintText: "Enter Label",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            //icon picker
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    //pick icon
                                    choicedIcon =
                                        await HelperFunctions.pickFile();
                                    setState(() {});
                                  },
                                  child: const Text("Pick Icon")),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              choiceController.text.isNotEmpty
                                  ? addChoice(
                                      Choice(
                                        label: choiceController.text,
                                      ),
                                      questionProvider,
                                    )
                                  : null;
                              choiceController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      );
                    });
              },
              child: const Text("Add Choice"),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Container silderQuestionBuilder(QuestionProvider questionProvider) {
    return Container(
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
                  setState(() {});
                },
                items: <String>['text', 'slider', 'singlechoice', 'multiChoice']
                    .map<DropdownMenuItem<String>>((String value) {
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
    );
  }

  Row createExistingButtons() {
    return Row(
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
            Provider.of<QuestionProvider>(context, listen: false)
                .deselectQuestion();
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
    );
  }

  SizedBox questionListBuilder() {
    final size = MediaQuery.of(context).size;
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: true);
    return SizedBox(
      height: size.height / 2,
      child: ListView.builder(
        itemCount: questionProvider.formQuestions.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(
                  "${questionProvider.formQuestions[index].key}-${questionProvider.formQuestions[index].question}"),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    deleteQuesiton(index, questionProvider);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
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
