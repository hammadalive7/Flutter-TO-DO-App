import 'package:flutter/material.dart';
import 'package:flutter_to_do/UI/theme.dart';
import 'package:flutter_to_do/UI/widgets/button.dart';
import 'package:flutter_to_do/UI/widgets/inout_field.dart';
import 'package:flutter_to_do/controllers/task_controller.dart';
import 'package:flutter_to_do/models/tasks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectdDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList=[5,10,15,20];
  String _selectedRepeat = "None";
  List<String> repeatList=["None","Daily","Weekly","Monthly"];
  int _selectedColor=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: HeadingStyle,
              ),
              MyInputField(title: "Title", hint: "Enter your title", controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter your note",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectdDate),
              widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                color: Colors.grey,
                onPressed: (){
                  _getDateFromUser();
                },
              )
              ), //DateFormat.yMd().format(_selectdDate) this will return string
              Row(
                children: [
                  Expanded(child: MyInputField(
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: Icon(Icons.access_time_rounded,
                      color: Colors.grey,),
                    ),
                  )),
                  SizedBox(width: 12.0,),
                  Expanded(child: MyInputField(
                    title: "End Time",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: Icon(Icons.access_time_rounded,
                      color: Colors.grey,),
                    ),
                  ))
                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0,),
                  style: subTitleStyle,

                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                        child: Text(value.toString()) );
                  }).toList(),
                  onChanged: (String? newvalue) {
                    setState((){
                      _selectedRemind = int.parse(newvalue!);

                    });
                  },



                ),

              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0,),
                  style: subTitleStyle,

                  items: repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                        child: Text(value!, style:TextStyle(color: Colors.grey)) );
                  }).toList(),
                  onChanged: (String? newvalue) {
                    setState((){
                      _selectedRepeat = newvalue!;

                    });
                  },



                ),

              ),
              SizedBox(height: 18.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Task", onTap: ()=>_validateData()),
                ],
              ),
              SizedBox(height: 20,),


            ],

          ),

        ),

      ),

    );
  }


  _validateData(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      //add to database
      _addTaskToDB();
      Get.back();
    }
    else if(_titleController.text.isEmpty||_noteController.text.isEmpty){
      Get.snackbar("Required", "All fields are required !",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: pinkClr,
      icon: Icon(Icons.warning_amber_rounded, color: pinkClr,));
    }
  }

  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: titleStyle,),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(3, (index){
            return GestureDetector(
              onTap: (){

                setState((){
                  _selectedColor=index;

                });

              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index==0?PrimaryClr:index==1?pinkClr:yellowClr,
                  child: _selectedColor==index?Icon(Icons.done, color: Colors.white,size: 16,):Container(),
                ),
              ),
            );
          }
          ),
        )
      ],

    );
  }
  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2121)

    );
    if(_pickerDate!=null){
      setState((){
        _selectdDate = _pickerDate;
      });
    }
    else{
      print("Something wrong");
    }
  }

  _appbar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode? Colors.white:Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/appicon.jpg"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );

  }

  _getTimeFromUser({required bool isStartTime}) async {

    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time Canceled");
    }
    else if(isStartTime==true){
      setState((){
        _startTime = _formatedTime;
      });
    }
    else if(isStartTime==false){

      setState((){
        _endTime = _formatedTime;
      });
    }

  }

  _showTimePicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //_startTime --> 10:30 AM
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));

  }


  _addTaskToDB() async {
    int value = await _taskController.addTask(
        task:Task(
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectdDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        )

    );
    print("My id is "+"$value");

  }

}
