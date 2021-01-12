unit detail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids;

type
  Tfrmdet = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    sgg: TStringGrid;
    sgp: TStringGrid;
    btbvolt: TBitBtn;
    GroupBox3: TGroupBox;
    sgr: TStringGrid;
    procedure btbvoltClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmdet: Tfrmdet;

implementation

{$R *.DFM}

uses princ,ajuste;

procedure Tfrmdet.btbvoltClick(Sender: TObject);
begin
     frmdet.Visible:=false;
     frmajuste.Visible:=true;
end;

procedure Tfrmdet.FormActivate(Sender: TObject);
const
     x='X^';
     L=0;
var
   a,b:byte;
begin
     b:=sgg.ColCount-1;
     for a:=0 to sgg.colcount-1 do
         begin
              sgg.Cells[a,l]:=x+inttostr(b);
              sgp.Cells[a,l]:=x+inttostr(b);
              b:=b-1;
         end;
end;

end.
