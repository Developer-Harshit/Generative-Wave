class Surface {
  PVector[][] points ;


  int rows;
  int cols;
  int size;
  PVector initial;
  Surface(int isize, int irows, int icols, PVector offset, int mode) {
    rows = irows+1;
    cols = icols+1;
    size = isize;
    resetPoints(offset, mode);
    initial = offset;
  }

  void resetPoints(PVector offset, int mode) {
    // Mode: 0=x,1=y,2=z
    points = new PVector[rows][cols];

    for (int i = 0; i< rows; i++) {
      for (int j = 0; j< cols; j++) {

        if (mode == 0) {
          points[i][j] = new PVector(offset.x, i*size + offset.y, j*size+offset.z);
          PVector p = points[i][j];
          point(p.x, p.y, p.z);
   
        } else if (mode == 1) {

          points[i][j] = new PVector(i*size+ offset.x, j*size+ offset.y, offset.z);
          PVector p = points[i][j];
          point(p.x, p.y, p.z);

   
        } else {
          points[i][j] = new PVector(i*size+ offset.x, offset.y, j*size+offset.z);
          PVector p = points[i][j];
          point(p.x, p.y, p.z);
      
        }
      }
    }
  }
  void rotateX(float theta) {
    for (int i = 0; i< rows; i++) {
      for (int j = 0; j< cols; j++) {
        PVector v = points[i][j];
        float py = v.y;

        v.y = v.y*cos(theta) - v.z * sin(theta);
        v.z = py*sin(theta) + v.z * cos(theta);
      }
    }
  }
  void rotateY(float theta) {
    for (int i = 0; i< rows; i++) {
      for (int j = 0; j< cols; j++) {
        PVector v = points[i][j];
        float px = v.x;

        v.x = v.x*cos(theta) + v.z * sin(theta);
        v.z = v.z*cos(theta) - px * sin(theta);
      }
    }
  }
  void rotateZ(float theta) {
    for (int i = 0; i< rows; i++) {
      for (int j = 0; j< cols; j++) {
        PVector v = points[i][j];
        float px = v.x;

        v.x = v.x*cos(theta) - v.y * sin(theta);
        v.y = px*sin(theta) + v.y * cos(theta);
      }
    }
  }

  void translateAll(float x, float y, float z) {
    PVector v0 = new PVector(x, y, z);
    for (int i = 0; i< rows; i++) {
      for (int j = 0; j< cols; j++) {
        PVector v1 = points[i][j];
        v1.add(v0);
      }
    }
  }

  void display() {

    for (int i = 0; i< rows-1; i++) {
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j< cols; j++) {

        PVector p0 = points[i][j];
        vertex(p0.x, p0.y, p0.z);
        PVector p1 = points[i+1][j];
        vertex(p1.x, p1.y, p1.z);
      }
      endShape();
    }
  }
}
}
