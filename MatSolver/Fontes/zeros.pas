unit Zeros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ComCtrls, Buttons,{math,} Menus, ExtCtrls;

type
  Tfrmzeros = class(TForm)
  GroupBox1: TGroupBox;
    tbeq: TTrackBar;
    GroupBox3: TGroupBox;
    sgib: TStringGrid;
    GroupBox2: TGroupBox;
    lbres: TLabel;
    lberr: TLabel;
    lbint: TLabel;
    GroupBox6: TGroupBox;
    lbmenor: TLabel;
    lbmaior: TLabel;
    Label2: TLabel;
    lbil: TLabel;
    lbih: TLabel;
    mnuzeros: TMainMenu;
    GroupBox4: TGroupBox;
    SGEq: TStringGrid;
    GroupBox5: TGroupBox;
    cberr: TComboBox;
    GroupBox7: TGroupBox;
    cbint: TComboBox;
    GroupBox8: TGroupBox;
    btcb: TBitBtn;
    btpb: TBitBtn;
    btbl: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox9: TGroupBox;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbeqChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btcbClick(Sender: TObject);
    procedure SGEqKeyPress(Sender: TObject; var Key: Char);
    procedure cberrChange(Sender: TObject);
    procedure cbintChange(Sender: TObject);
    procedure btblClick(Sender: TObject);
    procedure SGEqClick(Sender: TObject);
    procedure btpbClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cberrKeyPress(Sender: TObject; var Key: Char);
    procedure cbintKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    
    function Xm(a,b:real):real; // calcula Xm a+b/2
    procedure erro(lin:byte); // calcula o erro
    procedure mostraeq; // mostra a equação no passo a passo
  public
    { Public declarations }
    procedure calcula; // realiza os calculos
    procedure resultado; // mostra o resultado
    procedure labels; // coloca os labels na sgeq
  end;

var
  frmzeros: Tfrmzeros;
  col,maior:byte;
  menor:shortint;
  i,j:real;

implementation

{$R *.DFM}

uses sislin,apresenta,step,princ,intervalo;

procedure tfrmzeros.mostraeq;
var
   l,m:byte;
   equacao:string;
begin
     l:=1;
     m:=0;
     equacao:='';
     while m<=sgeq.ColCount-1 do
           begin
                if m<>sgeq.ColCount-1 then
                   equacao:=equacao+sgeq.Cells[m,l]+sgeq.Cells[m,l-1]+' + '
                else
                    equacao:=equacao+sgeq.Cells[m,l];
                m:=m+1;
           end;
     frmpassos.Memopasso.Lines.Append('Equação:');
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append(equacao);
     frmpri.memospace;
     frmpri.tracejado;
end;

procedure tfrmzeros.labels;
const
     x='X^';
     L=0;
var
   a,b:byte;
begin
     b:=sgeq.ColCount-1;
     for a:=0 to sgeq.colcount-1 do
         begin
              sgeq.Cells[a,l]:=x+inttostr(b);
              b:=b-1;
         end;
     sgib.Cells[sgib.ColCount-1,l]:='E<='+cberr.Text;
     sgib.cells[0,0]:='Int.= '+cbint.text;
end;

function tfrmzeros.Xm(a,b:real):real;
begin
     xm:=(a+b)/2;
end;

procedure tfrmzeros.calcula;
const
     l=1;
var
   n,it:byte;
   x,y,z,w:real;
begin
     i:=strtoint(lbmenor.caption);
     j:=strtoint(lbmaior.caption);
     sgib.Cells[0,l]:=inttostr(l);
     sgib.cells[5,l]:='------';
     sgib.cells[l,l]:=formatfloat('0.'+frmpri.precisao(cberr),i);
     sgib.cells[2,l]:=formatfloat('0.'+frmpri.precisao(cberr),j);
     sgib.cells[3,l]:=formatfloat('0.'+frmpri.precisao(cberr),(xm(i,j)));
     sgib.Cells[4,l]:=formatfloat('0.'+frmpri.precisao(cberr),(frmpri.eq(sgeq,xm(i,j))));
     it:=(strtoint(cbint.text));
     n:=1;
     repeat
           sgib.rowcount:=n+2;
           sgib.cells[0,n+1]:=inttostr(n+1);
           coluna:=l;
           linha:=n;
           x:=frmpri.eq(sgeq,strtofloat(sgib.cells[l,n]));
           coluna:=4;
           y:=strtofloat(sgib.cells[4,n]);
           if (x*y)<0 then
              begin
                   sgib.Cells[1,n+1]:=sgib.Cells[1,n];
                   sgib.cells[2,n+1]:=sgib.cells[3,n];
                   frmpri.memospace;
                   frmpassos.Memopasso.Lines.Append(formatfloat('0.'+frmpri.precisao(cberr),x)+' * '+formatfloat('0.'+frmpri.precisao(cberr),y)+' <=0, o intervalo é: '+sgib.cells[1,n]+' |---| '+sgib.cells[3,n]);
              end
           else
               begin
                    sgib.cells[1,n+1]:=sgib.cells[3,n];
                    sgib.cells[2,n+1]:=sgib.cells[2,n];
                    frmpri.memospace;
                    frmpassos.Memopasso.Lines.Append(formatfloat('0.'+frmpri.precisao(cberr),x)+' * '+formatfloat('0.'+frmpri.precisao(cberr),y)+' <=0, o intervalo é: '+sgib.cells[2,n]+' |---| '+sgib.cells[3,n]);
               end;
           coluna:=1;
           linha:=n+1;
           z:=strtofloat(sgib.cells[1,n+1]);
           coluna:=2;
           w:=strtofloat(sgib.cells[2,n+1]);
           sgib.cells[3,n+1]:=formatfloat('0.'+frmpri.precisao(cberr),(xm(z,w)));
           frmpri.memospace;
           frmpassos.Memopasso.Lines.Append('Xm= '+formatfloat('0.'+frmpri.precisao(cberr),z)+' + '+formatfloat('0.'+frmpri.precisao(cberr),w)+' / 2 = '+formatfloat('0.'+frmpri.precisao(cberr),(xm(z,w))));
           sgib.cells[4,n+1]:=formatfloat('0.'+frmpri.precisao(cberr),(frmpri.eq(sgeq,xm(z,w))));
           erro(n+1);
           n:=n+1;
     until  (n>=it) or (strtofloat(sgib.cells[5,n])<=strtofloat(cberr.text))
           or (strtofloat(sgib.cells[4,n])=0);
     frmpri.memospace;
     frmpri.tracejado;
end;

procedure tfrmzeros.erro(lin:byte);
const
     col=3;
var
   a,b:real;
begin
     a:=strtofloat(sgib.Cells[col,lin]);
     b:=strtofloat(sgib.cells[col,lin-1]);
     sgib.cells[5,lin]:=formatfloat('0.'+frmpri.precisao(cberr),abs(a-b));
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Erro: '+formatfloat('0.'+frmpri.precisao(cberr),a)+' - '+formatfloat('0.'+frmpri.precisao(cberr),b)+' = | '+sgib.cells[5,lin]+' |');
end;

procedure tfrmzeros.resultado;
begin
     frmpri.graph(image1,sgeq,clred);
     lbres.caption:='Raiz: '+sgib.cells[3,sgib.rowcount-1];
     lberr.caption:='Erro: '+sgib.cells[5,sgib.rowcount-1];
     lbint.caption:='Interações: '+sgib.cells[0,sgib.rowcount-1];
     frmpri.memospace;
     frmpri.tracejado;
     frmpassos.Memopasso.Lines.Append('Resultado Final');
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append(lbint.Caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append(lbres.Caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append(lberr.Caption);
     frmpri.tracejado;
end;

procedure Tfrmzeros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmzeros.Visible:=false;
     frmpri.Visible:=true;
     mnuzeros.Unmerge(frmpri.mnupri);
end;

procedure Tfrmzeros.tbeqChange(Sender: TObject);
begin
     sgeq.ColCount:=tbeq.Position;
     labels;
end;

procedure Tfrmzeros.FormActivate(Sender: TObject);
begin
     frmpri.limpgraph(image1);
     frmpri.Salvar1.Enabled:=true;
     frmpri.voltar.visible:=true;
     frmpri.Matriz.Enabled:=true;
     frmpri.Gauss.Enabled:=true;
     frmpri.Jacobi.Enabled:=true;
     frmpri.ajuste.Enabled:=true;
     frmpri.Lagrange.Enabled:=true;
     frmpri.MatrizI.Enabled:=true;
     frmpri.Trapezio.Enabled:=true;
     frmpri.Simpson13.Enabled:=true;
     frmpri.Simpson38.Enabled:=true;
     mnuzeros.Merge(frmpri.mnupri);
     cbint.Text:=cbint.Items.Strings[4];
     cberr.text:=cberr.items.strings[3];
     sgib.RowCount:=strtoint(cbint.text)+1;
     sgib.cells[1,0]:='a';
     sgib.cells[2,0]:='b';
     sgib.cells[3,0]:='Xm';
     sgib.cells[4,0]:='f(Xm)';
     labels;
end;

procedure Tfrmzeros.btcbClick(Sender: TObject);
begin
     frmpassos.Memopasso.Clear;
     try
        begin
             Image1.Canvas.Brush.Color:=clwhite;

             if cberr.Text='' then
                cberr.text:=cberr.Items.Strings[3];
             if cbint.text='' then
                cbint.text:=cbint.Items.Strings[4];
             tbeq.Enabled:=false;
             btbl.Enabled:=true;
             btpb.Enabled:=true;
             btcb.Enabled:=false;
             frmpri.tracejado;
             frmpassos.Memopasso.Lines.Append('Método da Bisecção - Passo-a-passo');
             frmpri.tracejado;
             frmpri.memospace;
             mostraeq;
             frmpri.memospace;
             frminter.ShowModal;
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgeq.Col:=coluna;
                   sgeq.row:=linha;
              end;
     end;
end;

procedure Tfrmzeros.SGEqKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','-',',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmzeros.cberrChange(Sender: TObject);
begin
     sgib.Cells[sgib.ColCount-1,0]:='E<='+cberr.text;
end;

procedure Tfrmzeros.cbintChange(Sender: TObject);
begin
     sgib.Cells[0,0]:='Int.= '+cbint.Text;
end;

procedure Tfrmzeros.btblClick(Sender: TObject);
begin
     btcb.Enabled:=true;
     tbeq.Enabled:=true;
     if messagedlg('Deseja limpar todas as tabelas, clique em [all]'+chr(10)+chr(13)+'Caso queira limpar as interações, clique em [No]',mtinformation,[mbAll,mbNo],0)=mrAll then
        begin
             frmpri.limpa(sgeq);
        end;
     frmpri.limpa(sgib);
     lbint.Caption:='Interações:';
     lbres.Caption:='Raiz:';
     lberr.Caption:='Erro:';
     frmpri.limpgraph(image1);
end;

procedure Tfrmzeros.SGEqClick(Sender: TObject);
begin
     btcb.Enabled:=true;
     btbl.Enabled:=true;
end;

procedure Tfrmzeros.btpbClick(Sender: TObject);
begin
     frmpassos.Show;
end;

procedure Tfrmzeros.BitBtn1Click(Sender: TObject);
begin
     frmpri.limpa(sgeq);
     frmpri.limpa(sgib);
     frmpri.limpgraph(image1);
     frmzeros.Visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmzeros.cberrKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmzeros.cbintKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmzeros.FormCreate(Sender: TObject);
begin
     labels;
end;

end.
