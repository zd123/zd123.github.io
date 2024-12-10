import processing.core.*; 
import processing.xml.*; 

import blprnt.nytimes.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class june1a_NY_a3 extends PApplet {


String apiKey =  "9eaa4ece11be7f9d85689211d1db3424:3:65846941";

ArrayList<Person> allPeople= new ArrayList(); //this is the ArrayLists that stores all the terms and counts

PVector mouse = new PVector(); //mapping the mouse coordinates into a PVector called "mouse"

Person nextPerson = null;

//solving the double up propblem
//2X Problem step 1:
HashMap<String, Person> peopleHash = new HashMap(); 


public void setup() {
  size(800, 800);
  colorMode(HSB);
  background(255);

  TimesEngine.init(this, apiKey);
  Person starter = new Person();
  starter.name = "LIL WAYNE";
  starter.pos.x = 0;
  starter.pos.y = 0;
  allPeople.add(starter);

  getPeople(starter);
  positionPeople();
  smooth();
}

public void draw() {
  background(255);
  mouse.x = mouseX;
  mouse.y = mouseY;

  if (nextPerson != null) {
    getPeople(nextPerson);
    positionPeople();
    nextPerson.pos = new PVector(width/2, height/2);
    nextPerson = null;
  }

  //translate(width/2, height/2);
  for (Person guy:allPeople) {
    guy.update();
    guy.render();
  }
}

public void positionPeople() {
  for (int i = 0; i < allPeople.size(); i++) {
    float theta = map(i, 0, allPeople.size(), 0, TWO_PI);
    float radius = (allPeople.get(i).clicked) ? 100:300;
    //float radius = 300;
    float x = cos(theta) * radius;
    float y = sin(theta) * radius;
    allPeople.get(i).tpos.x = width/2 +x;
    allPeople.get(i).tpos.y = height/2 +y;
  }
}

public void getPeople(Person seed) {
  //Create a new search object
  TimesArticleSearch mySearch = new TimesArticleSearch();
  ///Tell it to restrict results to articles with the per_face in question
  mySearch.addFacetQuery("per_facet", seed.name);
  //Tell it to return a list of per_facets along with usual results
  mySearch.addFacets("per_facet");

  TimesArticleSearchResult myResult = mySearch.doSearch();
  TimesFacetObject[] facets = myResult.getFacetList("per_facet");
  //println(facets);

  for (int i =0; i < facets.length; i++) {
    Person newGuy = new Person();
    if (peopleHash.containsKey(facets[i].term)) {    //step 2: solving 2x problem
      newGuy = peopleHash.get(facets[i].term);
    }      
    else {
      newGuy.name = facets[i].term;
      newGuy.count = facets[i].count;  
      allPeople.add(newGuy); 
      peopleHash.put(newGuy.name, newGuy);
    }
    seed.links.add(newGuy);
  }
}


class Person {

  boolean mouseOver = false;

  String name;
  int count;
  boolean clicked = false;
  ArrayList<Person> links = new ArrayList();
  PVector pos = new PVector();
  PVector tpos = new PVector();


  public void update() { 
    //animateing the stop objects
    pos.x = lerp(pos.x, tpos.x, 0.1f); 
    pos.y = lerp(pos.y, tpos.y, 0.2f);

    if (mousePressed && pos.dist(mouse) < 15 && !clicked) {
      nextPerson = this; //making a waiting room
      clicked = true;
    }
    mouseOver = (pos.dist(mouse) < 35);
  }

  public void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    float s = clicked ? 25:10;
    if (mouseOver) fill(pos.x*.4f, 255, 255, pos.x*0.3f);
    ellipse(0, 0, s, s);
    fill(0);
    if (mouseOver) fill(pos.x*.4f, 255, 255, pos.x*0.3f);
    text(name, 0, -10);
    popMatrix();

    for (Person otherGuy:links) { //for every tree in the forest function
      pushMatrix();
      strokeWeight(0.5f);
      fill(otherGuy.pos.x*.4f, 255, 255, otherGuy.pos.x*0.03f+50);
      noStroke();
      bezier( pos.x, pos.y, width/2, height/2, otherGuy.pos.x, otherGuy.pos.y, otherGuy.pos.x, otherGuy.pos.y);
      println(otherGuy.pos.x);
      popMatrix();
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "june1a_NY_a3" });
  }
}
