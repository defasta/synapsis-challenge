import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/option.dart';

class CheckboxList extends StatefulWidget {
  final List<OptionEntity> list;
  final void Function(String optionId)? onSelectedOption;

  CheckboxList(this.list, this.onSelectedOption);
  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  List<Map<String, dynamic>> dataList = [];
  List<String> selectedOptionIds = [];
  String selectedOption = '';
  @override
  void initState() {
    super.initState();
    widget.list.forEach((element) {
      dataList.add({
        "optionId": element.optionId,
        "optionName": element.optionName,
        "isChecked": false
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) => CheckboxListTile(
        activeColor: Color.fromARGB(255, 31, 160, 201),
        controlAffinity: ListTileControlAffinity.leading,
        value: dataList[index]["isChecked"],
        onChanged: (value) {
          setState(() {
            dataList[index]["isChecked"] = value!;
            if (value == false) {
              selectedOptionIds.remove(dataList[index]["optionId"]);
            } else {
              selectedOptionIds.add(dataList[index]["optionId"]);
            }
            print(selectedOptionIds);
            if (widget.onSelectedOption != null) {
              widget.onSelectedOption!(selectedOptionIds.join(','));
            }
            print(selectedOptionIds.join(','));
          });
        },
        title: Text(
          dataList[index]["optionName"],
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
