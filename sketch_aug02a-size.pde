//Marimball!

int rectWidth = 640/12;
float[] rHeights = new float[rectWidth];
float ballX, ballY;
float xSpeed = 12;
float ySpeed = 9;
float xDirection = 1;
float yDirection = 1;
float shakeX, shakeY;
float bDiameter = 30;
boolean paused;

void setup(){
  size(640,480);
  frameRate(24);
  smooth();
  
  ballY = width/2;
  ballX = height/2;
  float shakeX = 0;
  float shakeY = 0;
  for(int i=0; i<rectWidth; i++){
    rHeights[i] = (int(random(height/12,height/3)/10)*12);
  }
}

void draw(){

  background(0,50);
  noStroke();
  
  if ((mouseX <= width/2) && (mouseY <= height/2) && (mouseX != 0)) {
    fill(150,200,175,25);
    rect(0,0,width/2,height/2);
    fill(150,150,150,75);
    triangle(0,0,0,height/4,width/4,0);
    
    if (shakeX > width/4*-1) {
      shakeX -= 1;
    } else {
      shakeX = width/4*-1;
    }
    if (shakeY > height/4*-1) {
      shakeY -= 1;
    } else {
      shakeY = height/4*-1;
    }
    makeRect(rHeights);
    makeTcer(rHeights);
  } else {
    if ((mouseX > width/2) && (mouseY <= height/2) && (mouseX != 0)) {
      fill(150,200,175,25);
      rect(width/2,0,width/2,height/2);
      fill(150,150,150,75);
      triangle(width/4*3,0,width,0,width,height/4);
    
      if (shakeX < width/4) {
        shakeX += 1;
      } else {
        shakeX = width/4;
      }
      if (shakeY > height/4*-1) {
        shakeY -= 1;
      } else {
        shakeY = height/4*-1;
      }
      makeRect(rHeights);
      makeTcer(rHeights);
    } else { 
      if ((mouseX <= width/2) && (mouseY > height/2) && (mouseX != 0)) {
        fill(150,200,175,25);
        rect(0,height/2,width/2,height/2);
        fill(150,150,150,75);
        triangle(width/4,height,0,height,0,height/4*3);
        
        if (shakeX > width/4*-1) {
          shakeX -= 1;
        } else {
          shakeX = width/4*-1;
        }
        if (shakeY < height/4) {
          shakeY += 1;
        } else {
          shakeY = height/4;
        }
        makeRect(rHeights);
        makeTcer(rHeights); 
      } else {
        if ((mouseX > width/2) && (mouseY > height/2) && (mouseX != 0)) {     
          fill(150,200,175,25);
          rect(width/2,height/2,width/2,height/2);
          fill(150,150,150,75);
          triangle(width,height,width/4*3,height,width,height/4*3);
        
          if (shakeX < width/4) {
            shakeX += 1;
          } else {
            shakeX = width/4;
          }
          if (shakeY < height/4) {
            shakeY += 1;
          } else {
            shakeY = height/4;
          }
          makeRect(rHeights);   
          makeTcer(rHeights);
        } else {
            shakeX = 0;
            shakeY = 0;
            makeRect(rHeights);  
            makeTcer(rHeights);  
        }
      }
    }
  }
  
  makeBall();
  
  //Save images
  //saveFrame("marimball09-####.tif");
  
  stroke(255);
  text("pause",width-rectWidth/4*3.2,height/2+4);
  text("reload",rectWidth/5,height/2+4);
  stroke(0);
  fill(150,200,175,25);
  rect(width-rectWidth,height/2-rectWidth/2,rectWidth,rectWidth);
  rect(0,height/2-rectWidth/2,rectWidth,rectWidth);

}

void mouseClicked(){
  if (paused) {
    if (overPause(width-rectWidth,height/2-rectWidth/2,rectWidth,rectWidth)) {      
      loop();
      paused = false;
    }
  } else {
    if (overPause(width-rectWidth,height/2-rectWidth/2,rectWidth,rectWidth)) {      
      noLoop();
      paused = true;
      stroke(0);
      fill(150,200,175,255);
      text("paused",width-rectWidth/4*3.2,height/2+4);
      fill(150,200,175,25);
      rect(width-rectWidth,height/2-rectWidth/2,rectWidth,rectWidth);
    }
  }
  
  if (overPause(0,height/2-rectWidth/2,rectWidth,rectWidth)) {
    loop();
    setup();
    shakeX = 0;
    shakeY = 0;
  }
}

void makeBall(){
  ballX = ballX + (xSpeed * xDirection);
  ballY = ballY + (ySpeed * yDirection);
  
  // Does the ball hit the wall?  
  if (ballX > width || ballX < 0) {
    xDirection *= -1;
  }
  if (ballY > height || ballY < 0) {
    yDirection *= -1;
  }
  
  fill(150,200,175);
  stroke(0);
  ellipse(ballX,ballY,bDiameter,bDiameter);
  
}


//bottom
void makeRect(float rHeights[]){
    
    fill(255,50);
    for(int i=0; i<rectWidth; i++){
      float rectHeight = rHeights[i];
      float vpos = width/12*i-width/2;
  
    // This is collision detection
        boolean collisionDetectedTop = isCollidingCircleRectangleTop(ballX, ballY,
        bDiameter/2, vpos+shakeX, height-rectHeight+shakeY, rectWidth, rectHeight);
        
        boolean collisionDetectedSide = isCollidingCircleRectangleSide(ballX, ballY,
        bDiameter/2, vpos+shakeX, height-rectHeight+shakeY, rectWidth, rectHeight);
        
        if ((collisionDetectedTop == true) && (collisionDetectedSide == true)) {
          fill(rectHeight/160*255,vpos/640*255,640-vpos/640*255);
          player.play(((120-(rectHeight-40))/120)*12);
          playerO.play(((120-(rectHeight-40))/120)*12);
          yDirection *= -1;
          xDirection *= -1;
        } else {
          if (collisionDetectedTop == true) {
            fill(rectHeight/160*255,vpos/640*255,640-vpos/640*255);
            player.play(((120-(rectHeight-40))/120)*12);
            playerO.play(((120-(rectHeight-40))/120)*12);
            yDirection *= -1;
          } else {
            if (collisionDetectedSide == true) {
            fill(rectHeight/160*255,vpos/640*255,640-vpos/640*255);
            xDirection *= -1;
            } else {
              fill(135,135);
            }
          } 
        }

        // End collision detection
        
      rect(vpos+shakeX,height-rectHeight+shakeY,rectWidth,rectHeight);      
    }

}


//TOP
void makeTcer(float rHeights[]){
    
    fill(255,50);
    for(int i=0; i<rectWidth; i++){
      float rectHeight = rHeights[i];
      float vpos = width/12*i-width;
  
    // This is collision detection
        boolean collisionDetectedTop = isCollidingCircleRectangleTop(ballX, ballY,
        bDiameter/2, vpos+shakeX, 0+shakeY, rectWidth+1, rectHeight+1);
        
        boolean collisionDetectedSide = isCollidingCircleRectangleSide(ballX, ballY,
        bDiameter/2, vpos+shakeX, 0+shakeY, rectWidth, rectHeight);
        
        if ((collisionDetectedTop == true) && (collisionDetectedSide == true)) {
          fill(rectHeight/160*255,vpos/640*255,640-vpos/640*255);
          player.play(((120-(rectHeight-40))/120)*12);
          playerO.play(((120-(rectHeight-40))/120)*12);
          yDirection *= -1;
          xDirection *= -1;
        } else {
          if (collisionDetectedTop == true) {
            fill(rectHeight/160*255,vpos/640*255,640-vpos/640*255);
            player.play(((120-(rectHeight-40))/120)*12);
            playerO.play(((120-(rectHeight-40))/120)*12);
            yDirection *= -1;
          } else {
            if (collisionDetectedSide == true) {
            fill(rectHeight/160*255,vpos/640*255,640-vpos/640*255);
            xDirection *= -1;
            } else {
              fill(135,135);
            }
          } 
        }
        // End collision detection
        
      rect(vpos+shakeX,0+shakeY,rectWidth,rectHeight);      
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////

boolean overPause(int x, int y, int width, int height) 
{
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean isCollidingCircleRectangleTop(
      float bxpos,
      float bypos,
      float bRadius,
      float rectangleX,
      float rectangleY,
      float rectangleWidth,
      float rectangleHeight)
{
    float circleDistanceX = abs(bxpos - rectangleX - rectangleWidth/2);
    float circleDistanceY = abs(bypos - rectangleY - rectangleHeight/2);
 
    if (circleDistanceX > (rectangleWidth/2 + bRadius)) { return false; }
    if (circleDistanceY > (rectangleHeight/2 + bRadius)) { return false; }
 
    if (circleDistanceX <= (rectangleWidth/2)) { return true; }
    if (circleDistanceY <= (rectangleHeight/2)) { return false; }
 
    float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
                         pow(circleDistanceY - rectangleHeight/2, 2);
 
    return (cornerDistance_sq <= pow(bRadius,2));
}

boolean isCollidingCircleRectangleSide(
      float bxpos,
      float bypos,
      float bRadius,
      float rectangleX,
      float rectangleY,
      float rectangleWidth,
      float rectangleHeight)
{
    float circleDistanceX = abs(bxpos - rectangleX - rectangleWidth/2);
    float circleDistanceY = abs(bypos - rectangleY - rectangleHeight/2);
 
    if (circleDistanceX > (rectangleWidth/2 + bRadius)) { return false; }
    if (circleDistanceY > (rectangleHeight/2 + bRadius)) { return false; }
 
    if (circleDistanceX <= (rectangleWidth/2)) { return false; }
    if (circleDistanceY <= (rectangleHeight/2)) { return true; }
 
    float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
                         pow(circleDistanceY - rectangleHeight/2, 2);
 
    return (cornerDistance_sq <= pow(bRadius,2));
}
