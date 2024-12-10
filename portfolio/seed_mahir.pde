int f = 0;
float free = 0;
float kMaxOffset = .9;
float phi = (sqrt(5)+1)/2 - 1; // golden ratio
float ga = phi*2*PI;           // golden angle
float alp = 180;
float alp2 = 180;
PFont oswald;


void setup()
{
  size(900, 500);
  frameRate(30);
  colorMode(HSB, 360, 360, 360);
  smooth();
  ellipseMode(CENTER);
  //  oswald = createFont("Oswald-Regular.ttf", 36);
  textFont(createFont("Oswald-Regular.ttf", 36));  
  // textFont(oswald, 24);
}

void drawit()
{
  background(360,0);
  float m = 1+f;
  float rad = height/2; // - 64;
  float asmall = (PI*rad*rad)/m;
  float R = sqrt((rad*rad)/m); // also sqrt(asmall/PI);
  float cumA = 0;
  for (int i = 0; i < m; ++i)
  {
    float a = i*ga; 
    float ir = i/(float) (m-1);
    float xo = asmall*kMaxOffset*2*ir - asmall*kMaxOffset; 
    float areai = asmall+xo;               
    float radi = sqrt(areai/PI);         
    float radcum = sqrt(cumA/PI);        
    radi *= min(1, (m-i)/100);
    pushMatrix();
    float x = width/2 + sin(a)*(radcum+radi);
    float y = height/2 + cos(a)*(radcum+radi);
    translate(x, y);
    float m2 = (128+(i*50)%128);
    float cm = map(m2, 128, 255, 157, 222);
    noStroke();
    fill(cm, 333, 333, alp);
    ellipse(0, 0, radi*5, radi*5);
    if (free > 111) {
      alp = alp - alp/800;
    }
    cumA += PI*radi*radi;
    popMatrix();
  }
}

void draw()
{
  drawit();
  ++f;
  free++;
  
  if (free > 111) {
    displayText();
  }
  if (free > 999) {
    noLoop();
  }
}
void displayText() { 
  pushMatrix();
  translate(width/2, height/2);
  textAlign(CENTER);
  textSize(40);
  fill(360);
  String s3 = "Hello Seed.";
  text(s3, 0, -30);
  textSize(10);
  String s4 = "P L E A S E,  P R E S S   S P A C E B A R   T O   C O N T I N U E";
  text(s4, 0, 0);
  popMatrix();
}

