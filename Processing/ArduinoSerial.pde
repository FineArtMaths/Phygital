import processing.serial.*;
Serial port;
boolean state = false;
int num_indications = 0;
int ind_threshold = 5;

void setup(){
  size(displayWidth, displayHeight);
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
  res = trim(res);
  int val = -1;
  if(res.length() > 0){
    try{
      val = Integer.parseInt(res);
    } catch (NumberFormatException e){
      val = -1;
    }    
    println(val);
    if(val > -1){
      if(val > 0){
        if(val < 100 && !state){
          num_indications++;
        } else if (val >= 100 && state) {
          num_indications++;
        }
      }
    }
    if(num_indications > ind_threshold){
      num_indications = 0;
      state = !state;
      change_state();
    }
  }
}

void change_state(){
    color c = color(0, 0, 0);
    if(state){
      c = color(255, 0, 0);
    } else {
      c = color(0, 255, 0);
    }
    background(c);
}
