unit polinomio1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Polinomio2,
  StdCtrls;

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
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Edit1Change(Sender: TObject);
begin
invalidate;
end;

procedure TForm1.FormPaint(Sender: TObject);
var p: polinomio;
begin
p := polinomio.create;
p.a := strtofloat(edit1.text);
p.b := strtofloat(edit2.text);
p.c := strtofloat(edit3.text);
p.d := strtofloat(edit4.text);
p.desenha(canvas, 60,
                  height -30,
                  10,
                  width - 30,
                  0,
                  5);
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
invalidate
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
invalidate
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
invalidate
end;

procedure TForm1.FormResize(Sender: TObject);
begin
invalidate
end;

end.
