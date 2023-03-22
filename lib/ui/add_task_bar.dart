import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yourtodo/ui/my_themedata.dart';
import 'package:yourtodo/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime= "9.30";
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: Container(padding:const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task',
              style: titleStyle,),
              MyInputField(title: 'Title', hint: 'Enter your title'),
              MyInputField(title: 'Note', hint: 'Enter your note'),
              MyInputField(title: 'Title', hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined,
                color: Colors.grey,),
                onPressed: (){
                  _getDateFromUser();
                },
              ),),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded,
                          color: Colors.grey,),
                        onPressed: (){
                          _getTimeFromUser(isStartTime:true);
                        },
                      ),
                    )),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          icon: Icon(Icons.access_time_rounded,
                            color: Colors.grey,),
                          onPressed: (){
                            _getTimeFromUser(isStartTime:false);
                          },
                        ),
                      ))],
              )
            ],
          ),
        ),
      ),
    );
  }

  _customAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode? Colors.white: Colors.black,),
      ),
      actions: [
        CircleAvatar(backgroundImage: AssetImage('assets/images/profile.png'),),
        SizedBox(width: 20,)
      ],
    );
  }

  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2025));
    if(_pickerDate!=null){
      setState(() {
        _pickerDate = _selectedDate;
        print(_selectedDate);
      });
    }else {
      print("it's null or something wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time canceled");
    }else if(isStartTime==true){
      setState(() {
        _startTime= _formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime= _formatedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}