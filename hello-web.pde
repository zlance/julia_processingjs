xr = 500;
yr = 500;

double xMin = -1.5;
double xMax =  1.5;
double yMin = -1.5;
double yMax =  1.5;

boundary = 64;

var cx = -0.32;
var cy = 0.4;


stepX = (xMax - xMin) / xr;
stepY = (yMax - yMin) / yr;

stepMult = 2;
pointSize = 4;

class Point{
	var x = 0;
	var y = 0;

	Point(x,y){
		this.x = x;
		this.y = y;
	}
}

class colorVal{
	var r = 0;
	var g = 0;
	var b = 0;

	colorVal(r,g,b){
		this.r = r;
		this.g = g;
		this.b = b;
	}
}

void mutation(){
	ix = getRandomArbitrary(-0.01, 0.01);
	iy = getRandomArbitrary(-0.01, 0.01);
	if( -1 < cx + ix && cx + ix < 1){
		cx = cx + ix;
	}
	if( -1 < cy + iy && cy + iy < 1){
		cy = cy + iy;
	}
}


colorVal gradient(i){
	
	double r = 0;
	double g = 0;
	double b = 0;

	if( 0 <=i && i < 16){
		r = 0.8 * i /(16)	;
		g = 0.7 * i /(16)	;
		b = 0.5 * i /(16)	;
	} else if ( 16 <=i && i < 32){
		r = 0.8 - 0.4 * (i-16) /(16)	;
		g = 0.2 * (i-16) /(16)	;
		b = 0.5 * (i-16) /(16);
	}  else if ( 32 <=i && i < 48){
		r = 0.5 * (i-32) /(16)	;
		g = 0.8 - 0.5 * (i-32) /(16)	;
		b = 0.5 * (i-32) /(16);
	} else if ( 48 <=i && i < 64){
		r = 0.3 * (i-48) /(16)	;
		g = 0.9 * (i-48) /(16)	;
		b = 0.2+0.5 * (i-48) /(16);
	}
	return new colorVal(r,g,b);
}


function getRandomArbitrary(min, max) {
    return Math.random() * (max - min) + min;
}


void setup() {
	size(xr, yr, P2D);
	background(0,0,0);
	smooth();
    strokeWeight(pointSize);
    frameRate(200);
}
void draw() {
	for ( i = 0 ; i < 1000 ; i++ ){
		double x = getRandomArbitrary(xMin, xMax);
		double y = getRandomArbitrary(yMin, yMax);
		count = countIterations(x,y);
		var col = gradient(count);
		strokeWeight(pointSize);
		stroke(256*col.r,256*col.g,256*col.b);
		point( xReal(x),yReal(y) );
		//console.log((256*col.r)+" "+(256*col.g)+" "+(256*col.b));
	}

	if( 0.005 < getRandomArbitrary(0,1) ){
		mutation();
		$("#cx").html(cx);
		$("#cy").html(cy);
		// stroke(0,0,0);    
		// strokeWeight(5);
		// point( xReal(cx),yReal(xMin+0.01) );
		// point( xReal(xMin+0.01),yReal(cy) );
		// stroke(256,256,256);    
		// point( xReal(cx),yReal(xMin+0.01) );
		// point( xReal(xMin+0.01),yReal(cy) );

		//print( cx + " " cy);
	}
	// for( double x = xMin ; x < xMax ; x+= stepMult*stepX){
	// 	for( double y = yMin ; y < yMax ; y+= stepMult*stepX){
	// 		count = countIterations(x,y);
	// 		stroke(256/count, 256/count, 256/count);
	// 		point( xReal(x),yReal(y));
	// 	}
	// }
 }

double xReal( xMath ){
	return xr * (xMath - xMin) / (xMax - xMin);
}

double yReal( yMath ){
	return yr - yr * (yMath - yMin) / (yMax - yMin);
}

int countIterations(x,y){
	int i = 0;
	var myPoint = new Point(x,y);
	
	for( ; i < boundary; i++ ){
		if( iteration(myPoint) ){
			return i;
			
		}	
		//console.log(myPoint.x + " " + myPoint.y);
	}
	return i;
}

boolean iteration(myPoint){
	x = myPoint.x;
	y = myPoint.y;
	x1 = 2*x*y + cx;
	y1 = x*x - y*y + cy;
	if( x1*x1 + y1*y1 >= 1 ){
		return true;
	} else {
		myPoint.x=x1;
		myPoint.y=y1;
		return false;
	}

}