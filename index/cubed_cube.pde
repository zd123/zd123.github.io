/* @pjs globalKeyEvents=true; 
 */

void setup() {
  size(600, 600, P3D);
  background(0);
  colorMode(RGB);
  smooth();
}

float xpos = 0.0;
float ypos = 0.0;
float rX = 0.0;
float rY = 0.0;
int d = 50;
int gap = 100;
void draw() {
  xpos = lerp(xpos, mouseX, 0.009);
  ypos = lerp(ypos, mouseY, 0.009);
  rX = map(xpos, 0, width, 0, TWO_PI);
  rY = map(ypos, 0, height, 0, TWO_PI);
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  defineLights();


  for (int i = -gap; i<=gap; i+=gap) {
    rotateX(PI);
    rotateY(QUARTER_PI);
    rotateZ(TWO_PI);

    for (int j = -gap; j<=gap; j+=gap) {
      pushMatrix();
      translate(j, i, j);
      rotateY(rX*2);
      rotateX(rY*2);
      pushMatrix();
      translate(0, 0);
      rotateY(rX*2);
      rotateX(rY*2);
      specular(0, 0, 255);
      box(25); 
      popMatrix();

      pushMatrix();
      translate(0, -d);
      rotateY(rX*2);
      rotateX(rY*2);
      specular(0, 0, 255);
      box(25); 
      popMatrix();

      pushMatrix();
      translate(0, d);
      rotateY(rX*2);
      rotateX(rY*2);
      specular(0, 0, 255);
      box(25); 
      popMatrix();

      pushMatrix();
      translate(-d, 0);
      rotateY(rX*2);
      rotateX(rY*2);
      specular(0, 0, 255);
      box(25); 
      popMatrix();

      pushMatrix();
      translate(d, 0);
      rotateY(rX*2);
      rotateX(rY*2);
      specular(0, 0, 255);
      box(25); 
      popMatrix();

      popMatrix();
    }
  }
  popMatrix();
}

void defineLights() {
  background(0);
  noStroke();
  float  mColor = map(mouseX, 0, width, 0, 255);
  pointLight(22, 255, 99, // Color
  200, -150, 0); // Position

  // Blue directional light from the left
  directionalLight(0, 222, 255, // Color
  1, 0, 0); // The x-, y-, z-axis direction

  directionalLight(0, 222, 255, // Color
  mColor, 0, 0); // The x-, y-, z-axis direction

  // Yellow spotlight from the front
  spotLight(mColor, 0, 0, // Color
  0, 40, 200, // Position
  0, -0.5, -0.5, // Direction
  PI / 2, 2); // Angle, concentration
}


