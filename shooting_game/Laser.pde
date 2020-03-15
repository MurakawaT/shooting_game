
class Laser { 
  float sx, sy, theta, vel, size,dis;
  float x,y,c,s;
  Laser (float _sx, float _sy,float _angle) {
    sx = _sx;    //x, y座標の初期値はインスタンスの引数
    sy = _sy;
    theta = radians(_angle);
    size = 30;
    dis = player.rad;
    c = cos(theta);
    s = sin(theta);
  }
  void update(){
    dis += 20 * 50 / frameRate ;
    x = dis * c + sx;
    y = dis * s + sy;
    tint(50,100,100);
    image(img_point,x-size/2,y-size/2,size,size);
  }
  
}
