import controlP5.*;

ControlP5 cp5;

int SIZE = 750;

int periodicColor(int value, float period, float offset) {
  float p = TWO_PI/period;
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
  initGui();
  surface.setSize(SIZE, SIZE);
}

void initGui() {
  cp5 = new ControlP5(this);
  
  int SLIDER_MAX = 2000;
  
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
  float a = 0.0;
  float period = TWO_PI/250.0;
  
  for (int i = 0; i < SIZE; i = i + 1) {
    float x = sin(i*period);
    
    float redVal = cp5.getController("red").getValue();
    float greenVal = cp5.getController("green").getValue();
    float blueVal = cp5.getController("blue").getValue();
    
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
