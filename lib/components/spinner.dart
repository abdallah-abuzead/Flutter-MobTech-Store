import 'package:flutter/material.dart';

showSpinner(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text('انتظر من فضلك ...'),
          content: Container(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    },
  );
}

showErrorDialog(context, String message) {
  return showDialog(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('حسنا'))
          ],
        ),
      );
    },
  );
}
