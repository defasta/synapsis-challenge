import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/option.dart';

class RadioList extends StatefulWidget {
  final List<OptionEntity> list;
  final void Function(int selectedIndex)? onSelectedIndex;

  RadioList(this.list, this.onSelectedIndex);

  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Flexible(
              child: ListView.separated(
            itemCount: widget.list.length,
            itemBuilder: (_, index) {
              String value = widget.list[index].optionName!;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio(
                      value: index,
                      groupValue: currentIndex,
                      activeColor: Color.fromARGB(255, 31, 160, 201),
                      onChanged: (flag) {
                        setState(() {
                          currentIndex = index;
                          if (widget.onSelectedIndex != null) {
                            widget.onSelectedIndex!(currentIndex);
                          }
                        });
                      }),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      value,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(
                height: 10,
              );
            },
          )),
        ],
      ),
    );
  }
}
