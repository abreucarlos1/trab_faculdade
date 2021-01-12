unit polinomio2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type Polinomio = class
   a,b,c,d:real;
     function valor (x:real):real;
     procedure desenha (C:TCanvas;Top,Down,Left,Right:integer;x1,x2:real);
end;


implementation

function Polinomio.Valor(x:real):real;
begin
     Valor:=((a*x+b)*x+c)*x+d;
end;

Procedure Polinomio.desenha;
var i,j: integer; x,y,inc:real; Max, Min:real;
begin
     inc:=(x2-x1)/(Right-Left);
     Max:= Valor(x1); Min:=valor(x1);
     x:=x1;
     Repeat
           x:=x+inc;
           if valor(x)>Max then Max:=valor(x);
           if valor(x)<Min then Min:=valor(x);
     until x >= x2;
     x:=x1 ;y:=valor(x);
     i:=round((x-x1)*(Right-Left)/(x2-x1)+left);
     j:=round((y-max)*(down-top)/(Min-Max)+top);
     C.Moveto(i,j);
     Repeat
           x:=x+inc;
           y := valor(x);
           i:=round((x-x1)*(Right-Left)/(x2-x1)+left);
           j:=round((y-max)*(down-top)/(Min-Max)+top);
           c.lineto(i,j);
     until x >= x2;
end;

end.
