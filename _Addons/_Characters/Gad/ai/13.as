float gravitycounter = 1.7;
int lastX = 0;


 int target_landing_X()
 {
// calculates where enemy will land / Xcoord
	 float curX = target.x;
	 float curY = target.y;
	 float curYvel = target.y_velocity;
	 float curZ = target.z;

	 while (curY<0)
	 {
		  
		 curY += curYvel;
		 curX += target.x_velocity;
		 curZ += target.z_velocity;
		 curYvel += gravitycounter;
		
		 
		 
	 }
	 if (target.state == 5)
	 {
		 int f = 1;
		 if (target.facing) f = -1;
		 curX = curX + (20 * f);
	 }
	 if (target.y < 0)lastX = curX;
	 return curX;
 }
 
 void regularpunch()
 {
	 movetotarget();
	 A();
 }
 
 
 void LoadClosestTarget()
 {
	  int k = 0;
	int distX = 9999999;
	int projX = 999999;
	
	 for (int i = 0; i < 400; ++i){
	

	if(loadTarget(i) == 0 && target.team != self.team && abs(target.x - self.x) < distX && target.type == 0)
	{
	 distX = abs(target.x - self.x);
	 k = i;
	}
	}
	loadTarget(k);
 }
 

 bool doesrectanglescollide(int xA, int yA,int cxA,int cyA, bool facing1,int x1,int y1, int w1,int h1, int xB, int yB,int cxB,int cyB,bool facing2, int x2, int y2, int w2,int h2)
{
	int calc = 1;
	if (facing1) calc = -1;
	int calc2 = 1;
	if (facing2) calc2 = -1;
	
	
	int rectXstart = xA + x1 - cxA;
	int rectXend = rectXstart + w1;
	int rectYstart = yA + y1 - cyA;
	int rectYend = yA + h1;
	if (calc < 0)
	{
		rectXend = xA - x1 + cxA;
		rectXstart = rectXend - w1;
	}
	
	
	int rect2Xstart = xA + x2 - cxB;
	int rect2Xend = rect2Xstart + w2;
	int rect2Ystart = yB + y2 - cyB;
	int rect2Yend = yB + h2;
	if (calc2 < 0)
	{
		rect2Xend = xB - x2 + cxB;
		rect2Xstart = rect2Xend - w2;
	}
	bool docollide = false;
	if (rectXstart < rect2Xend && rectXend > rect2Xstart && rectYstart < rect2Yend && rectYend > rect2Ystart ) docollide = true;
	return docollide;
}

 
 bool targetafterpunch()
 {
	return((target.frame >= 62 && target.frame < 65) || (target.frame >= 67 && target.frame < 70));
 }
 
bool targetbeforepunch()
{
	return ((target.frame == 60) || (target.frame == 65));
}

bool potentialdangerzone()
 {
  return(xdistance() < 300);

 }
 
 void dash_attack()
 {
	if (target.y < 0)
	{
	}
	else
	{
		 if (zdistance()> 12) 
		 {
			 if (target.z_velocity != 0 && target.y < 0)
			 {
				 if (target.z_velocity < 0) up(1,0);
				 else  down(1,0);
			 }
			 
			 else movetotargetZ();
		 }
		 
		 if (is_target_on_left())
		 {
			 left();
			 left();
		 }
		 else
		 {
			 right();
			 right();
		 }
		 if(self.state == 2)
		 {
			 J();
			 A();
		 }
	}
	 
 }
 bool istargetrunningstraight()
 {
	 return((target.state ==2 || target.state == 19) && xrange(170,250) && facing_against());
 }
void defend(){
   //turn against target and defend
   turn_to_target();
   D(1,0);
}

void turn_to_target()
{
	if(!facing_against()){turn_self();}
}
 
void dodge(){
   //walk out of zrange
   if((zdistance()>0&&zborder1()>15)||zborder2()<=15){up(1,0);}else{down(1,0);}
}
 
 void movetotargetZ()
 {
	 if (target.z < self.z)up(1,0);
	 else down(1,0);
 }
 
  void movetotarget()
 {
	 if (target.x < self.x)left(1,0);
	 else right(1,0);
 }
void inputs(){
   //void inputs
   up(0,0);down(0,0);left(0,0);right(0,0);D(0,0);J(0,0);A(0,0);
}
 
void stall(){
   //flip or defend
   if((self.frame >=12) && (self.frame <=19))
   {
	   if (self.mp >60) J(1,0);
	   else A(0,0);
	 
   }
	else
	{
		if(self.state==12){J(1,0);}else{defend();}
	}
}
 
void turn_self(){
   //turn around
   if(self.facing){right(1,0);}else{left(1,0);}
}

bool check_for_itr(bool checknextframe)
{
	

	int nextframe = target.data.frames[target.frame].next;
	bool isnextitred = false;
	bool isthisitred = is_targets_frame_attacking(target.frame);
	

return true;

}

bool is_targets_frame_attacking(int framenum)
{
	bool isit = false;
	if (!(framenum == 0 || framenum >= 400))
	{
		
			for(int i = 0; i < target.data.frames[framenum].itr_count; ++i)
			{
				int knd = target.data.frames[framenum].itrs[i].kind;
				if  (knd == 0 || knd == 1 || knd == 6 || knd == 4) isit = true;
			}
	}
	return isit;
}
 
int ego()
{
	int RT = 1;
	LoadClosestTarget();
	inputs();
	clr();
	
	if (target.type!= 0) RT = 0;
	else if (self.frame >= 353 && self.frame <= 356)
	{
		if(more_enemies_around(true)) J();
	}
	else
	{	
		if (self.mp >= 125 && target.state == 7 && xrange(20,80) && self_facing())
		{
			DuJ();
		}
		else if (self.y == 0 &&  self_facing() && self.mp >= 125 && abs(xdistance())>90 && abs(xdistance())< 250 && abs(ydistance()) < 20 && abs(zdistance()) < 13 && (target.y == 0 || target_above_ground_hitable()))
		{
			if (istargetrunningstraight() || target_knockable() || target_dop() || target_open())
			{
				D();
				movetotarget();
				A();
			}
			else DuJ();
		}
		else if (self.y == 0 &&!target_dop() && target_hitable() && !danger() && self_facing() && abs(xdistance()) <= 50 && abs(zdistance()) < 12 && target.y == 0 && self.mp >= 75 ) DdA();
		else if (((is_before_spin_combo()) || (target_above_ground_hitable() && xrange(60,200) && abs(ydistance()) < 100)) && (self.mp >= 200 && self_facing()))
		{
			D();
			movetotarget();
			J();
		}
		else if(danger()){stall();}
		else if(marked()){dodge();}
		else if(istargetrunningstraight())
		{
			if (self.mp>=125 && abs(xdistance()) < 200) DuJ();
			else dash_attack();
		}
		else RT = 0;
	}
   
return RT;
}
 bool will_dash_thru()
 {
 // checks if enemy in air jump in front or behind self
 
 
	return ((is_target_on_left() && target_landing_X() > self.x - 70) || (!is_target_on_left() && target_landing_X() < self.x + 70));
 }

 bool is_target_on_left()
 {

	return(self.x > target.x);
 }
 
bool more_enemies_around(bool facethem)
{
	int k=target.num;
   for (int i=0;i<400;++i){
      if (i!=k && loadTarget(i)!=-1&&target.team!=self.team&& target.type ==0 &&zrange(0,15)&&xrange(10,100)&&yrange(0,130)){
		  if (facethem)
		  {			  
			if (xdistance()<0)
			left();
			else
			right();
		  }
         return true;
      }
   }
   loadTarget(k);
   return false;
}
 
 bool is_before_spin_combo()
 {
	 return((self.frame == 247 || self.frame == 248 || self.frame == 215) && target_above_ground_hitable() && abs(xdistance()) < 230);
 }
bool danger(){
   //is there a dangerous object within range?
   int k=target.num;
   for (int i=0;i<400;++i){
      if (loadTarget(i)!=-1&&target.team!=self.team&&zrange(0,15)&&xrange(0,80)&&yrange(0,130)&&target_attacking()){
         return true;
      }
   }
   if(loadTarget(k)==-1){loadTarget(self.num);}
   return false;
}

bool target_above_ground_hitable()
{
	return (((target.y < 0 && target.y_velocity < 0 )||  (target.y < -100 && target.y_velocity > 0 )) && target.y > -300);
}
 
bool facing_against(){
   //true if self and target face opposite directions
   return (self.facing!=target.facing)?true:false;
}
 
int facing_distance(){
   //positive: target distance to the front
   return -xdistance()*(2*(self.facing?1:0)-1);
}
 
bool marked(){
   //is there a dangerous object intercepting with self position?
   int k=target.num;
   for (int i=0;i<400;++i){
      if (loadTarget(i)!=-1&&target.team!=self.team&&will_collide()&&target_attacking()){
         return true;
      }
   }
   if(loadTarget(k)==-1){loadTarget(self.num);}
   return false;
}
 
bool range(int min, int max, int value){
   //true if between min and max
   return (value>=min&&value<=max)?true:false;
}
 
bool will_collide(){
   //is there an object within zrange straight flying towards self?
   return((zrange(0,15)&&target.z_velocity==0)&&target.x_velocity*xdistance()<0)?true:false;
}
 
int xdistance(){
   //positive: target distance to the right
   return target.x-self.x;
}
 
bool xrange(int min, int max){
   //true if between min and max
   return range(min,max,abs(xdistance()));
}
 
int zborder1(){
   //distance to the top
   return target.z-bg_zwidth1;
}
 
int zborder2(){
   //distance to the bottom
   return bg_zwidth2-target.z;
}
 
int zdistance(){
   //positive: target distance to the bottom
   return target.z-self.z;
}

int futurezdistance(){
   //positive: target distance to the bottom
   return (target.z+target.z_velocity)-(self.z+self.z_velocity);
}

int ydistance(){
   //positive: target distance to the bottom
   return target.y-self.y;
}
 
bool zrange(int min, int max){
   //true if between min and max
   return range(min,max,abs(zdistance()));
}

bool yrange(int min, int max){
   //true if between min and max
   return range(min,max,abs(ydistance()));
}
 
bool self_attacking(){
   //true if self within state: 3* or 18 or 19 or 1002 or 2000
   int x=self.state;
   int i=0;
   do{x/=10;i++;}while(x>0);
   x=1;
   for(i;i>1;--i){x*=10;}
   return (self.state/x==3||self.state==18||self.state==19||target.state==1002||target.state==2000)?true:false;
}
bool target_attacking(){
   //true if target within state: 3* or 18 or 19 or 1002 or 2000
   int x=target.state;
   int i=0;
   do{x/=10;i++;}while(x>0);
   x=1;
   for(i;i>1;--i){x*=10;}
   return (target.state/x==3||target.state==18||target.state==19||target.state==1002||target.state==2000||(target.y < 0 && check_for_itr(true) && will_dash_thru()))?true:false;
}
 
bool self_dop(){
   //true if within dance of pain/catchable
   return (self.state==16)?true:false;
}
bool target_dop(){
   //true if within dance of pain/catchable
   return (target.state==16)?true:false;
}
 
bool self_facing(){
   //true if self facing target
   return (facing_distance()>0)?true:false;
}
bool target_facing(){
   //true if target facing self
   return (xdistance()*(2*(target.facing?1:0)-1)>0)?true:false;
}
 
bool self_frame(int min, int max){
   //true if between min and max
   return range(min,max,self.frame);
}
bool target_frame(int min, int max){
   //true if between min and max
   return range(min,max,target.frame);
}
 
bool self_ground(){
   //true if self on ground
   return (self.y==0&&self.state!=4&&self.state!=5&&self.state!=12)?true:false;
}
bool target_ground(){
   //true if target on ground
   return (target.y==0&&target.state!=4&&target.state!=5&&target.state!=12)?true:false;
}
 
bool self_hitable(){
   //true if self hitable
   return (self.blink==0&&self.state!=6&&self.state!=12&&self.state!=14)?true:false;
}
bool target_hitable(){
   //true if target hitable
   return (target.blink==0&&target.state!=6&&target.state!=12&&target.state!=14)?true:false;
}
 
bool self_knockable(){
   //true if self knockable
   return (self.blink==0&&self.state!=6&&self.state!=14)?true:false;
}
bool target_knockable(){
   //true if target knockable
   return (target.blink==0&&target.state!=6&&target.state!=14)?true:false;
}
 
bool self_open(){
   //true if immobile for a longer period
   return (self_dop()||self.state==8||self.state==13||self_frame(130,132))?true:false;
}
bool target_open(){
   //true if immobile for a longer period
   return (target_dop()||target.state==8||target.state==13||target_frame(130,132))?true:false;
}