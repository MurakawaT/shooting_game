class Player { 
  float x, y, xVel, yVel, size, e, energy,hp;
  float rad, angle;

  //初期化用メソッド（コンストラクタ）
  Player (float _x, float _y) {
    x = _x;    //x, y座標の初期値はインスタンスの引数
    y = _y;
    xVel = 0;
    yVel = 0;
    size = 50;
    e = 0.2;
    energy = 360;
    hp = 200;

    rad = size; 
    angle = 0;
  }

  //円の位置を更新するメソッド
  void update() {
    x += xVel ;
    y += yVel ;
    if (energy < 360 ) {
      energy += 1 * 50 / frameRate;
    }
    
    if (x + size/2> width && xVel > 0) {
      xVel *= -1*e;
    }
    if (y + size/2> height && yVel > 0) {
      yVel *= -1*e;
    }
    if (x < 0 + size/2 && xVel < 0) {
      xVel *= -1*e;
    }
    if (y <0 + size/2 && yVel < 0) {
      yVel *= -1*e;
    }
    if (xVel >= 20 || yVel >= 20) {
      xVel = min(20, xVel);
      yVel = min(20, yVel);
    }
    if (xVel <= -20 || yVel <= -20) {
      xVel = max(-20, xVel);
      yVel = max(-20, yVel);
    }
    //noTint();
    //image(img_player, x-(size/2), (y-size/2), size, size);
    strokeWeight(3);
    stroke(50, 100, 100,70);
    ellipse(x,y,size,size);
    strokeWeight(6);
    stroke(55, 100, 100,70);
    arc(x,y,size-12,size-12,radians(0), radians(hp * 360 /200));

    //////衛星
    angle += 3 * 50 /frameRate;
    if (angle > 360) {
      angle -= 360;
    }
    noFill();
    strokeWeight(3);
    stroke(45, 100, 100,70);
    float theta = radians(angle);
    arc(rad * cos(theta) + x, rad*sin(theta) + y, size /3, size / 3, radians(0), radians(energy));
    arc(rad * cos(theta-PI) + x, rad*sin(theta-PI) + y, size /3, size / 3, radians(0), radians(energy));
    stroke(50, 100, 100,100);
    ellipse(rad * cos(theta) + x, rad*sin(theta) + y, size /6, size / 6);
    ellipse(rad * cos(theta-PI) + x, rad*sin(theta-PI) + y, size /6, size / 6);
  }
}
