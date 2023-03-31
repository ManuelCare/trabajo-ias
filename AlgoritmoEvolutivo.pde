int evals = 0;
Particle[] poblacion;
class Particle{
  float x, y, fit; // current position(x-vector)  and fitness (x-fitness)
  // ---------------------------- Constructor
  Particle(){
    x = random (min,max); y = random(min,max);
    fit = pow(10,5); 
  }
  Particle(Particle p){
    x = p.x;
    y = p.y;
  }
float Eval(){
    evals++;
    //color c=surf.get(int(x),int(y)); // obtiene color de la imagen en posición (x,y)
    //fit = red(c); //evalúa por el valor de la componente roja de la imagen
    fit = 10*2 + pow(x,2) - 10*cos(2*PI*x) + pow(y,2) - 10*cos(2*PI*y);
  /*
    if(fit < pfit){ // actualiza local best si es mejor
      pfit = fit;
      px = x;
      py = y;
    }
    if (fit < gbest){ // actualiza global best
      gbest = fit;
      gbestx = x;
      gbesty = y;
      evals_to_best = evals;
      println(str(gbest));
    };
    return fit; //retorna la componente roja
    */
    return fit;
  }
Particle[] seleccion(){
  
}
  void setup(){  
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  size(1024,1024); //setea width y height (de acuerdo al tamaño de la imagen)
  surf = loadImage("rastrigin.png");
  
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  smooth();
  // crea arreglo de objetos partículas
  fl = new Particle[puntos];
  //Se inicializa por defecto a la primera particula como la mejor
  fl[0] = new Particle();
  
  for(int i = 1;i < puntos;i++)
    fl[i] = new Particle();

  //Inicializamos en -1 los mejores valores
  for(int i=0; i<100; i++)
    BestValues_i[i] = -1;
}

void draw(){
  //background(200);
  //despliega mapa, posiciones  y otros
  image(surf,0,0);
  for(int i = 0;i<puntos;i++){
    fl[i].display();
  } 
}
