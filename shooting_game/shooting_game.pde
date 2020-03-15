PImage img_back;
PImage img_point;
int back_scroll = 0;
int phase = 0;
int gameMode = 0;
Player player;
ArrayList<Laser> laser = new ArrayList<Laser>();
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
ArrayList<Effect> effect = new ArrayList<Effect>();
ArrayList<EffectBomb> effectBomb = new ArrayList<EffectBomb>();
ArrayList<EnemyBullet> enemyBullet = new ArrayList<EnemyBullet>();
void setup() {
  //fullScreen();
  size(1000, 600);
  img_back = loadImage("img_back2.jpg");
  colorMode(HSB, 100);//色相、彩度、輝度
  frameRate(50);

  img_point =  loadImage("img_point.png");

  player = new Player(width/2, height/2);
}

void draw() {
  if (gameMode == 0) {
    background(0);
    textSize(30);
    fill(0, 0, 100, 100);
    text("press spase key  ", width /2 - 130, height/2);
    if (keyPressed == true && key == ' ') {
      gameMode = 1;
    }
  } else if (gameMode == 1) {
    background(0);
    player.update();
    updateAll();
    atari();
    enemy_phase();
    controll();
    textSize(12);
    text(frameRate, 10, 10);
    textSize(30);
    fill(0, 0, 100, 30);
    text("phase :  "+ phase, width -200, 30);
    noFill();
    if (player.hp <= -20) {
      gameMode = 2;
    }
  } else if (gameMode == 2) {
    textSize(60);
    fill(0, 100, 100, 100);
    text("GAME OVER  ", width /2 - 150, height/2);
    textSize(30);
    fill(0, 0, 100, 100);
    text("phase :  "+ phase, width /2 - 150, 4*height/6);
    text("press A  ", width /2 - 150, 5 *height/6);
    if (keyPressed == true &&( key == 'a')||(key == 'A')) {
      reset();
    }
  } else if (gameMode == 3) {
    textSize(60);
    fill(45, 100, 100, 100);
    text("GAME CLEAR  ", width /2 - 150, height/2);
    text("press A  ", width /2 - 150, 5 *height/6);
    if (keyPressed == true &&( key == 'a')||(key == 'A')) {
      reset();
    }
  }
}
void reset() {
  gameMode = 0;
  phase = 0;
  player = new Player(width/2, height/2);
  laser = new ArrayList<Laser>();
  enemy = new ArrayList<Enemy>();
  effect = new ArrayList<Effect>();
  effectBomb = new ArrayList<EffectBomb>();
  enemyBullet = new ArrayList<EnemyBullet>();
}
void enemy_phase() {
  if (phase == 0 && enemy.size()==0) {
    phase = 1;
    enemyCreate(2, width+50, height+50, 50, 5*50);
  } else if (phase == 1 && enemy.size()==0) {
    phase = 2;
    enemyCreate(6, -20, -20, 50, 4*50);
  } else if (phase == 2 && enemy.size()==0) {
    phase = 3;
    enemyCreate(5, width + 20, -20, 50, 4*50);
    enemyCreate(5, -20, height + 20, 50, 4*50);
  } else if (phase == 3 && enemy.size()==0) {
    phase = 4;
    enemyCreate2(1, width + 50, height/2, 150, 2*50);
  } else if (phase == 4 && enemy.size()==0) {
    phase = 5;
    enemyCreate(3, width + 20, -20, 50, 0.5*50);
  } else if (phase == 5 && enemy.size()==0) {
    phase = 6;
    enemyCreate2(5, width + 50, height/2, 150, 1*50);
  } else if (phase == 6 && enemy.size()==0) {
    phase = 7;
    enemyCreate(3, -100, -20, 180, 3*50);
    enemyCreate2(2, width + 50, height/2, 150, 3*50);
  } else if (phase == 7 && enemy.size()==0) {
    phase = 8;
    enemyCreate(30, width + 100, height/2, 25, 0.5*50);
  } else if (phase == 8 && enemy.size()==0) {
    phase = 9;
    enemyCreate(1, width*1.5, height/2, width/2, 3*50);
  } else if (phase == 9 && enemy.size()==0) {
    phase = 10;
    enemyCreate(6, width*1.5, height/2, 100, 0.1*50);
  } else if (phase == 10 && enemy.size()==0) {
    gameMode = 3;
  }
}

void controll() {
  if (keyCode == RIGHT && keyPressed == true) {
    player.xVel += 0.5;
  }
  if (keyCode == LEFT  && keyPressed == true) { 
    player.xVel -= 0.5;
  }
  if (keyCode == UP  && keyPressed == true) {
    player.yVel -= 0.5;
  }
  if (keyCode == DOWN  && keyPressed == true) {
    player.yVel += 0.5;
  }
  if ((key == 'z' || key == ' ') && keyPressed == true) {
    if (player.energy > 0) {
      laser.add(new Laser(player.x, player.y, player.angle));
      laser.add(new Laser(player.x, player.y, player.angle-180));
      player.energy -= 5 * 50 / frameRate;
    }
  }
}
void atari() {
  for (int i =0; i < laser.size(); i ++ ) {
    Laser aaa = laser.get(i);
    boolean a = false;
    for (int j =0; j < enemy.size(); j ++ ) {
      Enemy eee = enemy.get(j);
      if (dist(eee.x, eee.y, aaa.x, aaa.y) <= eee.size/2 + aaa.size/2) {
        for (int num= 0; num < 10; num ++) {
          effect.add(new Effect(aaa.x, aaa.y, 50));
        }
        a = true;
        eee.hp -= 5;
      }
    }
    if (a) {
      laser.remove(i);
      i -= 1;
    }
  }
  for (int i =0; i < enemyBullet.size(); i ++ ) {
    EnemyBullet eb = enemyBullet.get(i);
    boolean a = false;
    if (dist(eb.x, eb.y, player.x, player.y) <= eb.size/3 + player.size/2) {
      a = true;
      player.hp -= eb.damage;
      for (int num= 0; num < 10; num ++) {
        effect.add(new Effect(eb.x, eb.y, 0));
      }
    }
    if (a) {
      enemyBullet.remove(i);
      i -= 1;
    }
  }
}
void updateAll() {
  for (int i =0; i < laser.size(); i ++ ) {
    Laser aaa = laser.get(i);
    aaa.update();
    if (aaa.y > height+aaa.size/2 || aaa.x>width+aaa.size/2 || aaa.x < -aaa.size/2 || aaa.y < -aaa.size/2) {
      laser.remove(i);
      i -= 1;
    }
  }
  for (int i =0; i < enemy.size(); i ++ ) {
    Enemy eee = enemy.get(i);
    eee.update();
    if (eee.hp <= 0) {
      effectBomb.add(new EffectBomb(eee.x, eee.y, eee.col_s, eee.size*8));
      enemy.remove(i);
      i -= 1;
    }
  }
  for (int i =0; i < effect.size(); i ++ ) {
    Effect ef = effect.get(i);
    ef.update();
    if (ef.lifetime <= 0) {
      effect.remove(i);
      i -= 1;
    }
  }
  for (int i =0; i < effectBomb.size(); i ++ ) {
    EffectBomb eb = effectBomb.get(i);
    eb.update();
    if (eb.size > eb.maxsize) {
      effectBomb.remove(i);
      i -= 1;
    }
  }
  for (int i =0; i < enemyBullet.size(); i ++ ) {
    EnemyBullet eb = enemyBullet.get(i);
    eb.update();
    if (eb.y > height+eb.size/2 || eb.x>width+eb.size/2 || eb.x < -eb.size/2 || eb.y < -eb.size/2) {
      enemyBullet.remove(i);
      i -= 1;
    }
  }
}

//通常の蛇
void enemyCreate(int num, float x, float y, float size, float rate) {
  enemy.add(new Enemy(x, y, size, rate));
  for (int i = 1; i < num; i++) {
    enemy.add(new Enemy(x-i, y-i, size, rate, enemy.get(enemy.size()-1)));
  }
}
//足多数
void enemyCreate2(int num, float x, float y, float size, float rate) {
  enemy.add(new Enemy(x, y, size, rate));
  int boss = enemy.size()-1;
  for (int i = 1; i < 4; i++) {
    enemy.add(new Enemy(x-i, y-i, size/(i+1), 3*rate, enemy.get(boss)));
    for (int j = 1; j < num; j ++) {
      enemy.add(new Enemy(x-i, y-i, size /(i+1), 3*rate, enemy.get(enemy.size()-1)));
    }
  }
}
