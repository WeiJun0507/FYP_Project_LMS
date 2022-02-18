import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';


Widget textInputField(TextEditingController controller, VoidCallback onChanges){

  return Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 12, left: 14, bottom: 10, right: 14),
        child: Row(
          children: [
            const Icon(
              Icons.feed,
              color: Colors.grey,
              size: 18,
            ),
            const SizedBox(width: 10),
            Flexible(
              //CHECK IF REQUIRED
              child: RichText(
                text: TextSpan(
                  //TODO: CHANGE TO DYNAMIC LABEL
                  text: 'INPUT TEXT LABEL',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey),
                  children: [
                    TextSpan(
                        text: '*',
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.red),
                        )),
                  ]))
            )
                    // : text(model.label ?? '-',
                    // style: TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 12,
                    //     color: Colors.grey)))
          ],
        ),
      ),
      Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 14, bottom: 7, right: 14),
        child: Focus(
          onFocusChange: (hasFocus){
            //CHANGE FOCUS
            //model.isFocus = hasFocus;
            onChanges();
          },
          child: TextField(
            controller: controller,
            onChanged: (newValue){
              // model.value = newValue;
              // model.isAltered = true;
              // if(newValue.isNotEmpty){
              //   model.isError = false;
              // }
              onChanges();
            },
            style: GoogleFonts.poppins().copyWith(
              fontSize: 14, color: Colors.black
            ),
            minLines: 1,
            maxLines: 1,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                fillColor: null, //editable ? null : Colors.grey[100],
                filled: false, // !editable,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[200]!)
                ),
                // errorStyle: GoogleFonts.poppins().copyWith(
                //   fontSize: 11, color: Colors.red
                // ),
                // errorText: model.isError != null && model.isError! ? 'field_required'.tr : null,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[200]!)
                ),
                contentPadding: const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 12),
                suffixIcon: //controller.text.isEmpty || (model.isFocus == null || !model.isFocus!) ? null :
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.cancel),
                  onPressed: (){
                    controller.clear();
                    // model.isAltered = true;
                    // model.value = '';
                    onChanges();
                  },
                )
            ),
          ),
        ),
      ),
    ],
  );
}