//Classes voor de particle en van het particle system.

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }
  
  //Voegt particle toe aan de array list
  void addParticle() {
    particles.add(new Particle(origin));
  }
  
  //Runt de run() functie voor alle particles in het particle system
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}




class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 15.0;
  }
  
  void run() {
    update();
    display();
  }
  
  //Update de particle
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  //Displayt de particle
  void display() {
    stroke(255, 0, 127);
    fill(0, 255, 255);
    ellipse(position.x, position.y, 8, 8);
  }

  //Haalt particle weg wanneer nodig is
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
