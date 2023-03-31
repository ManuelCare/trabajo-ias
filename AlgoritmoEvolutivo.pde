PImage surf;
//display
float d = 15;

int evals = 0;
int tamPoblacion = 100;
int tamPoblacionAct = tamPoblacion;
Particle[] poblacion = new Particle[tamPoblacionAct];
//Dominio de la funcion
float min = 3; //
float max = 7; //
//seleccion
int numSeleccionados = 20 , tamTorneo = 5;
Particle[] seleccionados = new Particle[numSeleccionados];
Particle[] torneo = new Particle[tamTorneo];
//cruzamiento
//mutacion
float variacion = 1.0f;

class Particle {
  float x, y, fit; // current position(x-vector)  and fitness (x-fitness)
  // ---------------------------- Constructor
  Particle() {
    x = random (min, max);
    y = random(min, max);
    fit = pow(10, 5);
  }
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    fit = pow(10, 5);
  }
  float Eval() {
    evals++;
    fit = 10*2 + pow(x, 2) - 10*cos(2*PI*x) + pow(y, 2) - 10*cos(2*PI*y);
    return fit;
  }
   void display(){
    int ejeX = int( (max+x)/(2*max) * width );
    int ejeY = int( abs(y-min)/(2*max) * height );
    
    color c=surf.get(ejeX, ejeY);
    fill(c);
    ellipse (ejeX,ejeY,d,d); 
    
    stroke(#ff0000);
  }
}

void seleccionTorneo() {
    Particle ganador;
    int i,j;
    for (i=0; i<numSeleccionados; i++){
      for(j=0; j<tamTorneo; j++)
        torneo[j] = poblacion[int(random(tamPoblacionAct))];
      ganador = torneo[0];
      
      for(j=0; j<tamTorneo; j++){
        if(torneo[j].fit<ganador.fit) ganador = torneo[j];}
      seleccionados[i] = ganador;
    }
}
void cruzamiento(){
  tamPoblacionAct =  int(random(tamPoblacion/2, tamPoblacion));
  int i;
  float factorX, factorY;
  Particle p1, p2;
  for(i=0; i<tamPoblacionAct; i++){
    factorX = random(0.2,0.8);
    factorY = random(0.2,0.8);
    p1 = seleccionados[int(random(numSeleccionados))];
    p2 = seleccionados[int(random(numSeleccionados))];
    poblacion[i] = new Particle(factorX*p1.x + (1.0-factorX)*p2.x, factorY*p1.y + (1.0-factorY)*p2.y);
  }
}
void mutacion(){
  int i;
  for(i=0; i<tamPoblacionAct; i++){
    poblacion[i].x = poblacion[i].x + random(-variacion, variacion);
    poblacion[i].x = poblacion[i].y + random(-variacion, variacion);
  }
}

void setup() {
    print("init setup\n");
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    size(426, 426); //setea width y height (de acuerdo al tamaño de la imagen)
    surf = loadImage("rastrigin.jpg");

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    smooth();
    // crea arreglo de objetos partículas
    poblacion = new Particle[tamPoblacionAct];
    
    for (int i = 1; i < tamPoblacionAct; i++)
      poblacion[i] = new Particle();
}

void draw() {
    print("init draw\n");
    //despliega mapa, posiciones  y otros
    image(surf, 0, 0);
    print("init poblacion\n");
     print(tamPoblacionAct);
     print("\n");
    for (int i = 1; i < tamPoblacionAct; i++){
      poblacion[i].Eval();
      poblacion[i].display();
    }
    print("init torneo\n");
    seleccionTorneo();
    print("init cruza\n");
    cruzamiento();
    print("init muta\n");
    mutacion();
    delay(10);
}
