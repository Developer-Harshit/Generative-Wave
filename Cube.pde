class Cube {
  OpenSimplexNoise opnoise;
  Surface[] faces ;
  float z;
  float c1;
  float c2;
  float inc;
  float size;
  float dim;


  ArrayList<PVector> bounds;
  Cube(int s, int x) {
    z = 0;
    setParams();
    long seed = (long) random(-100000000, 100000000);
    opnoise= new OpenSimplexNoise(seed);

    faces = new Surface[6];
    PVector offset = new PVector(0, 0, 0);

    dim = x*s;

    faces[0] = new Surface(s, x, x, offset, 0);

    faces[1] = new Surface(s, x, x, offset, 1);

    faces[2] = new Surface(s, x, x, offset, 2);

    offset.x =dim;

    faces[3] = new Surface(s, x, x, offset, 0);

    offset.x =0;
    offset.z = dim;

    faces[4] = new Surface(s, x, x, offset, 1);

    offset.z = 0;
    offset.y = dim;

    faces[5] = new Surface(s, x, x, offset, 2);

    //initBounds();
  }
  void setParams() {
    long seed = (long) random(-100000000, 100000000);
    opnoise= new OpenSimplexNoise(seed);
    c1 = random(0, 360);
    //float r1 = random(0, max(0, c1-50));
    //float r2 = random(min(360, c1+50), 360);

    c2 = random(0, 360);
    size = random(50, dim-69);
    if (size< 100) {

      inc = random(0.05, 0.1);
    } else {

      inc = random(0.02, map(size, 100, dim-69, 0.15, 0.035));
    }
  }
  void initBounds() {
    bounds = new ArrayList<PVector>();
    for (int k =0; k<6; k++) {


      Surface fn = faces[k];

      for (int i = 0; i< fn.rows; i++) {

        for (int j = 0; j< fn.cols; j++) {
          PVector p = fn.points[i][j];
          if (i== 0 || j == 0|| i == fn.rows-1|| j == fn.cols -1) {
            Boolean found= false;
            for (int a = 0; a< bounds.size(); a++) {
              PVector p0 = bounds.get(a);
              if ((int) p0.x == p.x && (int) p0.y == p.y && (int) p0.z == p.z ) {
                p = p0;
                found = true;
                break;
              }
            }
            if (!found) {
              bounds.add(p);
            }
          }
        }
      }
    }
  }
  void update() {



    float x = 0;
    for (int i = 1; i< faces[0].rows-1; i++) {
      float y = 0;
      for (int j = 1; j< faces[0].cols-1; j++) {

        PVector v4 = faces[4].points[i][j];
        float n = (float) opnoise.eval(x, y, z);
        float intensity = map(size,50, dim-69,1,10);
        n = map(n*intensity, -1, intensity, 0, size);
        v4.z=faces[4].initial.y+n;

        y+=inc;
      }
      x+=inc;
    }
    z+=0.02;
  }
  void display() {


    for (int k =0; k<6; k++) {


      Surface fn = faces[k];

      for (int i = 0; i< fn.rows-1; i++) {

        beginShape(TRIANGLE_STRIP);

        for (int j = 0; j< fn.cols; j++) {



          PVector p0 = fn.points[i][j];
          PVector p1 = fn.points[i+1][j];


          if (k==4) {
            float n1 = map(p0.z, fn.initial.y, fn.initial.y+size, 0, 300);
            float n2 = map(p1.z, fn.initial.y, fn.initial.y+size, 0, 300);

            float n = (n1+n2)/2;
            n1 = map(p0.z, fn.initial.y, fn.initial.y+size, c1, c2);
            n2 = map(p1.z, fn.initial.y, fn.initial.y+size, c1, c2);

            float nc = (n1+n2)/2;

            fill(nc, 210, n+10);
          } else {
            fill(c1+c2, 210, 25);
          }

          //fill(255/1.5,n,129);
          vertex(p0.x, p0.y, p0.z);
          vertex(p1.x, p1.y, p1.z);
        }

        endShape();
      }
    }
  }
