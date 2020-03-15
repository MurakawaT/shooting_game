class Enemy{
  float x, y, xVel, yVel, size,hp,maxHp,col_s, interval, time;
  boolean parent;
  Enemy preEne;
  //親
  Enemy(float _x , float _y,float _size,float _interval){
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    size = _size;
    preEne = null;
    maxHp = size * 2;
    hp = maxHp;
    parent = true;
    col_s = 100;
    interval  = _interval;
    time = random(0,interval);
  }
  //子
  Enemy(float _x , float _y ,float _size,float _interval,Enemy _preEne){
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    size = _size;
    preEne = _preEne;
    maxHp = size/5;
    hp = maxHp;
    parent = false;
    col_s = 0;
    interval  = _interval;
    time = random(0,interval);
  }
  void update(){
    if(preEne == null){
      //親
      float rx;
      if((frameCount /2/frameRate) %2 == 0){
      rx = random(30,50);
      }else{
       rx = random(-50,-30);
      }
      float dis = dist(x,y,player.x ,player.y);
       if(dis >= size/2 + player.size/2){
      x +=  xVel;
      y += yVel;
      }else{
        player.hp -= 0.5 * 50/frameRate;
        effect.add(new Effect(player.x,player.y, 0));
      }
      xVel = (player.x - x )/dis;
      yVel = (player.y - y)/dis;
      
      //弾丸
      time += 1 * 50  /frameRate ;
      if (time > interval){
        enemyBullet.add(new EnemyBullet(x,y,xVel,yVel,50,20));
        time = 0;
      }
      
      noStroke();
      strokeWeight(3);
      stroke(0, col_s, 100,100);
      ellipse(x,y,size,size);
      arc(x,y,size-10,size-10, radians(0), radians(360 * hp/maxHp));
      
    }else{
      
      //子
      x += xVel;
      y += yVel;
      float dis = dist(x,y,preEne.x,preEne.y);
      if(dis > size/2 + preEne.size/2){
      xVel = (preEne.x - x)/(dis+0.01);
      yVel = (preEne.y - y)/(dis+0.01);
      }else if (dis < size/2 + preEne.size/2 -3){
        xVel = - (preEne.x - x)/(dis+0.01);;
        yVel = - (preEne.x - x)/(dis+0.01);;
      }else{
        xVel = 0;
        yVel = 0;
      }
      
      noStroke();
      strokeWeight(3);
      stroke(0, col_s, 100,100);
      ellipse(x,y,size,size);
      arc(x,y,size-10,size-10, radians(0), radians(360 * hp/maxHp));
      if (preEne.hp <= 0){
        preEne = null;
        maxHp = size * 2;
        hp = maxHp;
        col_s = 100;
        time = random(0,interval);
      }
    }
  }
}
