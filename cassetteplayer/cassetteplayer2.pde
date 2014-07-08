int cassettex,cassettey;
float deck1x,deck1y;
float deck2x,deck2y;
float playx,playy;
float stopx,stopy;
float forwardx,forwardy;
float backwardx,backwardy;

boolean deck1Playing = false;
float rotateDeck1 = 0;
float rotateDeck2 = 0;
float currentFrame = 0;
int margin = width/10;
PImage cassette;
PImage playicon;
PImage forward;
PImage backward;
PImage stop;
PImage [] recordPlayer;
Maxim maxim;
AudioPlayer player1;
float speedAdjust=1.0;

void setup()
{
  size(768,1024);
  recordPlayer = loadImages("black-record_", ".png", 36);
  cassette = loadImage("casette.png");
  playicon=loadImage("play.png");
  stop=loadImage("stop.png");
  forward=loadImage("forward.png");
  backward=loadImage("backward.png");
  maxim=new Maxim(this);
  player1=maxim.loadFile("abc.wav");
  player1.setLooping(true);
  background(255);
  
}
void draw()
{
  background(255); 
  
  image(cassette,1*width/8,height/7,6*width/8,3*height/7);
  
  deck1x = 01.5*width/8+3*margin;
  deck1y = 1.75*height/7+4*margin;
  image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width, 0.9*recordPlayer[0].height);
  
  deck2x = 02*width/8+3*margin+recordPlayer[0].width+20*margin;
  deck2y = 1.75*height/7+4*margin;
  image(recordPlayer[(int) rotateDeck2], deck2x, deck2y, recordPlayer[0].width, 0.9*recordPlayer[0].height);
  
  playx=2.15*width/8+3*margin;
  playy = 3.45*height/7+2*margin;
  image(playicon,playx,playy,0.18*playicon.width,0.18*playicon.height);
  
  backwardx=playx+width/8;
  backwardy=playy;
  image(backward,backwardx,backwardy,0.18*playicon.width,0.18*playicon.height);
  
  forwardx= backwardx+width/8;
  forwardy=backwardy;
  image(forward,forwardx,forwardy,0.18*playicon.width,0.18*playicon.height);

  stopx=forwardx+width/8;
  stopy=forwardy;
  image(stop,stopx,stopy,0.18*playicon.width,0.18*playicon.height);

  if(deck1Playing){
    player1.speed(speedAdjust);
    currentFrame=currentFrame+1*speedAdjust;
  }
  
  if (deck1Playing) {

    rotateDeck1 += 1*speedAdjust;
    rotateDeck2 += 1*speedAdjust;

    if (rotateDeck1 >= recordPlayer.length) {

      rotateDeck1 = 0;
      rotateDeck2=0;
    }
  }


}
void mouseClicked()
{
  if(dist(mouseX,mouseY,playx,playy)<0.18*playicon.height){
    deck1Playing=!deck1Playing;
  }
  
   if(dist(mouseX,mouseY,stopx,stopy)<0.18*playicon.height){
    deck1Playing=false;
  }
 
   if(dist(mouseX,mouseY,forwardx,forwardy)<0.18*playicon.height){
    if(speedAdjust<10){
    speedAdjust=speedAdjust*2;
    }
  else 
{
  speedAdjust=speedAdjust;
} }
  
  if(dist(mouseX,mouseY,backwardx,backwardy)<0.18*playicon.height){
    if(speedAdjust>1/10){
    speedAdjust=speedAdjust/2;
    }
  else 
{
  speedAdjust=speedAdjust;
}  
}
  
  if(deck1Playing){
    player1.play();
  }
  else{
    player1.stop();
  } 
  
}

