unit interp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Menus, ComCtrls, ExtCtrls, Buttons;

type
  Tfrmlagr = class(TForm)
    PCinter: TPageControl;
    TSLagr: TTabSheet;
    TSnew: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Sgp: TStringGrid;
    tbp: TTrackBar;
    GroupBox2: TGroupBox;
    edpx: TEdit;
    gbform: TGroupBox;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    lbres: TLabel;
    GroupBox4: TGroupBox;
    btbCal: TBitBtn;
    btblimp: TBitBtn;
    btbsair: TBitBtn;
    btbstep: TBitBtn;
    mnuinp: TMainMenu;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    SGPn: TStringGrid;
    TBN: TTrackBar;
    GroupBox6: TGroupBox;
    EDNpx: TEdit;
    GroupBox7: TGroupBox;
    Sgc: TStringGrid;
    GroupBox8: TGroupBox;
    BTBnc: TBitBtn;
    BTBnl: TBitBtn;
    BTBns: TBitBtn;
    GroupBox9: TGroupBox;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbpChange(Sender: TObject);
    procedure btbCalClick(Sender: TObject);
    procedure btbstepClick(Sender: TObject);
    procedure SgpSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SgpKeyPress(Sender: TObject; var Key: Char);
    procedure edpxKeyPress(Sender: TObject; var Key: Char);
    procedure btbsairClick(Sender: TObject);
    procedure btblimpClick(Sender: TObject);
    procedure BTBncClick(Sender: TObject);
    procedure BTBnlClick(Sender: TObject);
    procedure BTBnsClick(Sender: TObject);
    procedure TBNChange(Sender: TObject);
    procedure SGPnSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure SGPnKeyPress(Sender: TObject; var Key: Char);
    procedure EDNpxKeyPress(Sender: TObject; var Key: Char);
    
  private
    { Private declarations }
    function Lxres(i:byte;grid:Tstringgrid):real; // extrai o resultado de lagrange
    function LxPasso(i:byte;grid:Tstringgrid):string; // mostra os passos de lagrange
    function lxpasso2(i:byte;grid:Tstringgrid):string; // mostra os passos de lagrange
  public
    { Public declarations }
  end;

var
  frmlagr: Tfrmlagr;
 

implementation

{$R *.DFM}

uses princ,step;

function tfrmlagr.Lxres(i:byte;grid:Tstringgrid):real;
var
   j:byte;
   k,l,a,b,p:real;
begin
     k:=1;
     l:=1;
     p:=strtofloat(edpx.Text);
     for j:=1 to grid.RowCount-1 do
         begin
              if i<>j then
                 begin
                      coluna:=0;
                      linha:=i;
                      a:=strtofloat(grid.Cells[0,i]);
                      linha:=j;
                      b:=strtofloat(grid.cells[0,j]);
                      k:=k*(a-b);
                      l:=l*(p-b);
                 end;
         end;
     lxres:=(l/k);
end;

function tfrmlagr.LxPasso(i:byte;grid:tstringgrid):string;
const
     x='X';
var
   j:byte;
   k,l:string;
begin
     k:='';
     l:='';
     for j:=1 to grid.RowCount-1 do
         begin
              if i<>j then
                 begin
                      if (strtofloat(grid.cells[0,j]))=abs(strtofloat(grid.cells[0,j])) then
                         begin
                              k:=k+'('+X+' - X'+inttostr(j-1)+')';
                              l:=l+'('+X+inttostr(i-1)+' - X'+inttostr(j-1)+')';
                         end
                      else
                          begin
                               k:=k+'('+X+' - X'+inttostr(j-1)+')';
                               l:=l+'('+X+inttostr(i-1)+' - X'+inttostr(j-1)+')';
                          end;
                 end;
         end;
     lxpasso:=k+' / '+l;
end;

function tfrmlagr.lxpasso2(i:byte;grid:Tstringgrid):string;
const
     x='X';
var
   j:byte;
   k,l:string;
begin
     k:='';
     l:='';
     for j:=1 to grid.RowCount-1 do
         begin
              if i<>j then
                 begin
                      if (strtofloat(grid.cells[0,j]))=abs(strtofloat(grid.cells[0,j])) then
                         begin
                              k:=k+'('+edpx.text+' - '+grid.Cells[0,j]+')';
                              l:=l+'('+grid.Cells[0,i]+' - '+grid.cells[0,j]+')';
                         end
                      else
                          begin
                               k:=k+'('+edpx.Text+' + '+floattostr(abs(strtofloat(grid.Cells[0,j])))+')';
                               l:=l+'('+grid.cells[0,i]+' + '+floattostr(abs(strtofloat(grid.Cells[0,j])))+')';
                          end;
                 end;
         end;
     lxpasso2:=k+' / '+l;
end;

procedure Tfrmlagr.FormActivate(Sender: TObject);
begin
     sgp.Cells[0,0]:='X';
     sgp.Cells[1,0]:='Y';
     sgpn.Cells[0,0]:='X';
     sgpn.cells[1,0]:='Y';
     sgc.cells[0,0]:='X';
     sgc.cells[1,0]:='F(x)';
     frmpri.Salvar1.Enabled:=true;
     label1.caption:=inttostr(tbp.position-1);
     label2.caption:=inttostr(tbn.position-1);
     frmpri.Matriz.Enabled:=true;
     frmpri.Gauss.Enabled:=true;
     frmpri.Jacobi.Enabled:=true;
     frmpri.voltar.Visible:=true;
     frmpri.Biseccao.Enabled:=true;
     frmpri.Ajuste.Enabled:=true;
     frmpri.MatrizI.Enabled:=true;
     frmpri.Trapezio.Enabled:=true;
     frmpri.Simpson13.Enabled:=true;
     frmpri.Simpson38.Enabled:=true;
     mnuinp.Merge(frmpri.mnupri);
end;

procedure Tfrmlagr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmlagr.Visible:=false;
     frmpri.Visible:=true;
     mnuinp.Unmerge(frmpri.mnupri);
end;

procedure Tfrmlagr.tbpChange(Sender: TObject);
begin
     label1.caption:=inttostr(tbp.position-1);
     sgp.RowCount:=tbp.Position;
   
end;

procedure Tfrmlagr.btbCalClick(Sender: TObject);
var
   a:byte;
   result:real;
   formula,ind:string;
begin
     btbcal.Enabled:=false;
     btblimp.Enabled:=true;
     btbstep.Enabled:=true;
     if edpx.text<>'' then
        begin
             try
                begin
                     result:=0;
                     ind:='';
                     btbstep.Enabled:=true;
                     frmpassos.Memopasso.Clear;
                     frmpri.tracejado;
                     frmpassos.Memopasso.Lines.Append('Interpolação de Lagrange');
                     frmpri.tracejado;
                     frmpri.memospace;
                     formula:='P(X)=';
                     for a:=0 to sgp.RowCount-2 do
                         begin
                              ind:=ind+'Y'+inttostr(a)+'L'+inttostr(a)+'(X) + ';
                              coluna:=1;
                              linha:=a+1;
                              result:=result+strtofloat(sgp.Cells[1,a+1])*lxres(a+1,sgp);
                         end;
                     ind[length(ind)-1]:=' ';
                     memo1.Lines.Append(formula+ind);
                     frmpassos.Memopasso.Lines.Append('Fórmula Geral');
                     frmpri.memospace;
                     frmpassos.Memopasso.Lines.Append(formula+ind);
                     frmpri.memospace;
                     for a:=0 to sgp.RowCount-2 do
                         begin
                              frmpassos.Memopasso.Lines.Append('L '+inttostr(a)+' = '+LxPasso(a+1,sgp));
                              frmpri.memospace;
                         end;
                     lbres.Caption:=floattostr(result);
                     frmpri.memospace;
                     frmpri.tracejado;
                     frmpassos.Memopasso.Lines.Append('Pontos');
                     frmpri.memospace;
                     frmpri.mostrapot(sgp);
                     frmpri.memospace;
                     frmpassos.Memopasso.Lines.Append('P(X)= '+edpx.text);
                     frmpri.memospace;
                     for a:=0 to sgp.RowCount-2 do
                         begin
                              frmpassos.Memopasso.Lines.Append('L '+inttostr(a)+' = '+LxPasso2(a+1,sgp)+' = '+floattostr(lxres(a+1,sgp)));
                              frmpri.memospace;
                         end;
                     frmpri.memospace;
                     frmpri.tracejado;
                     frmpassos.Memopasso.Lines.Append('Resultado');
                     frmpri.memospace;
                     frmpassos.Memopasso.Lines.Append('P('+edpx.text+')= '+lbres.Caption);
                end;
             except
                   on EConvertError do
                      begin
                           Messagedlg('Caracteres inválidos encontrado',mterror,[mbok],0);
                           sgp.col:=coluna;
                           sgp.row:=linha;
                      end;
                   on EDivByZero do
                      messagedlg('Divisão por Zero, verifique se os valores estão corretos.',mterror,[mbok],0);
             end;
        end
     else
         begin
              messagedlg('É necessário um valor para P(X)',mtinformation,[mbok],0);
              edpx.SetFocus;
              btbcal.Enabled:=true;
              btbstep.Enabled:=false;
         end;
end;

procedure Tfrmlagr.btbstepClick(Sender: TObject);
begin
     frmpassos.Show;
end;

procedure Tfrmlagr.SgpSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
     btblimp.Enabled:=true;
     btbcal.Enabled:=true;
end;

procedure Tfrmlagr.SgpKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmlagr.edpxKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmlagr.btbsairClick(Sender: TObject);
begin
     frmpri.limpa(sgp);
     edpx.Text:='';
     frmlagr.visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmlagr.btblimpClick(Sender: TObject);
begin
     btblimp.Enabled:=false;
     btbcal.Enabled:=true;
     if messagedlg('Deseja limpar a tabela e o P(X), clique em [all]'+chr(10)+chr(13)+'Caso queira limpar só o P(X), clique em [No]',mtinformation,[mbAll,mbNo],0)=mrAll then
        begin
             frmpri.limpa(sgp);
        end;
     edpx.text:='';
end;

procedure Tfrmlagr.BTBncClick(Sender: TObject);
var a,b,c,d,j,k:byte;
    f,g,h,i,l,m,n,o:real;
begin
     btbnc.Enabled:=false;
     if ednpx.Text<>'' then
        begin
             try
                for a:=0 to 1 do
                    for b:=1 to sgpn.RowCount-1 do
                        sgc.Cells[a,b]:=sgpn.cells[a,b];
                c:=sgpn.rowcount-2;
                for j:=2 to sgc.ColCount-1 do
                    begin
                         d:=j;
                         for k:=1 to c do
                             begin
                                  linha:=k+1;
                                  coluna:=j-1;
                                  f:=strtofloat(sgc.cells[j-1,k+1]);
                                  linha:=k;
                                  g:=strtofloat(sgc.Cells[j-1,k]);
                                  linha:=d;
                                  coluna:=0;
                                  h:=strtofloat(sgc.cells[0,d]);
                                  linha:=k;
                                  i:=strtofloat(sgc.cells[0,k]);
                                  sgc.cells[j,k]:=formatfloat('0.00',(f-g)/(h-i));
                                  d:=d+1;
                             end;
                         c:=c-1;
                    end;
                l:=strtofloat(sgc.cells[1,1]);
                m:=1;
                o:=0;
                for a:=2 to sgc.colcount-1 do
                    begin
                         m:=m*((strtofloat(ednpx.text))-(strtofloat(sgc.cells[0,a-1])));
                         n:=strtofloat(sgc.cells[a,1]);
                         o:=o+m*n;
                    end;
                o:=l+o;
                label3.caption:=formatfloat('0.00',o);
             except
                   on EConvertError do
                      begin
                           Messagedlg('Caracteres inválidos encontrado',mterror,[mbok],0);
                           sgpn.col:=coluna;
                           sgpn.row:=linha;
                      end;
                   on EDivByZero do
                      messagedlg('Divisão por Zero, verifique se os valores estão corretos.',mterror,[mbok],0);
             end;
        end
     else
         begin
              messagedlg('É necessário um valor para P(X)',mtinformation,[mbok],0);
              ednpx.SetFocus;
              btbnc.Enabled:=true;
         end;
end;

procedure Tfrmlagr.BTBnlClick(Sender: TObject);
begin
     btbnl.Enabled:=false;
     btbnc.Enabled:=true;
     if messagedlg('Deseja limpar a tabela e o P(X), clique em [all]'+chr(10)+chr(13)+'Caso queira limpar só o P(X), clique em [No]',mtinformation,[mbAll,mbNo],0)=mrAll then
        begin
             frmpri.limpa(sgpn);
             frmpri.limpa(sgc);
        end;
     ednpx.text:='';
end;

procedure Tfrmlagr.BTBnsClick(Sender: TObject);
begin
     frmpri.limpa(sgpn);
     frmpri.limpa(sgc);
     ednpx.Text:='';
     frmlagr.visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmlagr.TBNChange(Sender: TObject);
begin
     label2.Caption:=inttostr(tbn.position-1);
     sgpn.RowCount:=tbn.position;
     sgc.RowCount:=tbn.Position;
     sgc.ColCount:=tbn.Position;
end;

procedure Tfrmlagr.SGPnSelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
begin
     btbnc.Enabled:=true;
     btbnl.Enabled:=true;
end;

procedure Tfrmlagr.SGPnKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmlagr.EDNpxKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

end.
