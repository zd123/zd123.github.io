/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/9315*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

public static final int WIDTH = 1020;
public static final int HEIGHT = 800;

public static final int COLUMNS = 5;   // number of columns
public static final int DIVISIONS = 50; // number of stripes per column
public static final int OFFSET = 20;    // moving lines are lower

// height of each line
public static final float LINE_HEIGHT = (HEIGHT / DIVISIONS);
public static final float LINE_WIDTH = (WIDTH / COLUMNS);

Line[] lines = new Line[COLUMNS];
PFont f;

void setup() {
  smooth();
  size(WIDTH, HEIGHT);
  f = loadFont("Helvetica-Bold-48.vlw");
  textFont(f, 10);
  colorMode(HSB);
  for (int i = 0 ; i < COLUMNS ; i++) {
    lines[i] = new Line(i);
  }
}
float fadefill;
void draw() {
  background(0);
  float mapMouseX = map(mouseX, 0, width, 255,0);
  float mapMouseY = map(mouseY, 0, height, 0, 255);
  float mapMouseStroke = map(mouseX, 0, width, 100, 222);
  noStroke();
  fill(mapMouseStroke, 255, mapMouseY);
  for (int x = 0 ; x < COLUMNS ; x++) {
    lines[x].update();
    for (int y = 0 ; y < DIVISIONS - 2 ; y++) {
      float x0 = (x + .5) * LINE_WIDTH + lines[x].getX(y);
      float y0 = lines[x].getY(y);
      float x1 = (x + .5) * LINE_WIDTH + lines[x].getX(y + 1);
      float y1 = lines[x].getY(y + 1);
      if ((y & 1) == 0) {  
        quad(x * LINE_WIDTH, y * LINE_HEIGHT, x0, y0, x1, y1, x * LINE_WIDTH, (y + 1) * LINE_HEIGHT);
        quad(x0, y0, (x + 1) * LINE_WIDTH, y * LINE_HEIGHT, (x + 1) * LINE_WIDTH, (y + 1) * LINE_HEIGHT, x1, y1);
      }
    }
  }
  textAlign(CENTER);
  fadefill = lerp(fadefill,mapMouseX, 0.2);
  fill(fadefill);
  fill(mapMouseStroke, 255, mapMouseY);
  text("ZACK DESARIO",width/2, height/2);
}

// could probably just be a 2d array
class Line {
  float[] x = new float[DIVISIONS];
  float[] y = new float[DIVISIONS];
  float alpha;
  float delta;
  float period;
  float phase;
  float radius;

  public Line(int i) {
    alpha = random(360);
    period = random(-10.0, 10.0);
    radius = (WIDTH / COLUMNS) / 2;
    delta = random(0.5, 4.0);
    phase = random(360);
  }

  public void update() {
    alpha += delta;
    for (int i = 0 ; i < DIVISIONS ; i++) {
      float angle = radians(phase + alpha + (period * i));
      float normMouse = norm(mouseX, 0, width); 
      float normMouseY = norm(mouseY, 0, height); 
      x[i] = radius * sin(angle);
      y[i] = lerp(y[i], (OFFSET + i * LINE_HEIGHT * normMouseY), 0.07);
    }

  }

  public float getX(int i) {
    return x[i];
  }

  public float getY(int i) {
    return y[i];
  }
} 


