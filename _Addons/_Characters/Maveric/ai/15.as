//true if within z range
bool zdst(int range){
 if(abs(self.z-target.z)<=range){return true;}
 else{return false;}
}
//true if within x range
bool xdst(int close, int far){
 if(abs(self.x-target.x)>=close && abs(self.x-target.x)<=far){return true;}
 else{return false;}
}
//true if self/target facing
bool facing(int tar){
 if(tar==0){
  if((self.x-target.x)*(2*(self.facing?1:0)-1)>0){return true;}
  else{return false;}
 }
 else{
  if((target.x-self.x)*(2*(target.facing?1:0)-1)>0){return true;}
  else{return false;}
 }
}
//true if hitable
bool canhit(int fall){
 if(fall==2 && (target.state==16||target.state==8)){return true;}
 else if(fall>=1 && target.state==12){return false;}
 else if(target.blink!=0 || target.state==14 || target.state==6){return false;}
 else{return true;}
}
//true if within frame range
bool frame(int first, int last){
 if(self.frame>=first && self.frame<=last){return true;}
 else{return false;}
}
//perform D<>A towards target
void DfA(){
 if((self.x-target.x)<0){DrA();}
 else{DlA();}
}
//perform D<>J towards target
void DJ(){
 if((self.z-target.z)<0){DdJ();}
 else{DuJ();}
}
//perform Dv^J towards target
void DfJ(){
 if((self.x-target.x)<0){DrJ();}
 else{DlJ();}
}
//void unwanted inputs
void inputs(){
 if(self.DuA>=2||self.DrA>=2||self.DlA>=2||self.DdA>=2||self.DuJ>=2||self.DrJ>=2||self.DlJ>=2||self.DdJ>=2){up();down();}
}
//is attacking?
bool attack(){
 if(target.id==self.id && (target.frame==256||target.frame==173||target.frame==193)){return false;}
 int x=target.state;
 int i=0;
 do{x/=10;i++;}while(x>0);
 x=1;for(i; i > 1; --i){x*=10;}
 if(target.state/x==3){return true;}else{return false;}
}
 
int ego(){ 
//dodge
 if(facing(1) && self.state<=1 && zdst(13) && attack()){J();A();return 1;}
 else if(facing(1) && frame(110,111) && zdst(13) && attack()){DJ();return 1;}
 else if(facing(1) && self.state==2 && zdst(13) && attack()){D();A();return 1;}
//counters
 else if(frame(111,111)){
  if(self.mp>=300 && self.hp>=200 && xdst(150,300) && zdst(30)){DdA();}
  else if(self.mp>=145 && canhit(1) && xdst(235,650) && zdst(20)){DfA();}
  else if(self.mp>=250 && canhit(1) && xdst(0,190) && zdst(10)){DfJ();}
  else if(self.mp>=200 && canhit(1) && xdst(0,235) && zdst(80)){DJ();}
  else if(xdst(0,80) && zdst(10)){A();}
  else if(self.dark_hp-self.hp>=75){J();}return 1;
 }
//combos
//DA keep in line
 else if(frame(193,193) && target.state == 12 && zdst(10)){return 1;}
//DJ move away
 else if(frame(172,173) && attack() && zdst(13)){if(self.z-target.z>=0){down();}else{up();}return 1;}
//DJ move closer
 else if(frame(172,173) && !attack()){if(self.z-target.z>=0){up();}else{down();}return 1;}
//Dv^J close in
 else if(frame(256,256)||frame(282,282)){if(self.z-target.z>=0){down();}else{up();}return 1;}
//D<>A continue
 else if(self.mp>=45 && (frame(243,245)||frame(252,252)) && canhit(1) && xdst(235,650) && zdst(20)){A();}
//D<>J combo back
 else if(self.mp>=100 && frame(267,269) && canhit(0) && (facing(0)||(!facing(0) && (xdst(131,150)||(target.y==0&&target.state!=12)))) && zdst(10)){DfJ(); return 1;}
//super punch skip
 else if(self.mp>=175 && frame(77,77) && canhit(0) && facing(0) && zdst(10)){D(); return 1;}
//super punch leap
 else if(frame(77,77) && canhit(0) && facing(0) && zdst(10)){J(); return 1;}
//super punch slice D<>J
 else if(frame(48,48) && canhit(0) && facing(0) && zdst(10)){DfJ(); return 1;}
//D<>J continue
 else if((frame(258,258)||frame(23,23)) && canhit(0) && facing(0) && xdst(0,150) && zdst(10)){J(); return 1;}
//D<>J prevent
 else if((frame(258,258)||frame(23,23)) && !zdst(10)){return 1;}
//start
 else if(self.mp>=360 && self.hp>=140 && xdst(150,300) && zdst(30)){DdA();}
 else if(self.mp>=90 && canhit(1) && xdst(250,650) && zdst(20)){DfA();}
 else if(self.mp>=160 && canhit(1) && xdst(90,190) && zdst(10) && !frame(260,399)){DfJ();}
 else if(self.mp>=160 && canhit(2) && xdst(0,80) && zdst(10) && !frame(260,399)){DfJ();}
 else if(self.mp>=110 && canhit(1) && facing(0) && xdst(0,235) && zdst(80)){DJ();}
 else{inputs();}
 return 0;
}