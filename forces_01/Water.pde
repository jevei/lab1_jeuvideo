class Water {
  // Liquid is a rectangle
  float x, y, w, h;
  // Coefficient of drag
  float c;
  
  Water (float w_, float h_, float c_) {
    x = 0;
    y = 600-h_;//300;
    w = w_;//1000;
    h = h_;//500;
    c = c_; 
  }  
  
  // Is the Mover in the Liquid?
  boolean contains(Mover m) {
    PVector l = m.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {//fonctionne comme pour les rebord
      return true;
    } else {
      return false;
    }
  }
  
  // Calculate drag force      :::: formule du fluide = c*vitesse*vitesse*-1
  PVector drag(Mover m) {
    // Magnitude is coefficient * speed squared
    float vitesse = m.velocity.mag();
    float dragMagnitude = c * vitesse * vitesse;

    // Direction is inverse of velocity
    PVector drag = m.velocity.copy();
    drag.mult(-1);

    // Scale according to magnitude
    drag.setMag(dragMagnitude);
    return drag;
  }
  
  void display () {
    stroke (0);
    fill (0, 0, 255);
    
    rect(x, y, w, h); //dimension eau
  }

}
