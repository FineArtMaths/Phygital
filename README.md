# Phygital
This project contains code to support Camberwell 2022 projects

## HC-SR04 "Hello World" Setup

You will need:
* Any Arduino
* An HC-SR04 sensor
* Some male-to-female jumper cables to connect them up
* A computer with a USB port, with Processing installed
* A USB cable to connect the arduino to the computer

The steps for an initial setup are:
* Wire up the HC-SR04 to the Arduino as per this tutorial: https://create.arduino.cc/projecthub/abdularbi17/ultrasonic-sensor-hc-sr04-with-arduino-tutorial-327ff6
* Connect the Arduino to the computer
* Use the Arduino IDE to upload SR04_Sensor.ino to the Arduino
* Test this using the serial monitor, which should give the distance reading from the sensor (try moving your hand in front of it)
* Close the Arduino IDE
* Open ArduinoSerial.pde in Processing
* Run the sketch and you should see the same numbers now appearing in the console at the bottom of the window.

Granulator.pde gives an example of audio processing using these numbers to control the sketch, but some simpler and more visual examples are coming.

## Links
Here are some miscellaneous links that might prove useful:

* HC-SR04 basic tutorial: https://create.arduino.cc/projecthub/abdularbi17/ultrasonic-sensor-hc-sr04-with-arduino-tutorial-327ff6
* HC-SR04 tuning / troubleshooting tips: https://www.intorobotics.com/8-tutorials-to-solve-problems-and-improve-the-performance-of-hc-sr04/
* NewPing library: https://bitbucket.org/teckel12/arduino-new-ping/wiki/Home
* Flickr API docs: https://www.flickr.com/services/api/
* Flickr4Java, if we need Processing to connect to Flickr: https://github.com/boncey/Flickr4Java
* Max/MSP can be used to interface MIDI with video: https://docs.cycling74.com/max7/tutorials/jitterchapter26. An Arduino can be turned into a MIDI controller for this purpose (and of course programmed however we like): https://www.youtube.com/watch?v=s-gcZ61Dj5g
