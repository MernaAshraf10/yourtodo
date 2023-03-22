import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yourtodo/services/notify_helper.dart';
import 'package:yourtodo/services/theme_service.dart';
import 'package:yourtodo/ui/add_task_bar.dart';
import 'package:yourtodo/ui/my_themedata.dart';
import 'package:yourtodo/widgets/button.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper= NotifyHelper();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: Column(
        children: [
         _addTaskBar(),
         _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar(){
    return Container(margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        /*dayTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                ),
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                ),
              ),*/
        onDateChange: (date){
          _selectedDate=date;
        },
      ),
    );
  }

  _addTaskBar(){
    return  Container(margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,),
                Text('Today',
                  style: headingStyle,
                ),
              ],),
          ),
          MyButton(label: "+ Add Task", onTap: ()=>Get.to(AddTaskPage()))
        ],),
    );
  }

  _customAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "The Theme changed",
              body: Get.isDarkMode? "Activated Dark Theme": "Activated Light Theme"
          );
          notifyHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode? Icons.wb_sunny_outlined :Icons.nightlight_round,
          size: 20,
        color: Get.isDarkMode? Colors.white: Colors.black,),
      ),
      actions: [
        CircleAvatar(backgroundImage: AssetImage('assets/images/profile.png'),),
        SizedBox(width: 20,)
      ],
    );
  }
}