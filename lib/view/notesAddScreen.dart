// ignore: file_names
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appbg,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstants.textColor2
        ),
        backgroundColor: AppConstants.appBARbg,
        title: Text(
          "Add Notes",
          style: headingText(AppConstants.textColor2, 36,
              shadowColor: AppConstants.textColor),
        ),
        elevation: 5,
        shadowColor: AppConstants.headingColor,
      ),
      body: SizedBox(
        child: Column(
          children: [
            TextField(
              
            )
          ],
        ),
      ),
    );
  }
}