#include <iostream>
#include <algorithm>
#include <cmath>

using namespace std;


struct Point2D {
	double x,y;
	Point2D (double arg1 =0, double arg2 =0){
		x = arg1;
		y = arg2;
	}
};

struct Vec2D {
	double x,y;
	Vec2D (double arg1 =0, double arg2 =0){
		x = arg1;
		y = arg2;
	}
	Vec2D (const Point2D & A, const Point2D & B){
		x = B.x - A.x;
		y = B.y - A.y;
	}
	 double len () const {
		return sqrt(x*x+y*y);
	}
};

struct Line2D {
	double A,B,C;
	Line2D (const Point2D & M, const Point2D & N){
		Vec2D napr (M,N);
		Vec2D norm (-napr.y, napr.x);
		A = norm.x;
		B = norm.y;
		C = -A * M.x - B * M.y;
	}
	Line2D (const Point2D & M, const Vec2D & napr){
		Vec2D norm (-napr.y, napr.x);
		A = norm.x;
		B = norm.y;
		C = -A * M.x - B * M.y;
	}
	Line2D (double arg1 = 1, double arg2 = 1, double arg3 = 1){
		A = arg1;
		B = arg2;
		C = arg3;
	}
};

double scal_prod (const Vec2D & a , const Vec2D & b){
	return a.x*b.x + a.y*b.y;
}

double psev_vec_prod (const Vec2D & a , const Vec2D & b){
	return a.x*b.y - a.y*b.x;
}

double angle (const Vec2D & a , const Vec2D & b){
	return acos ( scal_prod(a,b) / (a.len() * b.len()));
}

double distance (const Line2D & l, const Point2D & M){
	return abs(l.A*M.x + l.B*M.y + l.C)/ sqrt(l.A * l.A + l.B*l.B);
}

bool same_orient(const Line2D & l , const Point2D & M, const Point2D & N ){
	return (l.A*M.x + l.B*M.y + l.C) * (l.A*N.x + l.B*N.y + l.C)>0;
}

Point2D line_cross (const Line2D & l1 , const Line2D & l2){
	double dx = -l1.C*l2.B + l1.B*l2.C;
	double dy = -l1.A*l2.C + l1.C*l2.A;
	double d = l1.A*l2.B - l1.B*l2.A;
	return Point2D(dx/d, dy/d);
}

ostream & operator << (ostream & out , const Point2D & M){
  out<<'('<<M.x<<' '<<M.y<<')';
  return out;
}

ostream & operator << (ostream & out , const Vec2D & M){
  out<<'{'<<M.x<<' '<<M.y<<'}';
  return out;
}

ostream & operator << (ostream & out , const Line2D & l){
  out<<l.A<<'x';
  if (l.B >=0 ) out <<'+';
  out<< l.B<<"y";
  if (l.C >=0 ) out <<'+';
  out<<l.C<< " = 0";
  return out;
}

int main(){
	Line2D l1 (1,1,1);
  Line2D l2 (1,-1,2);
  cout<<l1<<endl;
  cout<<l2<<endl;
  cout<<line_cross (l1,l2);
	return 0;
}
