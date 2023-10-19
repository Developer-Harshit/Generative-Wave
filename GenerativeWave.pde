import peasy.*;



Cube b;


PeasyCam cam;

void setup() {
  size(720, 720, P3D);
  surface.setResizable(true);
  colorMode(HSB);
  noStroke();
  setCam();
  b = new Cube(2, 200);
}

void draw() {

  background(200);

  setLights();
  b.display();
  b.update();


 
}
void keyPressed() {

  b.setParams();
}
void setLights() {
  lights();
  float dirY = (mouseY / float(height) - 0.5) * 3;
  float dirX = (mouseX / float(width) - 0.5) * 3;
  directionalLight(60, 190, 150, -dirX, -dirY, -1);
  cam.rotateX(0.001);
  cam.rotateY(0.001);
  cam.rotateZ(0.001);
}
void windowResized(){
  println("hi");
setCam();
}
void setCam() {
  cam = new PeasyCam(this, 600);
  cam.rotateX(-PI/2);
  cam.lookAt(200,200, 400);
}
