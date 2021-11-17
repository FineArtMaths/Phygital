/*
  Skeleton sketch that can read data from the serial port
*/

import processing.serial.*;
Serial port;

void setup(){
  size(1, 1);
  print(Serial.list());
  String pt = Serial.list()[0];
  port = new Serial(this, pt, 9600);
}

void draw(){
  int inByte = -1;
  String res = "";
  while(port.available() > 2){
    inByte = port.read();
    res += char(inByte);
  }
  res = res.replace("\n", "");
  if(res.length() > 0){
    println("[" + res + "]");
  } else{
  }
}
