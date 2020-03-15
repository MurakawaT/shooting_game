class Effect {
  float x, y, xVel, yVel, size, lifetime,col;
  Effect(float _x, float _y,float _col) {
    x = _x ;
    y = _y;
    size = 10;
    col = _col;
    lifetime = frameRate;
    if (int(random(0, 10))%2 == 0) {
      xVel = random(1, 10);
    } else {
      xVel = random(-10, -1);
    }
    if (int(random(0, 10))%2 == 0) {
      yVel = random(1, 10);
    } else {
      yVel = random(-10, -1);
    }
    xVel *= 0.5;
    yVel *= 0.5;
  }

  void update() {
    lifetime -= 1;
    x += xVel;
    y += yVel;
    tint(col,100,100,lifetime * 100 /frameRate);
    image(img_point,x-size/2,y-size/2,size,size);
  }
}
