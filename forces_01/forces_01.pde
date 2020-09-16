int nbMovers = 100;

Mover[] movers;
Mover ballon;
Water water;

void setup () {
  size (800, 600);
  movers = new Mover[nbMovers];
  ballon = new Mover();
  float temp = random(0.1*height, 0.4*height);
  water = new Water(width, temp, random(0.15, 0.3));
  //jérémy
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5, 5), 0, height/2);
  }
  ballon = new Mover(2, 0, 600);
  
}

void draw () {
  update();
  
  background (255);
  
  water.display();
  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
  ballon.display();
  
}

void update() {
  PVector wind = new PVector(1/*perlin()*/, 0);
  
  if(mousePressed==true&&(mouseButton==RIGHT)){
    wind.x=-1;
    for (int i = 0; i < movers.length; i++) {
      movers[i].applyForce(wind);
    }
    ballon.applyForce(wind);
  }if(mousePressed==true&&(mouseButton==LEFT)){
    wind.x=1;
    for (int i = 0; i < movers.length; i++) {
      movers[i].applyForce(wind);
    }
    ballon.applyForce(wind);
  } /*else if(mousePressed==false){
    wind.x=perlin();
  }*/
  if (keyPressed) {
    if (key == ' '&&water.h==0) {
      float temp = random(0.1*height, 0.4*height);
      water = new Water(width, temp, random(0.015, 0.03));
    }
    else if (key == ' '&&water.h!=0) {
      water = new Water(0, 0, 0);
    }
    else if(key=='r'||key=='R')
    {
      setup();
    }
  }
  
  for (int i = 0; i < movers.length; i++) {
    
    
    float m = movers[i].mass;
    
    // Is the Mover in the liquid?
    if (water.contains(movers[i])) {
      // Calculate drag force
      PVector drag = water.drag(movers[i]); //<>//
      // Apply drag force to Mover
      movers[i].applyForce(drag);
    }/*else{
      //movers[i].applyForce(wind);
    }*/
    
    PVector gravity = new PVector (0, 0.1 * m);

    //movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].checkEdges();
  }
  
  float m = ballon.mass;
  
  // Is the Mover in the liquid?
    if (water.contains(ballon)) {
      // Calculate drag force
      PVector drag = water.drag(ballon);
      // Apply drag force to Mover
      ballon.applyForce(drag);
    }/*else{
      //ballon.applyForce(wind);
    }*/
  
  PVector helium = new PVector(0, -0.1 * m);
  
  //ballon.applyForce(wind);
  ballon.applyForce(helium);
  ballon.update();
  ballon.checkEdges();
}

/*float perlin(){
  float yoff = 0.0;

  float n = noise(yoff) * 0.1;

  yoff = yoff + .02;  
  n = noise(yoff) * 0.1;
  return n;
}*/
