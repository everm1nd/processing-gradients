import controlP5.*;
import processing.sound.*;

ControlP5 cp5;
SinOsc[] oscillators = new SinOsc[3];

int SIZE = 750;
int SLIDER_MAX = 2000;

int periodicColor(int value, float period, float offset) {
  float p = TWO_PI/(SLIDER_MAX - period);
  float x = sin(value*p + offset);
  float y = map(x,-1,1,0,255);
  return round(y);
}

int periodicColor(int value, float period) {
  return periodicColor(value, period, 0);
}

void settings() {
  size(SIZE,SIZE);
}

void setup() {
  surface.setSize(SIZE, SIZE);
  
  initGui();
  initSound();
}

void initOscillator(int id, float freq) {
  oscillators[id] = new SinOsc(this);
  oscillators[id].freq(freq);
  oscillators[id].amp(0.5);
  oscillators[id].play();
}

void initSound() {
  initOscillator(0, 100.0);
  initOscillator(1, 100.2);
  initOscillator(2, 100.4);
}

void initGui() {
  cp5 = new ControlP5(this);
  
  cp5.addSlider("red")
     .setPosition(10,20)
     .setSize(100,20)
     .setRange(0,SLIDER_MAX)
     .setValue(500)
     ;
     
  cp5.addSlider("green")
     .setPosition(10,50)
     .setSize(100,20)
     .setRange(0,SLIDER_MAX)
     .setValue(20)
     ;
     
  cp5.addSlider("blue")
   .setPosition(10,80)
   .setSize(100,20)
   .setRange(0,SLIDER_MAX)
   .setValue(5)
   ;
}

void draw() {
  float redVal = cp5.getController("red").getValue();
  float greenVal = cp5.getController("green").getValue();
  float blueVal = cp5.getController("blue").getValue();
  
  oscillators[0].freq(redVal);
  oscillators[1].freq(greenVal);
  oscillators[2].freq(blueVal);
  
  for (int i = 0; i < SIZE; i = i + 1) {
    int red = periodicColor(i, redVal);
    int green = periodicColor(i, greenVal);
    int blue = periodicColor(i, blueVal);
    
    stroke(red, green, blue);
    line(0,i,SIZE,i);
  }
}

void randomize() {
  cp5.getController("red").setValue(random(0,2000));
  cp5.getController("green").setValue(random(0,2000));
  cp5.getController("blue").setValue(random(0,2000));
}

void keyPressed() {
  if (key == ' ') {
    randomize();
  } else if (key == 's') {
    saveFrame("image-####.png");
  }
}
