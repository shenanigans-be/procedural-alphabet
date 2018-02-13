Point[] grid;
int gridsize_x = 4;
int gridsize_y = 3;
int letter_padding = 10;
int padding_x = 50;
int padding_y = 100;
int number_of_lines = 4;
int jitter_size = 0;

int fat_line = 3;
int thin_line = 1;
int big_circle = 20;
int little_circle = 5;

int num_characters = 24;

void setup() {
  size(700, 600);
  stroke(200);
 
  background(0); 
}

void draw() {
}

void keyPressed() {
  if(key == 32) {
    long millis = System.currentTimeMillis();
    save(Long.toHexString(millis) + ".png");
  }
}

void redraw() {
  // draw a white square over everything
  fill(0);
  rect(-5, -5, width + 10, height + 10);
 
   int letterwidth = 90;
   int letterheight = 60;
   float xpos = padding_x + 30;
   float ypos = padding_y;
 
   int i = 0;
   while(i < num_characters) {
     draw_letter(xpos, ypos, letterwidth, letterheight); 
     xpos += letterwidth;
     if(xpos >= (width - padding_x - letterwidth)) {
       xpos = padding_x;
       ypos += letterheight + 50;
     }
     i++;
   }
}

void draw_letter(float startx, float starty, float grid_width, float grid_height) {
  
  Point[] grid = new Point[gridsize_y * gridsize_x];
  
  startx += letter_padding;
  starty += letter_padding;
  
  int i = 0;
  for (int y = 0; y < gridsize_y; y++) {
    for (int x = 0; x < gridsize_x; x++) {
      float xpos = grid_width / (gridsize_x - 1) * x;
      float ypos = grid_height / (gridsize_y - 1) * y;
      
      xpos += random(-jitter_size, jitter_size);
      ypos += random(-jitter_size, jitter_size);
      
      
      grid[i] = new Point(startx + xpos, starty + ypos);
      i++;
    }
  }
  
  stroke(180);
  for(i = 0; i < number_of_lines; i++) {
      Point a = get_random_point(grid);
      Point b = get_random_point(grid);
      
      if(a == b) {
        int strokeWidth = (weighted_bool(0.7))? fat_line : thin_line;
        strokeWeight(strokeWidth);
        
        int fill = (weighted_bool(0.2))? 180 : 0;
        fill(fill);
        
        int ellipseSize = (weighted_bool(0.4))? big_circle : little_circle;
        
        ellipse(a.x, a.y, ellipseSize, ellipseSize);
      } else {
        int strokeWidth = (weighted_bool(0.4))? fat_line : thin_line;
        strokeWeight(strokeWidth);
        
        line(a.x, a.y, b.x, b.y);
      }
  }
}

void mousePressed() {
  println("redraw");
  redraw();
}

Boolean weighted_bool(float true_chance) {
  return (random(0, 1) < true_chance);
}


Point get_random_point(Point[] grid) {
  return grid[round(random(0, grid.length - 1))];
}

class Point { 
 
  float x; 
  float y;
 
  Point (float x_, float y_) { 
    x = x_; 
    y = y_;
  }
  
  public boolean equals(Point obj) {
    return (this.x == obj.x && this.y == obj.y);
  }
}