
class Person {

  boolean mouseOver = false;

  String name;
  int count;
  boolean clicked = false;
  ArrayList<Person> links = new ArrayList();
  PVector pos = new PVector();
  PVector tpos = new PVector();


  void update() { 
    //animateing the stop objects
    pos.x = lerp(pos.x, tpos.x, 0.1); 
    pos.y = lerp(pos.y, tpos.y, 0.2);

    if (mousePressed && pos.dist(mouse) < 15 && !clicked) {
      nextPerson = this; //making a waiting room
      clicked = true;
    }
    mouseOver = (pos.dist(mouse) < 35);
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    float s = clicked ? 25:10;
    if (mouseOver) fill(pos.x*.4, 255, 255, pos.x*0.3);
    ellipse(0, 0, s, s);
    fill(0);
    if (mouseOver) fill(pos.x*.4, 255, 255, pos.x*0.3);
    text(name, 0, -10);
    popMatrix();

    for (Person otherGuy:links) { //for every tree in the forest function
      pushMatrix();
      strokeWeight(0.5);
      fill(otherGuy.pos.x*.4, 255, 255, otherGuy.pos.x*0.03+50);
      noStroke();
      bezier( pos.x, pos.y, width/2, height/2, otherGuy.pos.x, otherGuy.pos.y, otherGuy.pos.x, otherGuy.pos.y);
      println(otherGuy.pos.x);
      popMatrix();
    }
  }
}

