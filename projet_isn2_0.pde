PImage fond;
int x=25;
int y=25;
float TableauX[]=new float[30];
float TableauY[]=new float[30];
int i=0;
float x1=250;
float y1=445;
float depY=0;
float depX=0;
float vit=0;
float ylimit=0;
boolean reverse = false;
color [] rgb= {#F00C0C,#837F86,#F5F5F5};
int [] id_couleurs_balles = new int[30];
int [] couleurs_balles = new int[30];
boolean stop = false;
color couleur_balle_tir;

void setup(){
size(500,500);
fond= loadImage("fond.jpeg");
for (int i=0; i<30;i++) {
id_couleurs_balles[i]= int(random(3));
int idref=id_couleurs_balles[i];
color balls= rgb[idref];
print(balls);
couleurs_balles[i]=balls;
//print(couleurs_balles[i]);
print("-");

if(i==0) {
  x=25;
}
else { x=x+50;
}
 if(i==0){
    y=25;
  }
if(i==10){
  y=y+50;
  x=25;
}
if(i==20){
  y=y+50;
  x=25;
}
 
//print(x);
//print("-");
TableauX[i]=x;
TableauY[i]=y;
ellipse(x,y,50,50);
color ball_color= couleurs_balles[i];
fill(ball_color);

}
couleur_balle_tir = couleurs_balles[29];

}



void draw(){
image(fond,0,0,width,height);
Canon();
Balle();
line(250,445,250,0);
Tir();
//line(0,420,500,420);//ligne qu'il ne faut pas dépasser sinon perdu

}


void Canon(){
line (mouseX,mouseY,250,445);
fill(#FAFAFA);
rect(225,470,50,30);}

void Balle(){
  
for(int i=0;i<TableauX.length;i++)
{
  color ball_color= couleurs_balles[i];
  fill(ball_color);
  ellipse(TableauX[i],TableauY[i],50,50);
}

}

void Tir() {
  fill(couleur_balle_tir);
  ellipse(x1,y1,50,50);

  if (mousePressed==true) {
    stop = false;
    depX=0;
    depY=0;
    reverse = false;
    if(mouseX == 250)
     {
       depX=0;
       depY=1;
       vit=10;
     }
     else
     {
       if(mouseX < 250)
       {
          depX=-1;
       }
       else 
       {
         depX=1;
       }
    
       depY=abs((mouseY-y1)/(mouseX-x1)*depX);
       vit = 10/(abs(depX)+depY);
     }
  }
  
  // condition d'arrêt
  if(y1>30 && !stop)
  {
     y1 = y1-depY*vit;
     if(!reverse)
      {
        if(x1<470 && x1>30)
        {
          x1 = x1+depX*vit;
        }
        else
        {
          reverse = true;
          x1 = x1-depX*vit;
        }
      }
      else
      {
        if(x1<470 && x1>30)
        {
          x1 = x1-depX*vit;
        }
        else
        {
          reverse = false;
          x1 = x1+depX*vit;
        }
      }
      BalleStop();
  }
}

void BalleStop()
{
  for(int i=0;i<TableauX.length;i++)
  {
    float tabX = TableauX[i];
    float tabY = TableauY[i];
    
    if(abs(tabX-x1) < 50 && abs(tabY-y1) < 50)
    {
      stop = true;
      if(couleurs_balles[i] == couleur_balle_tir) //<>//
      {
          RemoveFromTable(i);
      }
      else
      {
          AddToTable(x1,y1);
       
      }
        x1=250; //<>//
        y1=445;
        couleur_balle_tir = int(random(3));
        color col = rgb[couleur_balle_tir];
        couleur_balle_tir = col;
      break;
    }
  }
}

// méthode pour ajouter une balle
void AddToTable(float newX, float newY)
{
  float TableauXTmp[] = TableauX;
  float TableauYTmp[] = TableauY;
  int couleurs_balles_Tmp[] = couleurs_balles;
  
  TableauX = new float[TableauXTmp.length+1];
  TableauY = new float[TableauYTmp.length+1];
  couleurs_balles = new int[couleurs_balles_Tmp.length+1];
  
  for(int i=0;i<TableauXTmp.length;i++)
  {
    TableauX[i] = TableauXTmp[i];
    TableauY[i] = TableauYTmp[i];
    couleurs_balles[i] = couleurs_balles_Tmp[i];
  }
  
  TableauX[TableauX.length-1] = newX;
  TableauY[TableauY.length-1] = newY;
  couleurs_balles[couleurs_balles.length-1] = couleur_balle_tir; //<>//
  
}

// méthode pour enlever une balle
void RemoveFromTable(int idx)
{
   float TableauXTmp[] = TableauX;
   float TableauYTmp[] = TableauY;
   int couleurs_balles_Tmp[] = couleurs_balles;
   
   TableauX = new float[TableauXTmp.length-1];
   TableauY = new float[TableauYTmp.length-1];
   couleurs_balles = new int[couleurs_balles_Tmp.length-1];
  
  for(int i=0;i<TableauX.length;i++) //<>//
  {
    if(i < idx)
    {
      TableauX[i] = TableauXTmp[i];
      TableauY[i] = TableauYTmp[i];
      couleurs_balles[i] = couleurs_balles_Tmp[i];
    }
    else
    {
      TableauX[i] = TableauXTmp[i+1];
      TableauY[i] = TableauYTmp[i+1];
      couleurs_balles[i] = couleurs_balles_Tmp[i+1];
    }
  }
}