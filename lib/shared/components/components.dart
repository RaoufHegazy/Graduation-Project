import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton(
        {Color color = Colors.blue,
        double width = double.infinity,
        @required String? text,
        bool isUpperCase = true,
        @required VoidCallback? function,
        double? font}) =>
    Container(
      color: Colors.blue,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: TextStyle(fontSize: font, color: Colors.white),
        ),
      ),
    );

// text form field
Widget Default_Text_Form_Field(
        {@required TextInputType? type,
        @required TextEditingController? controller,
        @required String? label_text,
        @required Icon? prefix,
        @required FormFieldValidator? validate,
        ValueChanged? onfield,
        ValueChanged? onchange,
        Color? color,
        TextStyle? style,

        //password
        bool ispassword = false,
        IconData? suffix,
        VoidCallback? SuffixPressed,
        VoidCallback? ontap}) =>
    TextFormField(
      style: style,
      cursorColor: color,
      onTap: ontap,
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      validator: validate,
      onFieldSubmitted: onfield,
      onChanged: onchange,
      decoration: InputDecoration(
        labelText: label_text,
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: SuffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget default_text_button(
        {@required VoidCallback? function,
        @required String? text,
        Color? color,
        double? font,
        FontWeight? fontweight}) =>
    TextButton(
        onPressed: function,
        child: Text(text!,
            style: TextStyle(
                color: color ?? Colors.lightBlueAccent,
                fontSize: font,
                fontWeight: fontweight)));

//divider
Widget divider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );

Widget divider2() => Container(
  width: 1,
  height: double.infinity,
  color: Colors.grey,
);


//article

//navigator

void navigate_to(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigate_and_finish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

// toast

void flutter_toast({required String? message, required toast_state state}) =>
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: change_color_toast(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum toast_state { SUCCESS, ERROR, WARNING }

Color change_color_toast(toast_state state) {
  Color color;

  switch (state) {
    case toast_state.SUCCESS:
      color = Colors.green;
      break;
    case toast_state.ERROR:
      color = Colors.red;
      break;
    case toast_state.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

// scaffold messenger

void scaffold_messenger({required context, required String text}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
      backgroundColor: Colors.blue,
      elevation: 8.0,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ));

// drop down search && awesome_dropdown
// u can make return type Widget

Widget drop_down_search(
        {required String selected_item,
        required List<String> selected_list,
        required String message,
        required String label_text,
        required ValueChanged<String?> function}) =>
    Stack(
      children: [
        DropdownSearch<String>(
          dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          )),
          selectedItem: selected_item,
          items: selected_list,
          validator: (value) {
            if (value!.isEmpty) {
              return message;
            }
            return null;
          },
          onChanged: function,
        ),
        if (selected_item.isEmpty)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                label_text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
      ],
    );

Widget awesome_dropdown({
  required String selected_item,
  required List<String> selected_list,
  required String message,
  required String label_text,
  required ValueChanged<String?> function,
}) =>
    Container(
      alignment: Alignment.topLeft,
      height: 50,
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            left: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            right: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          borderRadius: BorderRadius.circular(5)),
      child: AwesomeDropDown(
        selectedItem: selected_item,
        dropDownList: selected_list,
        onDropDownItemClick: function,
        padding: 5,
        dropDownBGColor: Colors.transparent,
        elevation: 0,
        selectedItemTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
        dropDownListTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          height: 1.5,
          color: Colors.white,
        ),
        dropDownOverlayBGColor: Colors.brown,
      ),
    );

// my dialog

void my_dialog({
  required context,
  required String title_of_dialog,
  required String edited_text,
  required String hint_text_TF,
  required ValueChanged function_TF,
  required  ValueChanged<String> update_method,
})=> showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title_of_dialog),
        content: TextField(
          onChanged: function_TF,
          controller: TextEditingController(text: edited_text),
          decoration: InputDecoration(hintText: hint_text_TF),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {

              update_method(edited_text); // Invoke the update_method function with the edited_text value;

              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
