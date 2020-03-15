class EffectBomb{
  float x,y,col,size,maxsize;
  EffectBomb(float _x ,float _y , float _col, float _maxsize){
    x = _x;
    y = _y;
    col = _col;
    maxsize = _maxsize;
  }
  void update(){
    size += 20 * 50 /frameRate;
    noFill();
    strokeWeight(5);
    stroke(0, col, 100,(maxsize - size) *50/ maxsize);
    ellipse(x,y,size,size);
    stroke(0, col, 100,(maxsize - size) *50/ maxsize);
    ellipse(x,y,size-50,size-50);
  }
}
