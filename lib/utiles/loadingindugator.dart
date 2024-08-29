
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget  loadingindigator({Color? color}){
  return Center(child: CircularProgressIndicator(color: color??Colors.white,),);
}