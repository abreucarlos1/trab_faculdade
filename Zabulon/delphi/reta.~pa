unit reta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ColorGrd;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    ColorGrid1: TColorGrid;
    Panel1: TPanel;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure reta(x1,y1,x2,y2:integer);
    procedure diagonal45(x1,y1,x2,y2,dx,dy:integer);
    procedure diagonal90(x1,y1,x2,y2,dx,dy:integer);
  end;

var
  Form1: TForm1;
  setado:byte;

implementation

{$R *.DFM}

procedure Tform1.reta(x1,y1,x2,y2:integer);
var
   inc1,inc2:integer;
begin
     for inc1:=x1 to x2 do
         for inc2:=y1 to y2 do
             image1.Canvas.Pixels[inc1,inc2]:=colorgrid1.ForegroundColor;
end;

procedure Tform1.diagonal45(x1,y1,x2,y2,dx,dy:integer);
var
   x,y,inc1,inc2,D:integer;
begin
     x:=x1;
     y:=y1;
     inc1:=2*dy;
     inc2:=2*(dy-dx);
     d:=inc1-dx;
     while x<=x2 do
           begin
                image1.Canvas.Pixels[x,360-y]:=colorgrid1.ForegroundColor;
                if d<0 then
                   begin
                        d:=d+inc1;
                        x:=x+1;
                   end;
                if d>=0 then
                   begin
                        d:=d+inc2;
                        x:=x+1;
                        y:=y+1;
                   end;
           end;
end;

procedure Tform1.diagonal90(x1,y1,x2,y2,dx,dy:integer);
var
   x,y,inc1,inc2,D:integer;
begin
     x:=x1;
     y:=y1;
     inc1:=2*dx;
     inc2:=2*(dx-dy);
     d:=inc1-dy;
     while y<=y2 do
           begin
                image1.Canvas.Pixels[x,360-y]:=colorgrid1.ForegroundColor;
                if d<0 then
                   begin
                        d:=d+inc1;
                        y:=y+1;
                   end;
                if d>=0 then
                   begin
                        d:=d+inc2;
                        x:=x+1;
                        y:=y+1;
                   end;
           end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
     setado:=0
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
     setado:=setado+1;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

begin
     if setado=0 then
        begin
             edit1.Text:=inttostr(x);
             edit2.text:=inttostr(y);
             edit3.text:=inttostr(x);
             edit4.text:=inttostr(y);
        end;
     if setado=1 then
        begin
             edit3.text:=inttostr(x);
             edit4.text:=inttostr(y);
        end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
   x1,y1,x2,y2,dx,dy,temp:integer;
   m:real;
begin
     x1:=strtoint(edit1.text);
     y1:=strtoint(edit2.text);
     x2:=strtoint(edit3.text);
     y2:=strtoint(edit4.text);
     if not (y2>=y1) then
        begin
             temp:=y1;
             y1:=y2;
             y2:=temp;
        end;
     if (x1=x2) or (y1=y2) then
        reta(x1,y1,x2,y2);
     if x2<>x1 then
        begin
             dx:=x2-x1;
             dy:=y2-y1;
        end;
     m:=dy/dx;
     if (m>=0) and (m<1) then
        diagonal45(x1,y1,x2,y2,dx,dy)
     else
         diagonal90(x1,y1,x2,y2,dx,dy);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if button=MBRight then
        setado:=0;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if button=MBRight then
        setado:=0;
end;


end.
