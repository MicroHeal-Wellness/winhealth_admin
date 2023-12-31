import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winhealth_admin/models/notes.dart';
import 'package:winhealth_admin/models/report.dart';
import 'package:winhealth_admin/services/base_service.dart';
import 'package:winhealth_admin/services/note_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class ReportsCard extends StatelessWidget {
  final Report report;
  const ReportsCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.4))),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Added on: ${(report.dateCreated).toString().split(".").first}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(),
          report.file != null
              ? Row(
                  children: [
                    Text(
                      "Attachment: ${report.file!.filenameDownload}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: () async {
                        await FileSaver.instance.saveFile(
                            name: report.file!.filenameDownload!,
                            link: LinkDetails(
                                link:
                                    "${BaseService.BASE_URL}/assets/${report.file!.id!}"));
                      },
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.download,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Download",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const Text(
            "Type:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "${report.type}",
          )
        ],
      ),
    );
  }
}
