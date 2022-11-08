import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();

  String _startTime = DateFormat("hh:mm aa").format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Add Task",
              style: headingStyle,
            ),
            MyInputField(title: "Title", hint: "Enter yout title"),
            MyInputField(title: "Note", hint: "Enter yout note"),
            MyInputField(
              title: "Date",
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _getDateFromUSer();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                  title: "Start Date",
                  hint: _startTime,
                  widget: IconButton(
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getTimeFromUser(true);
                    },
                  ),
                )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: MyInputField(
                  title: "End Date",
                  hint: _endTime,
                  widget: IconButton(
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getTimeFromUser(false);
                    },
                  ),
                ))
              ],
            )
          ]),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getDateFromUSer() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2124));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("not selced");
    }
  }

  _getTimeFromUser(bool isStartTime) async {
    var _pickedTime = await _showTimePicker();

    String _formatedTime = _pickedTime?.format(context);

    if (_pickedTime == null) {
      print("Tie cancelled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
  }
}
