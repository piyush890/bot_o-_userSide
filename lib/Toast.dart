import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Custom_Toast{
    void toast_success(BuildContext context,String text,String description){
       MotionToast.success(
	title:  Text(text), description: Text(description),
).show(context);
  }
    void toast_error(BuildContext context,String text,String description){
       MotionToast.error(
	title:  Text(text), description: Text(description),
).show(context);
  }
    void toast_warning(BuildContext context,String text,String description){
       MotionToast.warning(
	title:  Text(text), description: Text(description),
).show(context);
  }
}