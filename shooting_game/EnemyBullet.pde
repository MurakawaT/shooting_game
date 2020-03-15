class EnemyBullet { 
  float x, y, xVel, yVel, size,damage,col;
  EnemyBullet (float _x, float _y,float _xVel, float _yVel,float _size,float _damage) {
    x = _x;    //x, y座標の初期値はインスタンスの引数
    y = _y;
    xVel = _xVel*8;
    yVel = _yVel*8;
    size = _size;
    damage = _damage;
    col = 10;
    
  }
  void update(){
    x += xVel;
    y += yVel;
    tint(col,100,100);
    image(img_point,x-size/2,y-size/2,size,size);
  }
  
}
