==========================================================================
 				 	STM's Challenge Stage v1.51 (16 Nov 2018)	
		
 							made by STM1993 				
==========================================================================
LFE Thread: https://www.lf-empire.de/forum/showthread.php?tid=10617


Installation:
Simply put the contents into your LF2 folder.
(stage.dat goes into data, mainoriginal.wma goes to bgm, etc.bmp & etc_mirror.bmp to go into sprite/sys)


About:
The aim is to create a fresh & interesting take on LF2's stage mode by modifying only the stage.dat file.
I didn't like the original LF2 stage and noticed there weren't any decent pure stage modifications around,
so I made my own; less & weaker criminals, more milk, stronger minions, bosses die faster, more exciting.
The stage is meant to be a challenge for singleplayer, but it should remain fun & playable in multiplayer.
Do consider freeing less criminals or even setting difficulty to Crazy if its not challenging enough for you.
I hope you enjoy this stage!
- STM1993


//Rough difficulty level for Hero chars:
Easy:	Henry, Rudolf, Deep, Freeze, 
Medium:	Firen, Woody, Davis, Dennis,
Hard:	John, Louis.
*	For the average player, Normal or Difficult are recommended.
*	For multiplayer, Crazy difficulty is recommended (type lf2.net).
---
//Enemy HP			Original		New				Survival		Ally		**Notes(assume Normal/Difficult)**
Bandit			 	37/50/75	->	60/80/120hp		30/40/60 		100(same)	I want bandits to survive getting 1-hit by >>JA unless you're using Davis/Louis/Firzen.
Hunter 				37/50/75	->	60/80/120hp		30/40/60 		100(same)	Ditto above. Also, they are less common than bandits because they can be quite overpowered at times...
Justin				112/150/225	->	75/100/150hp	45/60/90		-nil-		Intended to be "elite bandits", but stronger than I thought in a group...
Sorcerer			75/100/150	->	90/120/180hp	60/80/120		200->150	What makes them truly dangerous is their normal punching skills.
Knight				150/200/300	->	105/140/210hp	75/100/150		-nil-		That 140hp is carefully chosen so they die in x2 >>JA hits(+2 from armor), or one good combo.
Jack				112/150/225	->	120/160/240hp	90/120/180		150(same)	Makes for a pretty good mid-level enemy.
Mark				150/200/300	->	135/180/270hp	105/140/210		400->150	Extremely high damage & attack priority; used sparingly.
Monk				150/200/300	->	150/200/300hp	120/160/240		400->200	Very tanky, but surprisingly easy to deal with. Just don't let yourself get ganged...
Jan					187/250/375	->	150/200/300hp	135/180/270		500->200	I tend to use a blue Jan soldier for ratio 0.24.
Hero				187/250/375	->	180/240/360hp	150/200/300		-nil-
**Bosses will only have up to 1200(1800)hp instead of insane numbers like 1500/2500(2250/3750)**


//Changelog:
16Nov2018 - A quick patch to 3 typos in lines 1864 blueJan, 2350 blueJan, 2920 soldier.
05May2018 -	Major overhaul to ratios, some changes in stage 3 & 4.
22Apr2018 -	Adjusted a few difficulty issues in stage 5.
16Apr2018 -	Fixed some difficulty issues & bugs in stage 4.
08Apr2018 -	v1.3: Adjusted main stage ratios. Changed the difficulty curve again, especially beyond wave 50.
24Mar2018 -	Added a completely new Survival! All stages have 6 substages now. Some adjustments done, especially to Stage 3 & 4. 
27Jan2017 -	First Release.
28Jan2017 -	Fixed excess milks at start of 5-3, tweaked the difficulty of 5-7 quite a bit(harder on Difficult due to Jan, easier on Crazy).
29Jan2017 -	Fixed a silly bug where 5-7 becomes 5-1.
30Jan2017 -	Fixed an original LF2 bug in Survival phase 25,35,55,65; "id: 300 hp: 50 ratio .3" should be "id: 3000".
03Feb2017 -	Justins in Survival now have 150hp instead of 200hp for consistency. Tweaked stage 3 ratio a little bit.


//Stage Design Notes:
*	LF2's difficulty is hard to adjust; 1p(especially without criminals) is very hard, 2-4p is significantly easier, 5p onwards becomes too chaotic.
*	A major problem is how easy it is to get gang combo'd by AI. Putting a Jan criminal as a healer in each stage is my way to counteract this issue.
*	Another major thing to consider is that the AI loves to pick up weapons. Also, beers are actually very overpowered so they are used sparingly.
*	Criminals have less HP but more lives for 3 reasons: die quicker if all players die, faster MP regeneration, and insurance against spike damage.
*	"Blue" enemies have the same HP regardless of difficulty. Generally act as low HP but constantly respawning soldiers, especially the rare blue Jans.
*	Used several new ratio formulae to try and balance the enemy numbers/composition, but it is frustratingly difficult to adjust.
*	I generally based the level of difficulty around original LF2's stage 3 and survival, which is why the enemy formula may seem very familiar.
*	You will always fight all 10 heroes at least once; Stage 1 = Rudolf, 2 = Davis Dennis Woody, 3 = Deep Henry Louis, 4 = John Firen Freeze.
*	Stage 1 is meant to be a wordless tutorial. Jack & Sorcerer were added to: show chars have moves, reinforce blue=allies & make the stage more fun.
*	Stage 4 is, in my opinion, the hardest stage to make correctly. I keep overhauling it because I'm not satisfied with the gimmicks & difficulty.


//Survival Design Notes:
*	Starts with an armory so you can take a desired weapon. Optional Jan(150hp with x10,001 lives) for players who need a little help.
*	Difficulty starts higher(no 1v1) but rises much more gradually. No ridiculous nonsense waves or repeat waves that don't have milk.
*	Milks have times: 2 during the phase they spawn(less stress during for singleplayer), and less milk ratio(0.5->0.4) for multiplayer.
*	I reduced enemy HP in survival to make progress faster/less tedious. Non-boss HP will only increase by 15/20/30 when you reach wave 71 & 91.
*	Julian is often the last boss standing. Firzen should be a glass cannon. LouisEX is the easiest to kill. Bat's bats are extremely annoying.

//Special Thanks:
*	Vigo/Fonix for being my very first tester and a most supportive friend throughout the development of this stage.
*	KoishiCan, Kaisa, Amadis, BlazingGale, ThrillerBeat for playing through the stage with me online multiplayer.
*	T@L/Shtrudel for feedback & playing through the stage version v1.3c in both Difficult & Crazy with Deep, and getting to Survival wave 70 in Difficult with Woody.
*	Zort for catching some mistakes and testing it out with mfc, Pf and Silverthorn in a 4p survival.
