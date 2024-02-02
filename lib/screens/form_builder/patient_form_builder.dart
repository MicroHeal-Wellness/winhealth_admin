import 'package:flutter/material.dart';
import 'package:winhealth_admin/screens/form_builder/add_form.dart';
import 'package:winhealth_admin/utils/constants.dart';

import '../../models/form_response.dart';

class PatientFormBuilder extends StatelessWidget {
  PatientFormBuilder({super.key});

  List<FormResponse> dummyFormResponses = List<FormResponse>.generate(
    6,
    (index) => FormResponse(
      id: 'id$index',
      userCreated: 'user$index',
      patient: 'patient$index',
      dateCreated: DateTime.now(),
      userUpdated: 'userUpdated$index',
      dateUpdated: 'dateUpdated$index',
      answers: List<Answer>.generate(
        3,
        (answerIndex) => Answer(
            // Fill this with the properties of your Answer class

            ),
      ),
      form: QuestionForm(
          // Fill this with the properties of your QuestionForm class
          ),
    ),
  );

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: dummyFormResponses.isEmpty
            ? Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No Forms Created Yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Click on the + button on the top right corner to create a new form",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return availableForm(index);
                },
                itemCount: dummyFormResponses.length,
              ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      
      title: const Text(
        "Patient Form Builder",
        softWrap: true,
        style: TextStyle(
          fontSize: 32,
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
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Add Form
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddForm()));
            },
            child: const Text(
              "Add Form",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  Container availableForm(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.4),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(dummyFormResponses[index].form?.name ?? "Form Name",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Last Updated: ${dummyFormResponses[index].dateUpdated?.toString().split(".").first.split("T").join(" ")}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            Text(
                "No of Questions: ${dummyFormResponses[index].answers?.length.toString().padLeft(2, "0")}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
      ),
    );
  }
}
