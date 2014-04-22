int RECURSE_DEPTH = 6; //B VARIE ENTRE 6 ET 20 =========== 
float VANGLE = 0;//BINGO VARIE ENTRE 1 et l'infini ======= NBLETTRES
float vitesseRotation = 0.8; // VARIE ENTRE 0 et 6
float HANGLE = 0;
Branch branch1;
Branch branch2;
Branch branch3;
Branch branch4;
String fichier[];
int nbLettres, nbCaracteres, nbChiffres;
String listeC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String listeN = "0123456789";

 
void setup()
{
  println("Setup commencé");
  size (800,800);
  strokeWeight(2);
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
  println(suite);
  println("triplesuite ::: "+triplesuite);
  println("\r \r");
  nbCaracteres = triplesuite.length();
  println("premier nombre : "+nbCaracteres);
  for (int i = 0; i < nbCaracteres; i++) {

  }

  println("il y a "+nbLettres+" lettres et "+nbChiffres+" chiffres");
  VANGLE = nbCaracteres;

  background(255);
  branch1.update(width / 2, height /2, HALF_PI, 100);
  branch2.update(width / 2, height /2, 2 * HALF_PI, 100);
  branch3.update(width / 2, height /2, 3 * HALF_PI, 100);
  branch4.update(width / 2, height /2, 4 * HALF_PI, 100);
  String nomFichier = nbCaracteres+"caracteres.png";
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
