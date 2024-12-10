//keww with data
int saveCount = 0; 
float rotation = 0;
float perlinPosition = 0;
float perlinSpeed = .01; //the speed at which it traverses the mountains. .001 = very slowly, .9 is fast, whole #'s are generally too big
String[] lines;
int index = 0;


void setup() {
  size(1500, 750);
  background(255);
  lines = loadStrings("fares_120526.csv");
  colorMode(HSB, 255, 100, 100, 100);
  smooth();
}

float fareColor;
float  fareHeight;
int x = -750;
float fareStroke;
float fareBrightness;
void draw() {
  translate(width/2, height/2);
  
  if (index < lines.length) {
    String[] pieces = split(lines[index], ',');
    int fares = int(pieces[3]);
    //rotate(rotation);
    //float kewwColor = noise(perlinPosition) *300;
    //float kewwColor2 = noise(perlinPosition)*400;
    //strokeWeight(2);
    fareColor = map(fares, 0, 12000, 0, 255);
    fareHeight = map(fares, 0, 12000, 10, 300);
    fareStroke = map(fares, 0, 12000, 2, 10);
    fareBrightness = map(fares, 0, 12000, 90, 100);
    println(fareStroke);
    strokeWeight(fareStroke);
    stroke(fareColor, 100, 100, fareBrightness);
    println(x);
    //strokeWeight(2);
    line(x, -fareHeight, x, fareHeight);
    x+=10;
    //x+=fareStroke;
    fill(255, 25);
    noStroke();
    //if(rotation < 1) fill(255,0,0);
    //ellipse(fares, 250, 2, 2);

    index++;
    rotation = rotation + 0.008;
    perlinPosition = perlinPosition + perlinSpeed; // perlinSpeed is like a step. so sperlin speed = .01. so position + .01steps,
  }
}



void keyPressed() {
  if (key == 's') {
    saveCount ++;
    save("enter file name here" + saveCount + ".jpg"); 
    println("IMAGE SAVED!");
  }
}


