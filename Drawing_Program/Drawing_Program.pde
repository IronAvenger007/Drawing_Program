ArrayList<StrokePath> paths; // Use StrokePath instead of generic ArrayList
StrokePath currentPath;
int currentColor;
int eraserColor;
int brushSize;
boolean eraserMode; // Add boolean flag for eraser mode

void setup() {
  size(800, 600);
  background(255);

  paths = new ArrayList<StrokePath>(); // Initialize the ArrayList
  currentColor = color(0, 0, 0);
  eraserColor = color(255);
  brushSize = 10;
  eraserMode = false; // Initialize eraser mode to false
}

void draw() {
  if (mousePressed) {
    strokeWeight(brushSize);
    if (mouseButton == LEFT && !eraserMode) {
      stroke(currentColor);
    } else if (mouseButton == RIGHT || eraserMode) {
      stroke(eraserColor);
    }
    currentPath.addPoint(new PVector(mouseX, mouseY)); // Add point to the current path
  }

  // Display all paths
  for (StrokePath path : paths) {
    path.display();
  }
}

void keyPressed() {
  if (key == 'R' || key == 'r') {
    currentColor = color(255, 0, 0);
  } else if (key == 'G' || key == 'g') {
    currentColor = color(0, 255, 0);
  } else if (key == 'B' || key == 'b') {
    currentColor = color(0, 0, 255);
  } else if (key == 'E' || key == 'e') {
    eraserMode = !eraserMode;
  } else if (key == 'C' || key == 'c') {
    clearCanvas();
  } else if (key == 'Z' || key == 'z') {
    undo();
  }
}

void mouseWheel(MouseEvent event) {
  brushSize += event.getCount();
  brushSize = constrain(brushSize, 1, 50);
}

void clearCanvas() {
  paths.clear();
  background(255);
}

void undo() {
  if (paths.size() > 0) {
    paths.remove(paths.size() - 1);
    background(255);
    for (StrokePath path : paths) {
      path.display();
    }
  }
}

class StrokePath {
  ArrayList<PVector> points;
  int pathColor;

  StrokePath() {
    points = new ArrayList<PVector>();
    pathColor = currentColor; // Use the current color for the path
  }

  void addPoint(PVector point) {
    points.add(point.copy()); // Copy the vector to avoid reference issues
  }

  void display() {
    beginShape();
    stroke(pathColor);
    noFill();
    for (PVector point : points) {
      vertex(point.x, point.y);
    }
    endShape();
  }
}
