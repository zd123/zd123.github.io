Bar[] bars;
float[] lines = new float[200];
PFont font;
float typeHeight = 500;
int counter = 1;
String msg;


void setup() {
  size(800, 600);
  
  colorMode(HSB);
  font = loadFont("Oswald-Regular-48.vlw");
  smooth();
  msg = "Click...";
  bars = new Bar[lines.length];
  for (int l = 0; l < lines.length; l++) {
    bars[l] = new Bar(l, 0.0, 0.0, 0.5, 0.7, 0.9);
  }
}

int ender = 0;
void draw() {
  fill(55);
  textFont(font, 12);
  text("click", width/2, height-height/8);
  textFont(font, 48);
  fill(255, 100);
  noStroke();
  rect(0, 0, width, height);
  for (int i = 0; i < lines.length; i++) {
    bars[i].update();
    bars[i].drive(i);
  }
  fill(255);
  stroke(255);
  textAlign(CENTER);
  text(msg, mouseX, 500);
 // typeHeight = lerp(typeHeight, 800, 0.005);
  fill(255, ender);
  rect(0, 0, width, height);
}

float t = 0.0;
float increment = 0.06;
void mousePressed() {
  perlin();
  typeHeight = 400;
  if (counter == 2) {
    msg = "clicked...";
  } 
  if (counter == 3) {
    msg = "every time you click...";
  }
  if (counter == 4) {
    msg = "you birth a new graph";
  }
  if (counter == 5) {
    msg = "you created it, its yours";
  }
  if (counter == 6) {
    msg = " :) ";
  }
  counter++;
}


void perlin() {
  float cR =  random(0.0, 0.99);
  float cG =  random(0.9, 0.9);
  float cB =  random(0.7, 0.9);
  float sw = 10;
  for (int i = 0; i < lines.length; i++) {
    float n = noise(t)*300;
    bars[i] = new Bar(i, 0.0, n, cR, cG, cB);
    bars[i].sw = sw;
    t+=increment;
  }
}

class Bar {

  float x;
  float y;
  float t;
  float cR;
  float cG;
  float cB;
  float sw;
  boolean mouse = false;

  Bar(float _x, float _y, float _targetLoc, float _cR, float _cG, float _cB) {
    x = _x;
    y = _y;
    t = _targetLoc;
    cR = _cR;
    cG = _cG;
    cB = _cB;
  }


  void drive(int i) {  
    if (mouse) { 
      float mapY = map(y, 0, 300, y, 200); 
      stroke((y*cR*0.4), 222, y*cB*0.8);
      text("y = " + y, width-100, 50);
      text("x = " + x, width-100, 35);
    } 
    else {
      float mapY = map(y, 0, 300, y, 200); 
      stroke(mapY*cR*0.8, 255, y*cB);
    }
    strokeWeight(sw);
    line(x*sw, height, x*sw, -y*2+height);
    bars[i].rollover(mouseX-(x*sw), mouseY);
  }

  void update() {
    y = lerp(y, t, 0.05);
  }

  void rollover(float mx, int my) { 
    // Left edge is x, Right edge is x + w
    if (mx > x && mx < x+20) {
      mouse = true;
    } 
    else {
      mouse = false;
    }
  }
}


