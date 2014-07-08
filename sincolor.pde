int periodicColor(int value, float period, float offset) {
  float p = TWO_PI/period;
  float x = sin(value*p + offset);
  float y = map(x,-1,1,0,255);
  return round(y);
}

int periodicColor(int value, float period) {
  return periodicColor(value, period, 0);
}

void setup() {
  int SIZE = 500;
  size(SIZE,SIZE);
  background(230,230,220);
  colorMode(RGB, 255);
  
  float a = 0.0;
  float period = TWO_PI/250.0;
  
  for (int i = 0; i < SIZE; i = i + 1) {
    float x = sin(i*period);
    int red = periodicColor(i, 500);
    int green = periodicColor(i,20);
    int blue = periodicColor(i,5);
    stroke(red, green, blue);
    line(0,i,SIZE,i);
  }
}
