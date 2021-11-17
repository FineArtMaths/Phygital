/*
  Granular wind chimes
*/

import processing.sound.*;
import java.util.concurrent.TimeUnit;
import processing.serial.*;

SoundFile[] file;
int max_grains = 2;
float dur;
int grain_num = 0;
float position[];
float playhead[];
int amp[];
float gs[];
float radius = 1;

Serial port;
int max_dist = 200;

void setup() {
  size(1540, 860);

  String pt = Serial.list()[0];
  port = new Serial(this, pt, 9600);
  file = new SoundFile[max_grains];
  position = new float[max_grains];
  gs = new float[max_grains];
  playhead = new float[max_grains];
  for(int i = 0; i < max_grains; i++){
    file[i] = new SoundFile(this, "12pq_partch.wav");
    dur = file[i].duration();
    thread("grain");
    try{
      TimeUnit.MILLISECONDS.sleep(1);
    } catch(InterruptedException e){
      print("Interrupted");
    }
  }
  noStroke();
  background(0);
}      

int lastPress = 0;
float ang = 0.0;
float speed = 0.001;
void draw() {
  // Update the grains
  ang += speed;
  if(ang > TWO_PI){
    ang -= TWO_PI;
  }
  float r = readSerial();
  if(r > 0){
    speed = 5/pow(r, 2);
    println(r, speed);
  }
  float xval = sin(ang + ang*cos(ang/3.11)) * cos(sin(ang) * TWO_PI) * width /2 + width / 2;
  xval *= radius;
  float yval = cos(ang + sin(ang * 2.1)) * height /3 + height / 2;
  yval *= radius;
  float range = map(yval, 0, height, 10, 1000);
  float gs_min = map(xval, 0, width, 0.1/range, 5 / range);
  float gs_max = map(xval, 0, width, gs_min, gs_min * range);
  for(int i = 0; i < max_grains; i++){
    gs[i] = gs[i] + sin(ang) * 10;  
    if(xval < 20){ 
      position[i] = random(0, dur - gs[i]/1000 - 1);  // seconds
    }
  //  position[i] = map(ang, 0, TWO_PI, max(0, position[i] - 1), min(position[i] + 1, dur - gs[i]/1000 - 1));  
  }
  lastPress = frameCount;
  
  // Visuals
  
  background(0);
  fill(0, 5);
  rect(0, 0, width, height);
  fill(255, 200);
  for(int i = 0; i < max_grains; i++){
    float siz = gs[i]/10;
    float x = map(position[i] * 1000 + playhead[i], 0, dur * 1000,siz, width - siz);
    float y = map(i, 0, max_grains, siz, height - siz);
    circle(x, y, siz);
  }
  fill(0, 255, 0, 200);
  circle(xval, yval, 10);
  
}

void grain(){
  int gn = grain_num;
  grain_num++;
  gs[gn] = random(0.001, 1) * 1000;  // milliseconds
  position[gn] = random(0, dur - gs[gn]/1000 - 1);  // seconds
  int last_jump = millis();
  int curr = 0;
  float ljgs = last_jump + gs[gn];
  playhead[gn] = 0;
  while(true){
    curr = millis();
    if(curr >= ljgs){
      last_jump = curr;
      file[gn].jump(position[gn]);
      ljgs = last_jump + gs[gn];
      playhead[gn] = 0;
    } else {
      playhead[gn] = curr - last_jump;
    }
  }
}

float readSerial(){
  int inByte = -1;
  String res = "";
  float c = -1;
  while(port.available() > 2){
    inByte = port.read();
    res += char(inByte);
  }
  if(res.length() > 0){
    res = res.replace("\n", "");
    float dist = float(res);
    c = map(dist, 0, max_dist, 0, 255);
  }
  return c;
}
