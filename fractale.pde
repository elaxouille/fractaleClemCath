int RECURSE_DEPTH = 6; //B VARIE ENTRE 6 ET 20 =========== NBCHIFFRES
float VANGLE = 0;//BINGO VARIE ENTRE 1 et l'infini ======= NBLETTRES
float vitesseRotation = 1; // VARIE ENTRE 0 et 3
float epaisseur = 1; // VARIE ENTRE 1 ET 12
float HANGLE = 0;
Branch branch1;
Branch branch2;
Branch branch3;
Branch branch4;
String fichier[];
int[] nbTout;
int nbLettres, nbCaracteres;
String listeC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String listeN = "0123456789";
int taille =100;

 
void setup()
{
  println("Setup commencé");
  size (4961,4961);
  strokeWeight(epaisseur);
  background(0);
  branch1 = new Branch(0);
  branch2 = new Branch(0);
  branch3 = new Branch(0);
  branch4 = new Branch(0);
  println("Setup terminé");
}
 
void draw() {

  String fichier[] = loadStrings("caract.txt"); // Chargement du texte
  String suite = join(fichier,"");              // Suppression des lignes
  String triplesuite = suite.replace(" ","");   // Suppression des espaces (marche pas)
  nbCaracteres = triplesuite.length();            
  VANGLE = nbCaracteres;                        // PREMIERE INJECTION
  nbTout = countNumbers(triplesuite);           // CHARGMENT DE LA DEUXIEME ET TROISIEME INJECTION
  RECURSE_DEPTH = int(map(nbTout[0],0,nbCaracteres,6,20));//DEUXIEME INJECTION
  vitesseRotation = map(nbTout[1],0,nbCaracteres,0,3);//TROISIEME INJECTION
  background(255);
  branch1.update(width / 2, height /2, HALF_PI, taille);
  branch2.update(width / 2, height /2, 2 * HALF_PI, taille);
  branch3.update(width / 2, height /2, 3 * HALF_PI, taille);
  branch4.update(width / 2, height /2, 4 * HALF_PI, taille);
  String nomFichier = "rendu-"+day()+"-"+month()+"-"+year()+"-"+hour()+"-"+minute()+"-"+second()+".png";
  save(nomFichier);
  exit();
}

class Branch {
  float _x1, _x2, _y1, _y2, _hyp, _rads;
  int _i;
  ArrayList<Branch> _branches;
  Branch(int i) {
    _i = i;
    _i++;
    _branches = new ArrayList<Branch>();
    if(_i != RECURSE_DEPTH) {
      _branches.add(new Branch(_i));
      _branches.add(new Branch(_i));
    }
  }
     
  void update(float x1, float y1, float rads, float hyp) {
    _x1 = x1;
    _y1 = y1;
    _rads = rads;
    _hyp = hyp;
    _x2 = _x1 + cos(_rads) * _hyp;
    _y2 = _y1 + sin(_rads) * _hyp;
    line (_x1, _y1, _x2, _y2);
    float vangle = VANGLE;
    float hangle = HANGLE;
    for(int j = 0; j < _branches.size(); j++) {
      Branch branch = _branches.get(j);
      branch.update(_x2, _y2, _rads + vangle + hangle, _hyp * vitesseRotation); 
      vangle *= -1;
    }
  }
};


int[] countNumbers(String toTest) {
  // 0 : chiffres
  // 1 : lettres
  int[] compte = {0,0};
  for (int i=0; i < toTest.length(); i++) { 
    char c = toTest.charAt(i);
    if (c < '0' || c > '9') {
      compte[1]++;
    } else {
      compte[0]++;
    }
  }
  return compte;
}
