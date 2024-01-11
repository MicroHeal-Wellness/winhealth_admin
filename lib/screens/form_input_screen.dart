// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winhealth_admin/models/form_response.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/questionare_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class FormInputScreen extends StatefulWidget {
  final UserModel patient;
  final QuestionForm form;
  const FormInputScreen({super.key, required this.form, required this.patient});

  @override
  State<FormInputScreen> createState() => _FormInputScreenState();
}

class _FormInputScreenState extends State<FormInputScreen> {
  bool showbtn = false;
  bool loading = false;
  List<TextEditingController> answersController = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    getInitData();
  }

  getInitData() {
    setState(() {
      loading = true;
    });
    answersController =
        List.generate(widget.form.questions!.length, (int index) {
      return TextEditingController();
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(0.4),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: showbtn ? 1.0 : 0.0,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const BackButton(),
                        const SizedBox(
                          width: 32,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Add ${widget.patient.firstName}'s response for Form: ${widget.form.name}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.form.questions![index].formQuestionId!
                                    .question!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: answersController[index],
                                validator: (value) {
                                  return (value!.isNotEmpty || value != null)
                                      ? null
                                      : "Response is required";
                                },
                                minLines: 5,
                                maxLines: 15,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Response',
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: widget.form.questions!.length,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        var payload = [];
                        for (int i = 0; i < answersController.length; i++) {
                          payload.add({
                            "form_answers_id": {
                              "question":
                                  widget.form.questions![i].formQuestionId!.id,
                              "response": [answersController[i].text]
                            }
                          });
                        }
                        bool resp = await QuestionareService.addFormResponse({
                          "form": widget.form.id,
                          "patient": widget.patient.id,
                          "answers": payload
                        });
                        if (resp) {
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg:
                                  "Response Added");
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Please try again later, something went wrong");
                        }
                      },
                      color: primaryColor,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Add Response ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
