unit reta1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ColorGrd, ComCtrls, ToolWin;

type
  TForm1 = class(TForm)
    ColorGrid1: TColorGrid;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    procedure FormActivate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
        procedure reta(x1,y1,x2,y2:integer);
    procedure diagonal45(x1,y1,x2,y2:integer);
    procedure diagonal90(x1,y1,x2,y2:integer);
    procedure diagonal135(x1,y1,x2,y2:integer);
    procedure diagonal180(x1,y1,x2,y2:integer);
    procedure circunferencia(xc,yc,raio:integer);
  end;

var
  Form1: TForm1;
  setado:byte;
  xt1,xt2,yt1,yt2,dx1,dx2,dy1,dy2:integer;
  dist:real;

implementation

{$R *.DFM}


procedure Tform1.reta(x1,y1,x2,y2:integer);
var
   inc1,inc2,temp:integer;
begin
     if x1>x2 then
        begin
             temp:=x2;
             x2:=x1;
             x1:=temp;
        end;
     if y1>y2 then
        begin
             temp:=y2;
             y2:=y1;
             y1:=temp;
        end;
     for inc1:=x1 to x2 do
         for inc2:=y1 to y2 do
             image1.Canvas.Pixels[inc1,image1.height-inc2]:=colorgrid1.ForegroundColor;
end;

procedure Tform1.diagonal45(x1,y1,x2,y2:integer);
var
   x,y,dx,dy,inc1,inc2,D:integer;
begin
     if x1>x2 then
        begin
             d:=x1;
             x1:=x2;
             x2:=d;
        end;
     if y1>y2 then
        begin
             d:=y1;
             y1:=y2;
             y2:=d;
        end;
     dx:=x2-x1;
     dy:=y2-y1;
     d:=2*dx-dy;
     inc1:=2*dy;
     inc2:=2*(dy-dx);
     x:=x1;
     y:=y1;
     while x<=x2 do
           begin
                image1.Canvas.Pixels[x,image1.height-y]:=colorgrid1.ForegroundColor;
                if d<=0 then
                   begin
                        d:=d+inc1;
                        x:=x+1;
                   end
                else
                   begin
                        d:=d+inc2;
                        x:=x+1;
                        y:=y+1;
                   end;
           end;
end;

procedure Tform1.diagonal90(x1,y1,x2,y2:integer);
var
   x,y,dx,dy,inc1,inc2,D:integer;
begin
     if x1>x2 then
        begin
             d:=x1;
             x1:=x2;
             x2:=d;
        end;
     if y1>y2 then
        begin
             d:=y1;
             y1:=y2;
             y2:=d;
        end;
     dx:=x2-x1;
     dy:=y2-y1;
     d:=2*dy-dx;
     inc1:=2*dx;
     inc2:=2*(dx-dy);
     x:=x1;
     y:=y1;
     while y<=y2 do
           begin
                image1.Canvas.Pixels[x,image1.Height-y]:=colorgrid1.ForegroundColor;
                if d<=0 then
                   begin
                        d:=d+inc1;
                        y:=y+1;
                   end
                else
                   begin
                        d:=d+inc2;
                        x:=x+1;
                        y:=y+1;
                   end;
           end;
end;

procedure Tform1.diagonal135(x1,y1,x2,y2:integer);
var
   x,y,dx,dy,inc1,inc2,D:integer;
begin
     if x1<x2 then
        begin
             d:=x1;
             x1:=x2;
             x2:=d;
        end;
     if y1>y2 then
        begin
             d:=y1;
             y1:=y2;
             y2:=d;
        end;
     dx:=x1-x2;
     dy:=y2-y1;
     d:=2*dy-dx;
     inc1:=2*dx;
     inc2:=2*(dx-dy);
     x:=x1;
     y:=y1;
     while y<=y2 do
           begin
                image1.Canvas.Pixels[x,image1.Height-y]:=colorgrid1.ForegroundColor;
                if d<=0 then
                   begin
                        d:=d+inc1;
                        y:=y+1;
                   end
                else
                   begin
                        d:=d+inc2;
                        x:=x-1;
                        y:=y+1;
                   end;
           end;
end;

procedure Tform1.diagonal180(x1,y1,x2,y2:integer);
var
   x,y,dx,dy,inc1,inc2,D:integer;
begin
     if x1<x2 then
        begin
             d:=x1;
             x1:=x2;
             x2:=d;
        end;
     if y1>y2 then
        begin
             d:=y1;
             y1:=y2;
             y2:=d;
        end;
     dx:=x1-x2;
     dy:=y2-y1;
     d:=2*dx-dy;
     inc1:=2*dy;
     inc2:=2*(dy-dx);
     x:=x1;
     y:=y1;
     while y<=y2 do
           begin
                image1.Canvas.Pixels[x,image1.Height-y]:=colorgrid1.ForegroundColor;
                if d<=0 then
                   begin
                        d:=d+inc1;
                        x:=x-1;
                   end
                else
                   begin
                        d:=d+inc2;
                        x:=x-1;
                        y:=y+1;
                   end;
           end;
end;

procedure Tform1.circunferencia(xc,yc,raio:integer);
procedure plotar(x,y,xc,yc:integer);
begin
     image1.Canvas.Pixels[x+xc,image1.Height-(y+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.Pixels[y+xc,image1.Height-(x+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.Pixels[y+xc,image1.Height-(-x+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.pixels[x+xc,image1.Height-(-y+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.Pixels[-x+xc,image1.Height-(-y+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.Pixels[-y+xc,image1.Height-(-x+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.Pixels[-y+xc,image1.Height-(x+yc)]:=colorgrid1.ForegroundColor;
     image1.Canvas.Pixels[-x+xc,image1.Height-(y+yc)]:=colorgrid1.ForegroundColor;
end;
var
   x,y:integer;
   d:real;
begin
     x:=0;
     y:=raio;
     d:=3-2*raio;
     plotar(x,y,xc,yc);
     while y>x do
           begin
                if (d<0) then
                   begin
                        d:=d+4*x+6;
                        x:=x+1;
                   end
                else
                    begin
                         d:=d+4*(x-y)+10;
                         x:=x+1;
                         y:=y-1;
                    end;
                plotar(x,y,xc,yc);
           end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
     setado:=0;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if button=MBRight then
        setado:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     image1.Canvas.Pen.Color:=clbtnface;
     image1.Canvas.FillRect(rect(0,0,529,305));
     setado:=0;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

     if button=MBRight then
        setado:=0;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   h:integer;
begin
     if setado=0 then
        begin
             xt1:=x;
             xt2:=x;
             yt1:=image1.Height-y;
             yt2:=image1.Height-y;
             //edit1.Text:=inttostr(x);
             statusbar1.Panels.Items[0].Text:='X1: '+inttostr(x);
             //edit2.text:=inttostr(image1.height-y);
             statusbar1.Panels.Items[1].Text:='Y1: '+inttostr(image1.height-y);
             //edit3.text:=inttostr(x);
             statusbar1.Panels.Items[2].Text:='X2: '+inttostr(x);
             //edit4.text:=inttostr(image1.height-y);
             statusbar1.Panels.Items[3].Text:='Y2: '+inttostr(image1.height-y);
             dx1:=x;
             dy1:=image1.height-y;
        end;
     if setado=1 then
        begin
             xt2:=x;
             yt2:=image1.Height-y;
             dx2:=abs(x-dx1);
             dy2:=abs((image1.Height-y)-dy1);
             h:=(dx2*dx2)+(dy2*dy2);
             dist:=sqrt(h);
             //edit3.text:=inttostr(x);
             statusbar1.Panels.Items[2].Text:='X2: '+inttostr(x);
             //edit4.text:=inttostr(image1.height-y);
             statusbar1.Panels.Items[3].Text:='Y2: '+inttostr(image1.height-y);
             statusbar1.Panels.Items[4].Text:='Raio: '+formatfloat('000',dist);
        end;


end;

procedure TForm1.Button1Click(Sender: TObject);
var
   x1,x2,y1,y2,dx,dy,temp:integer;
   m:real;
begin
     x1:=xt1;
     y1:=yt1;
     x2:=xt2;
     y2:=yt2;
     if toolbutton3.Down then
        begin
             if (x1=x2) or (y1=y2) then
                reta(x1,y1,x2,y2)
             else
                 begin
                      dx:=x2-x1;
                      dy:=y2-y1;
                      m:=dy/dx;
                      if (m>0) and (m<=1) then
                         diagonal45(x1,y1,x2,y2);
                      if (m>1) then
                         diagonal90(x1,y1,x2,y2);
                      if (m<0) and (m>-1) then
                         diagonal180(x1,y1,x2,y2);
                      if (m<-1) then
                         diagonal135(x1,y1,x2,y2);
                 end;
        end;
     if toolbutton1.Down then
        begin
             temp:=strtoint(formatfloat('000',dist));
             circunferencia(x1,y1,temp);
        end;
     setado:=0;


end;

procedure TForm1.Image1Click(Sender: TObject);
begin
     setado:=setado+1;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
     if toolbutton3.Down then
        toolbutton3.Down:=false;
     toolbutton1.Down:=true;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
     if toolbutton1.Down then
        toolbutton1.Down:=false;
     toolbutton3.Down:=true;

end;

end.
