import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/custom_picker/dropdown_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

Widget dropdownField(BuildContext context, TextEditingController controller, VoidCallback onChanges) {

  return Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 12, left: 14, bottom: 10, right: 14),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_drop_down_circle,
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextField(
                autofocus: false,
                readOnly: true,
                controller: controller,
                onChanged: (newValue) {
                  //model.value = newValue;
                  onChanges();
                },
                style: GoogleFonts.poppins().copyWith(fontSize: 14, color: Colors.black),
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]!)),
                    errorStyle: GoogleFonts.poppins().copyWith(fontSize: 11, color: Colors.red),
                    // errorText: model.isError != null && model.isError!
                    //     ? 'field_required'.tr
                    //     : null,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]!)),
                    contentPadding: const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 12),
                    suffixIcon: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        controller.text.isEmpty ? const SizedBox(width: 12) :
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.cancel, size: 20,),
                        ).onTap(() {
                          // model.isAltered = true;
                          // model.value = '';
                          controller.clear();
                          onChanges();
                        }),
                        Container(
                          padding: const EdgeInsets.only(right: 12),
                          child: const Icon(Icons.arrow_drop_down),
                        ).onTap(() {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          showDialog(
                              context: context,
                              builder: (context) => const DropdownPicker(['LIST OF ITEM SELECTION'], 'CHANGE TO DYNAMIC LABEL'),
                              barrierDismissible: true)
                              .then((newValue) {

                            if (newValue != null && newValue is int) {
                              // model.isAltered = true;
                              // model.value = ['LIST OF ITEM SELECTION'][newValue];
                              // model.isError = false;
                              controller.text = ['LIST OF ITEM SELECTION'][newValue];
                              onChanges();
                            }
                          });
                        })
                      ],
                    )
                )
            ),
            Row(
              children: [
                SizedBox(
                  width: controller.text.isNotEmpty ? MediaQuery.of(context).size.width - 98 : MediaQuery.of(context).size.width - 28,
                  height: 42,
                ).onTap(() {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }


                  //REMOVE DROPDOWN
                  showDialog(
                      context: context,
                      builder: (context) => const DropdownPicker(['lLIST OF ITEM SELECTION'], 'CHANGE TO DYNAMIC LABEL'),
                      barrierDismissible: true)
                      .then((newValue) {

                    if (newValue != null && newValue is int) {
                      // model.isAltered = true;
                      // model.value = ['LIST OF ITEM SELECTION'][newValue];
                      // model.isError = false;
                      controller.text = ['LIST OF ITEM SELECTION'][newValue];
                      onChanges();
                    }
                  });
                }),
              ],
            )
          ],
        ),
      )
    ],
  );
}
