int RECURSE_DEPTH = 12;
float VANGLE = PI / 8;
float HANGLE = 3 * HALF_PI;
Branch branch1;
PImage image;
 
void setup()
{
  size (800,800);
  strokeWeight(2);
  background(0);
  branch1 = new Branch(0);
  image = loadImage("image.png");
}
 
void draw() {
  background(255);
  branch1.update(width / 2, height - 100, 3 * HALF_PI, 100);
}
 
void mouseMoved() {
  VANGLE = (mouseY / (float)height) * TWO_PI;
  HANGLE = 0;
  println("VANGLE = ("+mouseY+" / "+(float)height+" * " +TWO_PI+" = "+VANGLE);
  
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
    stroke(0);
    line (_x1, _y1, _x2, _y2);
    float vangle = VANGLE;
    float hangle = HANGLE;
    for(int j = 0; j < _branches.size(); j++) {
      Branch branch = _branches.get(j);
      branch.update(_x2, _y2, _rads + vangle + hangle, _hyp * 0.75);
      vangle *= -1;
    }
  }
};
