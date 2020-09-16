class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
   
  float topSpeed;
  float mass;
  
  Mover () {
    
    this.location = new PVector (random (width), random (height));    
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    
    this.mass = 1;
  }  
  
  Mover (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    
    this.topSpeed = 1;
  }
  
  Mover (float m, float x, float y) {
    mass = m;
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill (127, 127, 127, 127);
    
    ellipse (location.x, location.y, mass * 16, mass * 16); // Dimension à l'échelle de la masse
  }
  
  void checkEdges() {
    if (location.x > width-mass*8) {
      location.x = width-mass*8;
      velocity.x *= -0.9;
    } else if (location.x < mass*8) {
      velocity.x *= -0.9;
      location.x = mass*8;
    }
    
    if (location.y > height-mass*8) {
      velocity.y *= -0.9;
      location.y = height-mass*8;
    }else if (location.y < mass*8) {
      velocity.y *= -0.9;
      location.y = mass*8;
    }
  }
  
  
  void applyForce (PVector force) {
    PVector f = PVector.div (force, mass);
   
    this.acceleration.add(f);
  }
}
