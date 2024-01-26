import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';

class AssessmentWidget extends StatelessWidget {
  final AssessmentEntity? assessment;
  final void Function(AssessmentEntity assessment)? onAssessmentPressed;
  final bool isSavedAssessment;

  const AssessmentWidget(
      {Key? key,
      this.assessment,
      this.onAssessmentPressed,
      required this.isSavedAssessment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 16, end: 16, bottom: 8, top: 8),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: 16, start: 16),
                  child: Image(
                      image: AssetImage('assets/images/ic_assessment.png')),
                ),
                _buildTextContent(),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: isSavedAssessment == false
                      ? Icon(
                          Icons.file_download_outlined,
                          size: 28,
                          color: Colors.black87,
                        )
                      : SizedBox(),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            assessment!.name ?? '-',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black87),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Created At: ${DateFormat('d MMM yyyy').format(DateTime.parse(assessment!.createdAt!))}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color.fromARGB(255, 38, 104, 40)),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Last Download: ${isSavedAssessment == true ? 'Today' : "-"}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color.fromARGB(255, 38, 104, 40)),
          ),
        ],
      ),
    ));
  }

  void _onTap() {
    if (onAssessmentPressed != null) {
      onAssessmentPressed!(assessment!);
    }
  }
}
