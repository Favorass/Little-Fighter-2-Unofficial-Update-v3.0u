//Sauce's Rudolf AI.

void id() {

  left(0, 0);
  right(0, 0);
  up(0, 0);
  down(0, 0);
  D(0, 0);
  J(0, 0);
  A(0, 0);

  //Defining variables.
  array < int > enemies;
  array < int > balls;
  array < int > drinks;
  array < int > weapons;
  array < int > flyingweapons;
  enemies.resize(0);
  balls.resize(0);
  drinks.resize(0);
  weapons.resize(0);
  flyingweapons.resize(0);
  bool warning = false;
  bool specialmove = false;
  bool coming = false;
  bool clone = false;
  int milk = -1;
  int beer = -1;
  int choice = -1;
  int limit;
  int randomdifficulty = rand(5) + difficulty;
  bool Hardly = false;
  bool Sometimes = false;
  bool Often = false;
  bool Always = false;
  float mindashx = 5 * self.data.dash_distance;
  float maxdashx = 11 * self.data.dash_distance;
  float mindashz = 5 * self.data.dash_distancez;
  float maxdashz = 11 * self.data.dash_distancez;

  //Stage check.
  if (stage_clear) {
    right(1, 0);
    if (self.state == 2)
      J();
  }

  //Detection.
  for (int i = 0; i < 400; i++) {
    if (game.exists[i]) {
      if (TYPE(i) == 0 && TEAM(i) != self.team && HP(i) > 0)
        enemies.insertLast(i);
      else if (TYPE(i) == 3 && TEAM(i) != self.team)
        balls.insertLast(i);
      else if (TYPE(i) == 6 && STATE(i) == 1004)
        drinks.insertLast(i);
      else if (STATE(i) != 1002 && STATE(i) != 2000 && TEAM(i) != self.team)
        weapons.insertLast(i);
      else if (TEAM(i) != self.team)
        flyingweapons.insertLast(i);
    }
  }

  //Sort.
  if (EXIST(enemies))
    enemies.sort(
      function (a, b) {
        return abs(DX(a)) + abs(DZ(a)) < abs(DX(b)) + abs(DZ(b));
      }
    );
  if (EXIST(balls))
    balls.sort(
      function (a, b) {
        return abs(DX(a)) + abs(DZ(a)) < abs(DX(b)) + abs(DZ(b));
      }
    );
  if (EXIST(drinks))
    drinks.sort(
      function (a, b) {
        return abs(DX(a)) + abs(DZ(a)) < abs(DX(b)) + abs(DZ(b));
      }
    );
  if (EXIST(weapons))
    weapons.sort(
      function (a, b) {
        return abs(DX(a)) + abs(DZ(a)) < abs(DX(b)) + abs(DZ(b));
      }
    );
  if (EXIST(flyingweapons))
    flyingweapons.sort(
      function (a, b) {
        return abs(DX(a)) + abs(DZ(a)) < abs(DX(b)) + abs(DZ(b));
      }
    );

  //Rules.
  if (self.hp == self.max_hp && self.blink == 14 || (mode == 1 && self.team == 1))
    limit = 0;
  for (uint i = 0; i < 400; i++) {
    loadTarget(i);
    if (game.exists[i] && self.team == TEAM(i) && target.clone != -1) {
      clone = true;
      break;
    }
  }

  //Random difficulty setting.
  if (randomdifficulty <= 1)
    Hardly = true;
  if (randomdifficulty <= 2)
    Sometimes = true;
  if (randomdifficulty <= 3)
    Often = true;
  if (randomdifficulty <= 4)
    Always = true;
  //Difficulty randomly distributed:
  //Easy:      2 3 4 5 6 7
  //Normal:    1 2 3 4 5 6
  //Diffcult:  0 1 2 3 4 5
  //CRAZY!:   -1 0 1 2 3 4

  //Dodging,defense or rebound ball.
  if (Always && EXIST(balls) && self.blink <= 14) {
    if (DX(balls[0]) * VX(balls[0]) < 0 && (STATE(balls[0]) == 3000 || STATE(balls[0]) >= 3005)) {
      if (ABSRANGE(balls[0], 250, 30) && self.state == 2)
        TURN();
      if (ABSRANGE(balls[0], 250, 30)) {
        specialmove = true;
        warning = true;
        DODGE(balls[0]);
      }
      if ((ABSRANGE(balls[0], 80, 14) && abs(DY(balls[0])) <= 100) || (VZ(balls[0]) != 0 && ABSRANGE(balls[0], 100, 20)))
        D();
      else if ((self.state <= 1 || self.state == 5) && (ABSRANGE(balls[0], 300, 30) && !ABSRANGE(balls[0], 150, 20) && STATE(balls[0]) == 3000))
        A();
    } else if (ABSRANGE(balls[0], 220, 30) && ID(balls[0]) == 200 && RANGETF(balls[0], 60, 65) && INFRONT(balls[0])) {
      specialmove = true;
      warning = true;
      if (!ISFACING(balls[0]))
        DODGE(balls[0]);
      else if (DX(balls[0]) <= -45)
        left(1, 1);
      else if (DX(balls[0]) >= 45)
        right(1, 1);
      else if (DZ(balls[0]) <= -14)
        up(1, 1);
      else if (DZ(balls[0]) >= 14)
        down(1, 1);
      if (ABSRANGE(balls[0], 55, 18) && ISFACING(balls[0]))
        D();
    } else if (ABSRANGE(balls[0], 70, 40) && (ID(balls[0]) == 211 || (ID(balls[0]) == 212 && RANGETF(balls[0], 150, 170)))) {
      specialmove = true;
      warning = true;
      DODGE(balls[0]);
    } else if (ID(balls[0]) == 212 && ABSRANGE(balls[0], 200, 20) && !RANGETF(balls[0], 150, 170))
      A();
  }

  //Dodging or defense flyingweapon.
  if (Always && EXIST(flyingweapons) && self.blink == 0) {
    if (DX(flyingweapons[0]) * VX(flyingweapons[0]) < 0) {
      if (ABSRANGE(flyingweapons[0], 180, 30)) {
        specialmove = true;
        warning = true;
        DODGE(flyingweapons[0]);
      }
      if (ABSRANGE(flyingweapons[0], 100, 14) || (VZ(flyingweapons[0]) != 0 && ABSRANGE(flyingweapons[0], 80, 20)))
        D();
    }
  }

  //Enemies check.
  if (enemies.length() > 1 && ABSRANGE(enemies[1], 200, 50) && TYPE(enemies[1]) != 5)
    coming = true;

  //Dodging jump attack.
  if (Always && ABSRANGE(enemies[0], 80, 40) && abs(DY(enemies[0])) >= 20 && !GOINGTOBEHITED(enemies[0]) && (STATE(enemies[0]) == 3 || STATE(enemies[0]) == 4) && ID(enemies[0]) != 4 && self.blink == 0) {
    specialmove = true;
    warning = true;
    DODGE2(enemies[0]);
  }
  
  //Dodging run attack.
  if (Always && ABSRANGE(enemies[0], 250, 30) && RANGETF(enemies[0], 85, 89) && self.blink == 0) {
    specialmove = true;
    warning = true;
    DODGE(enemies[0]);
  }

  //Dodging dash attack.
  if (Always && ABSRANGE(enemies[0], 300, 40) && (STATE(enemies[0]) == 5 || RANGETF(enemies[0], 40, 44) || RANGETF(enemies[0], 90, 94)) && INFRONT(enemies[0]) && self.blink == 0) {
    specialmove = true;
    warning = true;
    if (Hardly && (RANGETF(enemies[0], 40, 44) || RANGETF(enemies[0], 90, 94))) {
      if (DX(enemies[0]) <= 0)
        left(1, 0);
      else
        right(1, 0);
    }
    DODGE(enemies[0]);
  }

  //Defense.
  if (Always && (GOINGTOBEHITED(enemies[0]) || (coming && GOINGTOBEHITED(enemies[1]))) && self.blink == 0) {
    specialmove = true;
    warning = true;
    if (!ISFACING(enemies[0]))
      TURN();
    D();
  }

  //Lifting heavy objects.
  if (Always && EXIST(weapons)) {
    for (uint i = 0; i < weapons.length(); i++) {
      if (TYPE(weapons[i]) == 2 && STATE(weapons[i]) == 2004 && (HITABLE(weapons[i], 60) || GOINGTOBEHITED(weapons[i])) && self.weapon_type == 0 && self.state <= 2) {
        A();
        break;
      }
    }
  }

  //Drink.
  if (Always && EXIST(drinks) && self.team == 1 && !warning && !specialmove && mode == 1) {
    for (uint i = 0; i < drinks.length(); i++) {
      if (ID(drinks[i]) == 122) {
        milk = i;
        break;
      }
    }
    for (uint i = 0; i < drinks.length(); i++) {
      if (ID(drinks[i]) == 123) {
        beer = i;
        break;
      }
    }
    if (self.hp <= self.max_hp / 3 && self.weapon_type == 0 && milk != -1)
      choice = milk;
    else if (self.hp >= self.max_hp / 5 * 4 && self.mp <= 150 && self.weapon_type == 0 && beer != -1)
      choice = beer;
    if (choice != -1) {
      specialmove = true;
      if (DX(drinks[choice]) <= -50)
        left(1, 0);
      else if (DX(drinks[choice]) <= -10)
        left(1, 1);
      else if (RANGEX(drinks[choice], 10, 50))
        left(1, 1);
      else if (DX(drinks[choice]) >= 50)
        right(1, 0);
      else if (DX(drinks[choice]) >= 10)
        right(1, 1);
      else if (RANGEX(drinks[choice], -50, -10))
        right(1, 1);
      if (DZ(drinks[choice]) <= -14)
        up(1, 1);
      else if (DZ(drinks[choice]) >= 14)
        down(1, 1);
      if (abs(DX(drinks[choice])) >= 300 && self.state == 2)
        J();
      if (ABSRANGE(drinks[choice], 10, 14) && self.state <= 1)
        A();
    }
  }
  if (self.weapon_type == 6 && (self.hp <= self.max_hp / 2 || self.mp <= 150) && self.state <= 2 && mode == 1 && self.team == 1 && !(ABSRANGE(enemies[0], 200, 50) && self.blink == 0))
    A();
  if (RANGESF(55, 58) && ABSRANGE(enemies[0], 200, 50) && self.blink == 0)
    D();

  //Throwing weapon.
  if (Always && self.weapon_type != 0 && !(self.weapon_type == 6 && (self.hp <= self.max_hp / 2 || self.mp <= 150) && mode == 1)) {
    specialmove = true;
    if (DX(enemies[0]) <= 0)
      left(1, 0);
    else
      right(1, 0);
    if (self.state == 2)
      A();
  }

  //Get far from enemy.
  if (Often && ((self.blink <= 14 && coming && !RANGETF(enemies[0], 55, 58) && !warning) || (STATE(enemies[0]) == 14 && !coming && ID(enemies[0]) != 4 && ID(enemies[0]) != 5) || (BLINK(enemies[0]) != 0 && self.blink == 0 && !RANGETF(enemies[0], 55, 58) && ID(enemies[0]) != 4 && ID(enemies[0]) != 5) || (self.weapon_type == 6 && (self.hp <= self.max_hp / 2 || self.mp <= 150) && mode == 1))) {
    specialmove = true;
    GETFARFROM(enemies[0]);
  }

  //Punch.
  if (Sometimes && ABSRANGE(enemies[0], 250, 30) && self.state <= 1 && abs(DX(enemies[0])) >= 100 && abs(DY(enemies[0])) <= 40 && self.state <= 1 && self.fall <= 10 && STATE(enemies[0]) != 12 && STATE(enemies[0]) != 13 && STATE(enemies[0]) != 14 && STATE(enemies[0]) != 16 && BLINK(enemies[0]) == 0 && self.mp >= 45 && self.weapon_type == 0 && !warning && !specialmove && !(coming && !RANGETF(enemies[0], 55, 58) && self.blink == 0)) {
    if (!INFRONT(enemies[0]))
      TURN();
    A();
  }
  if (Often && FALL(enemies[0]) <= 40 && abs(DX(enemies[0])) >= 80 && abs(DX(enemies[0])) <= 100 && !(self.frame == 63 || self.frame == 67) && self.state <= 1 && STATE(enemies[0]) == 16 && self.mp >= 15 && self.weapon_type == 0 && !warning && !specialmove) {
    specialmove = true;
    if (!INFRONT(enemies[0]))
      TURN();
    A();
    if (DZ(enemies[0]) <= -14)
      up(1, 1);
    else if (DZ(enemies[0]) >= 14)
      down(1, 1);
  }

  //Grab.
  if (Always && STATE(enemies[0]) == 16 && ABSRANGE(enemies[0], 200, 30) && !(coming && self.blink == 0)) {
    specialmove = true;
    if (DX(enemies[0]) <= -10)
      left(1, 1);
    else if (DX(enemies[0]) >= 10)
      right(1, 1);
    else {
      if (self.x >= bg_width / 2)
        left(1, 1);
      else
        right(1, 1);
    }
    if (DZ(enemies[0]) <= -14)
      up(1, 1);
    else if (DZ(enemies[0]) >= 14)
      down(1, 1);
  }

  //Grabbing.
  if (Often && HP(enemies[0]) > 0 && (RANGESF(121, 123) || RANGESF(232, 234))) {
    specialmove = true;
    if (self.clone != -1)
      DJA();
    if ((self.ctimer <= 60 && self.hp > 30) || (coming && self.blink == 0)) {
      if (self.x >= bg_width / 2)
        left(1, 1);
      else
        right(1, 1);
    } else {
      left(0, 0);
      right(0, 0);
    }
    A();
  }

  //Dash attack.
  if (Hardly && abs(DX(enemies[0])) >= mindashx && abs(DX(enemies[0])) <= maxdashx && ((abs(DZ(enemies[0])) >= mindashz && abs(DZ(enemies[0])) <= maxdashz) || abs(DZ(enemies[0])) <= 14) && ((DZ(enemies[0]) == 0 || abs(DX(enemies[0])) / abs(DZ(enemies[0])) >= mindashx / mindashz) || abs(DZ(enemies[0])) <= 14) && BLINK(enemies[0]) == 0 && STATE(enemies[0]) != 14 && STATE(enemies[0]) != 16 && self.weapon_type == 0 && !warning) {
    specialmove = true;
    DASH(enemies[0]);
  }
  if (Hardly && STATE(enemies[0]) == 13 && self.weapon_type == 0 && !warning) {
    specialmove = true;
    DASH(enemies[0]);
  }
  if (Often && self.state == 5 && ABSRANGE(enemies[0], 180, 30) && INFRONT(enemies[0]) && STATE(enemies[0]) != 14 && BLINK(enemies[0]) == 0)
    A();

  //Skills.
  if (Sometimes) {
    //Clone or disappear.
    if (!clone && limit <= 1 && self.state <= 1 && (abs(DZ(enemies[0])) >= 70 || abs(DX(enemies[0])) >= 350 || STATE(enemies[0]) == 14) && self.mp >= 350) {
      if (rand(9) <= 5)
        DuJ();
      else
        DdJ();
      limit++;
    }
    //Five punch.
    if (ABSRANGE(enemies[0], 100, 30) && abs(DX(enemies[0])) >= 70 && abs(DY(enemies[0])) <= 40 && self.mp >= 100 && self.mp <= 200 && self.fall == 0 && STATE(enemies[0]) != 12 && STATE(enemies[0]) != 14 && STATE(enemies[0]) != 16 && BLINK(enemies[0]) == 0 && !warning) {
      if (DX(enemies[0]) <= 0)
        DlA();
      else
        DrA();
    }
    //Jump sword.
    if (Hardly && ID(enemies[0]) != 6 && (RANGESF(105, 107) || self.frame == 109) && abs(DZ(enemies[0])) <= 10 && !RANGETF(enemies[0], 110, 111) && BLINK(enemies[0]) == 0 && !warning) {
      if (RANGEX(enemies[0], -150, -120))
        DlJ();
      else if (RANGEX(enemies[0], 120, 150))
        DrJ();
      else if (abs(DX(enemies[0])) <= 60) {
        if (DX(enemies[0]) <= 0)
          DlJ();
        else
          DrJ();
      }
    }
  }

  //Special direction.
  if ((RANGEX(enemies[0], -250, -30) || RANGEX(enemies[0], 30, 250)) && (RANGESF(59, 69) || RANGESF(285, 289))) {
    specialmove = true;
    if (STATE(enemies[0]) != 14 && INFRONT(enemies[0]) && FALL(enemies[0]) <= 20)
      A();
    if (DZ(enemies[0]) <= -14)
      up(1, 1);
    else if (DZ(enemies[0]) >= 14)
      down(1, 1);
    else {
      up(0, 0);
      down(0, 0);
    }
  }

  //Rowing2.
  if (Hardly && abs(DX(enemies[0])) <= 80 && abs(DZ(enemies[0])) <= 14 && STATE(enemies[0]) != 12 && STATE(enemies[0]) != 14 && STATE(enemies[0]) != 16 && !specialmove && !warning) {
    specialmove = true;
    if (self.x >= bg_width / 2)
      left(1, 0);
    else
      right(1, 0);
    if (self.state == 2)
      D();
  }

  //Dash2.
  if (Sometimes && ABSRANGE(enemies[0], 100, 25) && self.state <= 2 && STATE(enemies[0]) != 16 && !specialmove && !warning) {
    specialmove = true;
    if (rand(5) <= 2)
      left(1, 0);
    else
      right(1, 0);
    if (self.state == 2) {
      if (DZ(enemies[0]) <= 14)
        up(1, 1);
      else if (DZ(enemies[0]) >= -14)
        down(1, 1);
      J();
    }
    if (self.state == 5 && (!ISFACING(enemies[0]) || !INFRONT(enemies[0])))
      TURN();
  }

  //Walking and running.
  if (Always && !warning && !specialmove) {
    if (abs(DX(enemies[0])) <= 350) {
      if (DX(enemies[0]) <= -80) {
        if (Sometimes && self.state == 2 && STATE(enemies[0]) <= 1 && !warning)
          right(1, 0);
        left(1, 1);
      } else if (DX(enemies[0]) >= 80) {
        if (Sometimes && self.state == 2 && STATE(enemies[0]) <= 1 && !warning)
          left(1, 0);
        right(1, 1);
      } else if (Hardly && FALL(enemies[0]) == 0 && STATE(enemies[0]) <= 1 && abs(DZ(enemies[0])) >= 14)
        GETFARFROM(enemies[0]);
    } else {
      if (DX(enemies[0]) <= 0)
        left(1, 0);
      else
        right(1, 0);
      if (Hardly && self.state == 2 && (DX(enemies[0])) > maxdashx * 4)
        J();
    }
    if (abs(DX(enemies[0])) <= 80) {
      if (abs(DZ(enemies[0])) <= 20 && (RANGETF(enemies[0], 20, 29) || RANGETF(enemies[0], 35, 39) || (RANGETF(enemies[0], 60, 94) && ID(enemies[0]) != 4 && ID(enemies[0]) != 5))) {
        up(0, 0);
        down(0, 0);
      } else if (DZ(enemies[0]) <= -14 || self.x == bg_zwidth2)
        up(1, 1);
      else if (DZ(enemies[0]) >= 14 || self.x == bg_zwidth1)
        down(1, 1);
    } else if (self.blink == 0) {
      if (DZ(enemies[0]) <= -14 || self.x == bg_zwidth2)
        up(1, 1);
      else if (DZ(enemies[0]) >= 14 || self.x == bg_zwidth1)
        down(1, 1);
    }
  }

  //Countermeasure.
  if (Sometimes) {
    switch (game.objects[enemies[0]].data.id) {

      case (1): //Enemy is Deep.
      {
        if (FRAME(enemies[0]) == 310)
          A();
        if (ABSRANGE(enemies[0], 80, 25) && (RANGETF(enemies[0], 210, 212) || RANGETF(enemies[0], 260, 264) || RANGETF(enemies[0], 277, 280)))
          DODGE(enemies[0]);
        if (self.state == 12 && (RANGETF(enemies[0], 266, 270) || FRAME(enemies[0]) == 295 || FRAME(enemies[0]) == 299 || FRAME(enemies[0]) == 304))
          J();
        break;
      }

      case (2): //Enemy is John.
      {
        if (self.state == 12 && (FRAME(enemies[0]) == 90 || RANGETF(enemies[0], 237, 239) || RANGETF(enemies[0], 292, 293)))
          J();
        break;
      }

      case (4): //Enemy is Henry.
      {
        if (RANGETF(enemies[0], 60, 62) && ABSRANGE(enemies[0], 120, 30) && ISFACING(enemies[0]) && self.state <= 1)
          A();
        if (ABSRANGE(enemies[0], 400, 14) && FRAME(enemies[0]) == 239 && self.blink == 0) {
          if (!INFRONT(enemies[0]))
            TURN();
          D();
        }
        if (self.state == 12 && RANGETF(enemies[0], 237, 239))
          J();
        if (RANGETF(enemies[0], 250, 255) && ABSRANGE(enemies[0], 400, 80) && self.blink == 0) {
          specialmove = true;
          warning = true;
          if (self.state == 2 && !self.facing)
            left(1, 0);
          else if (self.state == 2 && self.facing)
            right(1, 0);
          if (ABSRANGE(enemies[0], 210, 80)) {
            left(0, 0);
            right(0, 0);
            up(0, 0);
            down(0, 0);
          }
        }
        break;
      }

      case (5): //Enemy is Rudolf.
      {
        if (self.state == 12 && (RANGETF(enemies[0], 76, 79) || RANGETF(enemies[0], 86, 89) || RANGETF(enemies[0], 90, 94)))
          J();
        break;
      }

      case (6): //Enemy is Louis.
      {
        if (ABSRANGE(enemies[0], 400, 14) && FRAME(enemies[0]) == 239 && self.blink == 0) {
          if (!INFRONT(enemies[0]))
            TURN();
          D();
        }
        break;
      }

      case (7): //Enemy is Firen.
      {
        if (RANGETF(enemies[0], 72, 75) && ABSRANGE(enemies[0], 60, 14))
          D(0, 0);
        if (RANGETF(enemies[0], 285, 289) && ABSRANGE(enemies[0], 60, 50) && self.blink == 0)
          D();
        if ((RANGETF(enemies[0], 270, 275)) && abs(DX(enemies[0])) >= 40 && ABSRANGE(enemies[0], 200, 40)) {
          specialmove = true;
          DODGE(enemies[0]);
        }
        break;
      }

      case (8): //Enemy is Freeze.
      {
        if (self.state == 12 && RANGETF(enemies[0], 90, 91))
          J();
        if ((RANGETF(enemies[0], 250, 252) || RANGETF(enemies[0], 260, 268)) && abs(DX(enemies[0])) >= 40 && ABSRANGE(enemies[0], 200, 40)) {
          specialmove = true;
          DODGE(enemies[0]);
        }
        break;
      }

      case (9): //Enemy is Dennis.
      {
        if (ABSRANGE(enemies[0], 200, 30) && (RANGETF(enemies[0], 282, 287)) || (ABSRANGE(enemies[0], 80, 25) && RANGETF(enemies[0], 265, 273)))
          DODGE(enemies[0]);
        break;
      }

      case (10): //Enemy is Woody.
      {
        if (ABSRANGE(enemies[0], 150, 40) && RANGETF(enemies[0], 70, 72)) {
          warning = true;
          if (ABSRANGE(enemies[0], 80, 25))
            DODGE(enemies[0]);
        }
        if (self.state == 12 && (RANGETF(enemies[0], 70, 72) || RANGETF(enemies[0], 90, 90) || RANGETF(enemies[0], 250, 254)))
          J();
        break;
      }

      case (11): //Enemy is Davis.
      {
        if (ABSRANGE(enemies[0], 80, 25) && RANGETF(enemies[0], 270, 280))
          DODGE(enemies[0]);
        if (FRAME(enemies[0]) == 274)
          A();
        if (RANGETF(enemies[0], 277, 280) && ABSRANGE(enemies[0], 60, 14))
          D(0, 0);
        if (self.state == 12 && (RANGETF(enemies[0], 290, 293) || RANGETF(enemies[0], 300, 303)))
          J();
        break;
      }

      default:
        break;
    }
  }

  //Print.
  // clr();
  // if (EXIST(enemies)) {
  //   print("Enemy coming!" + "\n");
  //   print("Distancex:" + DX(enemies[0]) + "\n");
  //   print("Distancey:" + DY(enemies[0]) + "\n");
  //   print("Distancez:" + DZ(enemies[0]) + "\n");
  // }
  // if (EXIST(balls)) {
  //   print("Ball coming!" + "\n");
  //   print("Distancex:" + DX(balls[0]) + "\n");
  //   print("Distancey:" + DY(balls[0]) + "\n");
  //   print("Distancez:" + DZ(balls[0]) + "\n");
  // }
  // if (EXIST(drinks))
  //   print("There's a drink!" + "\n");
  // if (EXIST(weapons))
  //   print("Weapon!" + "\n");
  // if (EXIST(flyingweapons))
  //   print("Weapon attacking!" + "\n");
}

//Defining functions.
float DX(int i) {
  return game.objects[i].x - self.x;
}
float DY(int i) {
  return game.objects[i].y - self.y;
}
float DZ(int i) {
  return game.objects[i].z - self.z;
}
float VX(int i) {
  return game.objects[i].x_velocity;
}
float VY(int i) {
  return game.objects[i].y_velocity;
}
float VZ(int i) {
  return game.objects[i].z_velocity;
}
float ID(int i) {
  return game.objects[i].data.id;
}
float TYPE(int i) {
  return game.objects[i].data.type;
}
float FRAME(int i) {
  return game.objects[i].frame1;
}
float STATE(int i) {
  return game.objects[i].data.frames[game.objects[i].frame1].state;
}
float TEAM(int i) {
  return game.objects[i].team;
}
float FALL(int i) {
  return game.objects[i].fall;
}
float BDEFEND(int i) {
  return game.objects[i].bdefend;
}
float AREST(int i) {
  return game.objects[i].arest;
}
float VREST(int i) {
  return game.objects[i].vrest;
}
float BLINK(int i) {
  return game.objects[i].blink;
}
float HP(int i) {
  return game.objects[i].hp;
}
bool EXIST(int[] a) {
  return (a.length() != 0);
}
bool RANGEX(int i, int a, int b) {
  return game.objects[i].x - self.x >= a && game.objects[i].x - self.x <= b;
}
bool RANGEY(int i, int a, int b) {
  return game.objects[i].y - self.y >= a && game.objects[i].y - self.y <= b;
}
bool RANGEZ(int i, int a, int b) {
  return game.objects[i].z - self.z >= a && game.objects[i].z - self.z <= b;
}
bool RANGESF(int a, int b) {
  return self.frame >= a && self.frame <= b;
}
bool RANGETF(int i, int a, int b) {
  return game.objects[i].frame1 >= a && game.objects[i].frame1 <= b;
}
bool ABSRANGE(int i, int a, int b) {
  return abs(game.objects[i].x - self.x) <= a && abs(game.objects[i].z - self.z) <= b;
}
bool INFRONT(int i) {
  return (game.objects[i].x - self.x) * (self.facing ? -1 : 1) > 0;
}
bool FACING(int i) {
  return game.objects[i].facing;
}
bool ISFACING(int i) {
  return (self.facing && !game.objects[i].facing) || (!self.facing && game.objects[i].facing);
}
bool HITABLE(int i, int frame) {
  const ObjectArray @obj = game.objects;
  const FrameArray @obj_f = obj[i].data.frames;
  const FrameArray @obj_sf = obj[self.num].data.frames;
  const ItrArray @obj_sitr = obj_sf[frame].itrs;
  const BdyArray @obj_bdy = obj_f[obj[i].frame1].bdys;
  if (obj_f[obj[i].frame1].bdy_count > 0) {
    float itrx1 = self.x + (obj_sitr[0].x - obj_sf[frame].centerx) * (self.facing ? -1 : 1);
    float itrx2 = self.x + (obj_sitr[0].x - obj_sf[frame].centerx + obj_sitr[0].w) * (self.facing ? -1 : 1);
    float bdyx1 = game.objects[i].x + (obj_bdy[0].x - obj_f[obj[i].frame1].centerx) * (FACING(i) ? -1 : 1);
    float bdyx2 = game.objects[i].x + (obj_bdy[0].x - obj_f[obj[i].frame1].centerx + obj_bdy[0].w) * (FACING(i) ? -1 : 1);
    float itry1 = self.y - obj_sf[frame].centery + obj_sitr[0].y;
    float itry2 = self.y - obj_sf[frame].centery + obj_sitr[0].y + obj_sitr[0].h;
    float bdyy1 = game.objects[i].y - obj_f[obj[i].frame1].centery + obj_bdy[0].y;
    float bdyy2 = game.objects[i].y - obj_f[obj[i].frame1].centery + obj_bdy[0].y + obj_bdy[0].h;
    if (((itrx2 >= bdyx1 && itrx1 <= bdyx2) ||
        (itrx2 <= bdyx1 && itrx1 >= bdyx2) ||
        (itrx2 >= bdyx2 && itrx1 <= bdyx1) ||
        (itrx2 <= bdyx2 && itrx1 >= bdyx1)) &&
      (itry2 >= bdyy1 && itry1 <= bdyy2) &&
      abs(DZ(i)) <= 14)
      return true;
  }
  return false;
}
bool GOINGTOBEHITED(int i) {
  const ObjectArray @obj = game.objects;
  const FrameArray @obj_f = obj[i].data.frames;
  const FrameArray @obj_sf = obj[self.num].data.frames;
  const ItrArray @obj_itr = obj_f[obj[i].frame1].itrs;
  const BdyArray @obj_sbdy = obj_sf[obj[self.num].frame1].bdys;
  if (obj_f[obj[i].frame1].itr_count > 0 && obj_itr[0].kind == 0 && obj_sf[self.frame].bdy_count > 0) {
    float itrx1 = game.objects[i].x + (obj_itr[0].x - obj_f[obj[i].frame1].centerx) * (FACING(i) ? -1 : 1);
    float itrx2 = game.objects[i].x + (obj_itr[0].x - obj_f[obj[i].frame1].centerx + obj_itr[0].w) * (FACING(i) ? -1 : 1);
    float bdyx1 = self.x + (obj_sbdy[0].x - obj_sf[self.frame].centerx) * (self.facing ? -1 : 1);
    float bdyx2 = self.x + (obj_sbdy[0].x - obj_sf[self.frame].centerx + obj_sbdy[0].w) * (self.facing ? -1 : 1);
    float itry1 = game.objects[i].y - obj_f[obj[i].frame1].centery + obj_itr[0].y;
    float itry2 = game.objects[i].y - obj_f[obj[i].frame1].centery + obj_itr[0].y + obj_itr[0].h;
    float bdyy1 = self.y - obj_sf[self.frame].centery + obj_sbdy[0].y;
    float bdyy2 = self.y - obj_sf[self.frame].centery + obj_sbdy[0].y + obj_sbdy[0].h;
    if (((itrx2 >= bdyx1 && itrx1 <= bdyx2) ||
        (itrx2 <= bdyx1 && itrx1 >= bdyx2) ||
        (itrx2 >= bdyx2 && itrx1 <= bdyx1) ||
        (itrx2 <= bdyx2 && itrx1 >= bdyx1)) &&
      (itry2 >= bdyy1 && itry1 <= bdyy2) &&
      abs(DZ(i)) <= 14)
      return true;
    if ((DX(i) * VX(i) <= 0 && (abs(DX(i)) <= abs(VX(i)) * 7 && (VZ(i) == 0 || abs(DZ(i)) <= abs(VZ(i)) * 7)) || (VY(i) != 0 && abs(DY(i)) <= abs(VY(i)) * 10)) && abs(DX(i)) <= 100 && abs(DY(i)) <= 100 && abs(DZ(i)) <= 20)
      return true;
  }
  return false;
}
void TURN() {
  if (!self.facing)
    left(1, 0);
  else
    right(1, 0);
}
void DODGE(int i) {
  if (!INFRONT(i))
    TURN();
  if (self.z == bg_zwidth2)
    up(1, 1);
  else if (self.z == bg_zwidth1)
    down(1, 1);
  else if (DZ(i) >= 0)
    up(1, 1);
  else
    down(1, 1);
  if (ABSRANGE(i, 120, 20) && (self.state == 2 || self.frame == 215))
    D();
}
void DODGE2(int i) {
  float maxdashx = 11 * self.data.dash_distance;
  if (self.x >= maxdashx && self.x <= bg_width - maxdashx) {
    if (DX(i) > 0)
      left(1, 1);
    else if (DX(i) < 0)
      right(1, 1);
  } else {
    if (self.x >= bg_width - maxdashx)
      left(1, 1);
    else
      right(1, 1);
  }
  if (DZ(i) >= 20 && DZ(i) <= 80)
    up(1, 1);
  else if (DZ(i) >= -80 && DZ(i) <= -20)
    down(1, 1);
  else {
    if (VZ(i) >= 0)
      up(1, 1);
    else
      down(1, 1);
  }
}
void GETFARFROM(int i) {
  float maxdashx = 11 * self.data.dash_distance;
  if (ABSRANGE(i, 200, 50) && self.state != 5) {
    if (self.x >= maxdashx && self.x <= bg_width - maxdashx) {
      if (DX(i) > 0)
        left(1, 0);
      else if (DX(i) < 0)
        right(1, 0);
    } else {
      if (self.x >= bg_width - maxdashx)
        left(1, 0);
      else
        right(1, 0);
    }
    if (DZ(i) <= -14)
      up(1, 1);
    else if (DZ(i) >= 14)
      down(1, 1);
    if (STATE(i) != 5 && (self.state == 2 || self.frame == 215))
      J();
  }
}
void DASH(int i) {
  if (DX(i) <= 0)
    left(1, 0);
  else
    right(1, 0);
  if (DZ(i) <= -14)
    up(1, 1);
  else if (DZ(i) >= 14)
    down(1, 1);
  else {
    up(0, 0);
    down(0, 0);
  }
  if (STATE(i) != 5 && (self.state == 2 || self.frame == 215))
    J();
}