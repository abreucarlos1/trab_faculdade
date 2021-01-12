unit ajuste;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, StdCtrls, ExtCtrls, Menus, Buttons,math;

type
  Tfrmajuste = class(TForm)
    GroupBox1: TGroupBox;
    tbp: TTrackBar;
    sgp: TStringGrid;
    mnuajuste: TMainMenu;
    GroupBox3: TGroupBox;
    Image1: TImage;
    GroupBox4: TGroupBox;
    btbret: TBitBtn;
    btbquad: TBitBtn;
    btbcub: TBitBtn;
    btbdet: TBitBtn;
    GroupBox2: TGroupBox;
    sgc: TStringGrid;
    Splitter1: TSplitter;
    sgsum: TStringGrid;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    btblimp: TBitBtn;
    btbstep: TBitBtn;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbpChange(Sender: TObject);
    procedure btbretClick(Sender: TObject);
    procedure btbquadClick(Sender: TObject);
    procedure btbcubClick(Sender: TObject);
    procedure btbdetClick(Sender: TObject);
    procedure sgpKeyPress(Sender: TObject; var Key: Char);
    procedure sgpClick(Sender: TObject);
    procedure btblimpClick(Sender: TObject);
    procedure btbstepClick(Sender: TObject);
  private
    { Private declarations }
    procedure calc; // calcula os valores da tabela
    procedure metodo(tam:byte);

  public
    { Public declarations }
  end;

var
  frmajuste: Tfrmajuste;

implementation

{$R *.DFM}

uses princ,detail,step;

procedure Tfrmajuste.FormActivate(Sender: TObject);
const
     l=0;
begin
     label2.caption:=inttostr(tbp.position-1);
     frmpri.Salvar1.Enabled:=true;
     frmpri.voltar.visible:=true;
     frmpri.Biseccao.Enabled:=true;
     frmpri.Lagrange.Enabled:=true;
     frmpri.Matriz.Enabled:=true;
     frmpri.Gauss.Enabled:=true;
     frmpri.Jacobi.Enabled:=true;
     frmpri.MatrizI.Enabled:=true;
     frmpri.Trapezio.Enabled:=true;
     frmpri.Simpson13.Enabled:=true;
     frmpri.Simpson38.Enabled:=true;
     mnuajuste.Merge(frmpri.mnupri);
     frmpri.limpgraph(image1);
     sgsum.Cells[l,l]:='S';
     sgp.Cells[l,l]:='X';
     sgp.cells[1,l]:='Y';
     sgc.cells[1,l]:='X';
     sgc.cells[2,l]:='Y';
     sgc.Cells[3,l]:='X^2';
     sgc.cells[4,l]:='X^3';
     sgc.cells[5,l]:='X^4';
     sgc.Cells[6,l]:='X^5';
     sgc.Cells[7,l]:='X^6';
     sgc.cells[8,l]:='XY';
     sgc.cells[9,l]:='X^2Y';
     sgc.cells[10,l]:='X^3Y';
end;

procedure tfrmajuste.calc;
var
   x,y:byte;
   z:real;
begin
     frmpri.tracejado;
     frmpassos.Memopasso.Lines.Append('Ajuste de Curvas');
     frmpri.tracejado;
     frmpri.memospace;
     for x:=0 to 1 do
         for y:=1 to sgp.RowCount-1 do
             sgc.Cells[x+1,y]:=sgp.cells[x,y];
     for x:=1 to sgp.rowcount-1 do
         begin
              coluna:=1;
              linha:=x;
              for y:=2 to 6 do
                  sgc.cells[y+1,x]:=formatfloat('0.00',power(strtofloat(sgc.cells[1,x]),y));
              sgc.Cells[8,x]:=formatfloat('0.00',(strtofloat(sgc.cells[1,x])*(strtofloat(sgc.cells[2,x]))));
              sgc.Cells[9,x]:=formatfloat('0.00',(strtofloat(sgc.cells[3,x])*(strtofloat(sgc.cells[2,x]))));
              sgc.Cells[10,x]:=formatfloat('0.00',(strtofloat(sgc.cells[4,x])*(strtofloat(sgc.cells[2,x]))));
         end;
     for x:=1 to sgc.ColCount-1 do
         begin
              z:=0;
              for y:=1 to sgc.RowCount-1 do
                  z:=z+strtofloat(sgc.cells[x,y]);
              sgsum.cells[x,0]:=formatfloat('0.00',z);
         end;
     frmpassos.Memopasso.Lines.Append('Tabela de pontos e cálculo');
     frmpri.memospace;
     frmpri.mostramat(sgc);
     frmpri.mostramat(sgsum);
end;

procedure Tfrmajuste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmajuste.Visible:=false;
     frmpri.Visible:=true;
     frmpri.voltar.Visible:=false;
     mnuajuste.Unmerge(frmpri.mnupri);
end;


procedure Tfrmajuste.tbpChange(Sender: TObject);
begin
     sgp.RowCount:=tbp.Position;
     sgc.rowcount:=tbp.position;
     label2.Caption:=inttostr(tbp.position-1);
          //btbret.Enabled:=true;
    { if tbp.Position>3 then
        begin
             btbquad.Enabled:=true;
             btbret.Enabled:=true;
        end;
     if tbp.Position>4 then
        btbcub.enabled:=true;
     btblimp.Enabled:=true; }
end;

procedure Tfrmajuste.btbretClick(Sender: TObject);
begin
     try
        begin
             frmpassos.Memopasso.Clear;
             calc;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Aplica-se Gauss');
             frmpri.memospace;
             metodo(3);
             btblimp.Enabled:=true;
             btbstep.Enabled:=true;
             btbdet.Enabled:=true;
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgp.col:=coluna;
                   sgp.row:=linha;
              end;
     end;
end;

procedure tfrmajuste.metodo(tam:byte);
const
     l='X^';
var
   a,c,d,e:byte;
   b:integer;
   x:string;
begin
     btbdet.Enabled:=true;
     frmdet.sgg.ColCount:=tam;
     frmdet.sgg.RowCount:=tam;
     frmdet.sgp.ColCount:=tam;
     frmdet.sgp.RowCount:=tam;
     frmdet.sgr.ColCount:=tam-1;
     frmdet.sgg.cells[frmdet.sgg.colcount-1,1]:=sgsum.cells[2,0];
     d:=frmdet.sgg.ColCount-1;
     e:=8;
     for a:=2 to frmdet.sgg.rowcount-1 do
         begin
              frmdet.sgg.Cells[d,a]:=sgsum.cells[e,0];
              e:=e+1;
         end;
     frmdet.sgg.cells[0,1]:=inttostr(sgp.RowCount-1);
     frmdet.sgg.cells[0,2]:=sgsum.Cells[1,0];
     frmdet.sgg.cells[1,1]:=sgsum.Cells[1,0];
     c:=3;
     b:=3;
     for a:=0 to frmdet.sgg.colcount-2 do
          begin
               frmdet.sgg.cells[a,b]:=sgsum.cells[c,0];
               frmdet.sgg.Cells[a,b+1]:=sgsum.cells[c+1,0];
               frmdet.sgg.cells[a,b+2]:=sgsum.Cells[c+2,0];
               frmdet.sgg.cells[a,b+3]:=sgsum.Cells[c+3,0];
               frmdet.sgg.cells[a,b+4]:=sgsum.cells[c+4,0];
               b:=b-1;
          end;
     for a:=1 to frmdet.sgg.RowCount-1 do
         for b:=0 to frmdet.sgg.ColCount-1 do
             frmdet.sgp.Cells[b,a]:=frmdet.sgg.Cells[b,a];
     b:=frmdet.sgr.colcount-1;
     for a:=0 to frmdet.sgr.colcount-1 do
         begin
              frmdet.sgr.cells[a,0]:=l+inttostr(b);
              b:=b-1;
         end;
     frmpri.CalcGauss(frmdet.sgp,1);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Resultados');
     frmpri.memospace;
     frmpri.Coeficientes(frmdet.sgr,frmdet.sgp);
     frmpri.memospace;
     b:=frmdet.sgr.ColCount-1;
     a:=0;
     case tam of
          3:frmpassos.Memopasso.Lines.Append('Equação da Reta');
          4:frmpassos.Memopasso.Lines.Append('Equação Quadrática');
          5:frmpassos.Memopasso.Lines.Append('Equação Cúbica');
     end;
     while a<b do
           begin
                x:=frmdet.sgr.cells[b,1];
                frmdet.sgr.cells[b,1]:=frmdet.sgr.Cells[a,1];
                frmdet.sgr.cells[a,1]:=x;
                b:=b-1;
                a:=a+1;
           end;
     x:='';
     for a:=0 to frmdet.sgr.ColCount-1 do
         x:=x+frmdet.sgr.Cells[a,1]+frmdet.sgr.cells[a,0]+' + ';
     label1.Caption:=x;
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append(x);
     if tam=3 then
        frmpri.Graph(image1,frmdet.sgr,clred);
     if tam=4 then
        frmpri.Graph(image1,frmdet.sgr,clblue);
     if tam=5 then
        frmpri.Graph(image1,frmdet.sgr,clgreen);
end;

procedure Tfrmajuste.btbquadClick(Sender: TObject);
begin
     try
        begin
             frmpassos.Memopasso.Clear;
             calc;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Aplica-se Gauss');
             frmpri.memospace;
             metodo(4);
             btblimp.Enabled:=true;
             btbstep.Enabled:=true;
             btbdet.Enabled:=true;
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgp.col:=coluna;
                   sgp.row:=linha;
              end;
     end;
end;

procedure Tfrmajuste.btbcubClick(Sender: TObject);
begin
     try
        begin
             frmpassos.Memopasso.Clear;
             calc;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Aplica-se Gauss');
             frmpri.memospace;
             metodo(5);
             btblimp.Enabled:=true;
             btbstep.Enabled:=true;
             btbdet.Enabled:=true;
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgp.col:=coluna;
                   sgp.row:=linha;
              end;
     end;
end;

procedure Tfrmajuste.btbdetClick(Sender: TObject);
begin
     frmdet.Visible:=true;
     frmajuste.Visible:=false;
end;

procedure Tfrmajuste.sgpKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','-',',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmajuste.sgpClick(Sender: TObject);
begin
     btbret.Enabled:=false;
     btbquad.Enabled:=false;
     btbcub.Enabled:=false;
     btbret.Enabled:=true;
     if tbp.Position-1>=3 then
        begin
             btbquad.Enabled:=true;
             btbret.Enabled:=true;
        end;
     if tbp.Position-1>=4 then
        btbcub.enabled:=true;
     btblimp.Enabled:=true;
end;



procedure Tfrmajuste.btblimpClick(Sender: TObject);
var
   a:byte;
begin
     frmpri.limpa(sgp);
     frmpri.limpa(sgc);
     for a:=1 to sgsum.colcount-1 do
         sgsum.cells[a,0]:='';
     frmpri.limpgraph(image1);
     label1.Caption:='';
     btblimp.Enabled:=false;
     btbret.Enabled:=false;
     btbquad.Enabled:=false;
     btbcub.Enabled:=false;
     btbstep.Enabled:=false;
     frmpassos.Memopasso.Clear;
end;

procedure Tfrmajuste.btbstepClick(Sender: TObject);
begin
     frmpassos.show;
end;

end.
