unit Princ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,olectrls, Buttons,grids, ComCtrls, Menus,extctrls,math;

type
  TFrmpri = class(TForm)
    mnupri: TMainMenu;
    Arquivo1: TMenuItem;
    SistemasLineares1: TMenuItem;
    ZerosdeFuno1: TMenuItem;
    Interpolao1: TMenuItem;
    AjustedeCurvas1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    N1: TMenuItem;
    Ajuda2: TMenuItem;
    HeaderControl1: THeaderControl;
    Abrir1: TMenuItem;
    Salvar1: TMenuItem;
    N2: TMenuItem;
    voltar: TMenuItem;
    Matriz: TMenuItem;
    N3: TMenuItem;
    Gauss: TMenuItem;
    Pivotamento1: TMenuItem;
    N4: TMenuItem;
    Jacobi: TMenuItem;
    GaussSeidel1: TMenuItem;
    Biseccao: TMenuItem;
    NewtonRaphson1: TMenuItem;
    Sair2: TMenuItem;
    PCPri: TPageControl;
    TSSL: TTabSheet;
    GroupBox1: TGroupBox;
    BTDM: TBitBtn;
    BTDG: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    BTIM: TBitBtn;
    BTJac: TBitBtn;
    BTGS: TBitBtn;
    TSZF: TTabSheet;
    GroupBox3: TGroupBox;
    btbise: TBitBtn;
    BitBtn4: TBitBtn;
    TSIP: TTabSheet;
    TSAC: TTabSheet;
    GroupBox4: TGroupBox;
    btblagr: TBitBtn;
    Btbnew: TBitBtn;
    Lagrange: TMenuItem;
    Newton: TMenuItem;
    GroupBox5: TGroupBox;
    btbaj: TBitBtn;
    ajuste: TMenuItem;
    Integra: TMenuItem;
    MatrizI: TMenuItem;
    N5: TMenuItem;
    Trapezio: TMenuItem;
    Simpson13: TMenuItem;
    Simpson38: TMenuItem;
    TSINT: TTabSheet;
    GroupBox6: TGroupBox;
    btbmat: TBitBtn;
    btbtra: TBitBtn;
    btbs13: TBitBtn;
    btbs38: TBitBtn;
    SDPri: TSaveDialog;
    ODpri: TOpenDialog;

    procedure BTDMClick(Sender: TObject);
    procedure BTIMClick(Sender: TObject);
    procedure BTDGClick(Sender: TObject);
    procedure BTJacClick(Sender: TObject);
    procedure btbiseClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BTGSClick(Sender: TObject);
    procedure Pivotamento1Click(Sender: TObject);
    procedure GaussSeidel1Click(Sender: TObject);
    procedure voltarClick(Sender: TObject);
    procedure MatrizClick(Sender: TObject);
    procedure GaussClick(Sender: TObject);
    procedure JacobiClick(Sender: TObject);
    procedure BiseccaoClick(Sender: TObject);
    procedure NewtonRaphson1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure Ajuda2Click(Sender: TObject);
    procedure BtbnewClick(Sender: TObject);
    procedure btblagrClick(Sender: TObject);
    procedure NewtonClick(Sender: TObject);
    procedure LagrangeClick(Sender: TObject);
    procedure btbajClick(Sender: TObject);
    procedure ajusteClick(Sender: TObject);
    procedure MatrizIClick(Sender: TObject);
    procedure Simpson13Click(Sender: TObject);
    procedure TrapezioClick(Sender: TObject);
    procedure Simpson38Click(Sender: TObject);
    procedure btbmatClick(Sender: TObject);
    procedure btbtraClick(Sender: TObject);
    procedure btbs13Click(Sender: TObject);
    procedure btbs38Click(Sender: TObject);
    procedure Salvar1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
  private
    { Private declarations }
    procedure acao(sender:Tobject); // define a janela a ser visualizada
  public
    { Public declarations }
    function precisao(combo:Tcombobox):string; // verifica o no de casas apos a virgula
    procedure limpa(grid:Tstringgrid);// limpa a matriz enviada por grid
    procedure mostramat(Grid:Tstringgrid); // mostra a matriz no passo a passo
    procedure mostrapot (grid:Tstringgrid); // mostra a matriz de pontos no passo
    procedure notimple; // mostra msg de não implementado
    procedure tracejado;// imprime o tracejado entre as fases
    procedure memospace; // espaço no memo
    function CalcGauss(grid:TstringGrid;fase:byte):Tstringgrid; // calcula gauss recursivamente
    procedure Coeficientes(var gridres:Tstringgrid;GridEntr:TstringGrid); // retorna os coeficientes de Gauss
    procedure Graph(var img:Timage;grid:Tstringgrid;color:Tcolor); // traça o grafico da função
    procedure limpgraph(var img:Timage); // limpa image
    function eq(grid:TStringGrid;base:real):real; // calcula a equação
    procedure copiamat(Var gsai:Tstringgrid;Gentr:TstringGrid); // copia as matrizes na mudança do TabSheet
    procedure save(grade:TstringGrid;met:byte); // Salva as matrizes conforme método
  end;

var
  Frmpri: TFrmpri;
  coluna,linha:byte;// variaveis universais para pegar linha/coluna onde ocorreu o erro
                       // Usadas em todos os métodos disponiveis.

  implementation

uses apresenta,sislin,step,zeros,about,interp,ajuste,integra;

{$R *.DFM}


procedure tfrmpri.save(grade:TstringGrid;met:byte);
procedure Salvar(grade:Tstringgrid;met:string);
var
   fl:textfile;
   arq,blank:string;
   col,lin,tam:byte;
begin
     if (met='m') or (met='g') or (met='j') or (met='b') then
        tam:=grade.ColCount
     else
         tam:=grade.RowCount;
     arq:='';
     assignfile(fl,sdpri.FileName);
     rewrite(fl);
     writeln(fl,met);
     writeln(fl,inttostr(tam));
     for lin:=1 to grade.rowcount-1 do
         begin
              for col:=0 to grade.colcount do
                  begin
                       if col<grade.colcount-1 then
                          blank:='*'
                       else
                           blank:='';
                       arq:=arq+grade.Cells[col,lin]+blank
                  end;
              writeln(fl,arq);
              arq:='';
         end;
     closefile(fl);
end;

begin
     try
        begin
             case met of
                  1:begin
                         sdpri.FilterIndex:=1;
                         sdpri.DefaultExt:='*.mat';
                         sdpri.FileName:='matriz';
                         if sdpri.Execute then
                            salvar(grade,'m');
                  end;
                  2:begin
                         sdpri.FilterIndex:=2;
                         sdpri.DefaultExt:='*.gau';
                         sdpri.FileName:='Gauss';
                         if sdpri.Execute then
                            salvar(grade,'g');
                  end;
                  3:begin
                         sdpri.FilterIndex:=3;
                         sdpri.DefaultExt:='*.jac';
                         sdpri.FileName:='Jacobi';
                         if sdpri.Execute then
                            salvar(grade,'j');
                  end;
                  4:begin
                         sdpri.FilterIndex:=4;
                         sdpri.DefaultExt:='*.bis';
                         sdpri.FileName:='Bissec';
                         if sdpri.Execute then
                            salvar(grade,'b');
                  end;
                  5:begin
                         sdpri.FilterIndex:=5;
                         sdpri.DefaultExt:='*.lag';
                         sdpri.FileName:='Lagrange';
                         if sdpri.Execute then
                            salvar(grade,'l');
                  end;
                  6:begin
                         sdpri.FilterIndex:=6;
                         sdpri.DefaultExt:='*.aju';
                         sdpri.FileName:='Ajuste';
                         if sdpri.Execute then
                            salvar(grade,'a');
                  end;
                  7:begin
                         sdpri.FilterIndex:=7;
                         sdpri.DefaultExt:='*.pon';
                         sdpri.FileName:='Integra';
                         if sdpri.Execute then
                            salvar(grade,'i');
                  end;
                  8:begin
                         sdpri.FilterIndex:=8;
                         sdpri.DefaultExt:='*.tra';
                         sdpri.FileName:='trapezio';
                         if sdpri.Execute then
                            salvar(grade,'t');
                  end;
                  9:begin
                         sdpri.FilterIndex:=9;
                         sdpri.DefaultExt:='*.s13';
                         sdpri.FileName:='Simp13';
                         if sdpri.Execute then
                            salvar(grade,'13');
                  end;
                  10:begin
                          sdpri.FilterIndex:=10;
                          sdpri.DefaultExt:='*.s38';
                          sdpri.FileName:='Simp38';
                          if sdpri.Execute then
                             salvar(grade,'38');
                  end;
                  11:begin
                          sdpri.filterindex:=11;
                          sdpri.defaultext:='*.new';
                          sdpri.filename:='Newton';
                          if sdpri.execute then
                             salvar(grade,'n');
                  end;
             end;
        end;
     except
           on EFilerError do
              messagedlg('Não é possível salvar este arquivo',mterror,[mbok],0);
     end;
end;

procedure tfrmpri.copiamat(Var gsai:Tstringgrid;Gentr:TstringGrid);
var
   a,b:byte;
begin
     gsai.RowCount:=gentr.RowCount;
     for a:=0 to gentr.ColCount-1 do
         for b:=1 to gentr.RowCount-1 do
             gsai.Cells[a,b]:=gentr.Cells[a,b];
end;

procedure tfrmpri.graph(var img:timage;grid:Tstringgrid;color:Tcolor);
var
   a:integer;
   b:byte;
   Xcoes: array [0..9] of double;
   x,y,offsetx,offsety:integer;
begin
     b:=grid.ColCount-1;
     for a:=0 to 9 do
         xcoes[a]:=0;
     for a:=0 to b do
         begin
              xcoes[a]:=strtofloat(grid.Cells[b,1]);
              b:=b-1;
         end;
     offsetx:=img.Width div 2;
     offsety:=img.Height div 2;
     img.canvas.pen.color:=clblack;
     img.Canvas.MoveTo(offsetx,0);
     for a:=0 to img.Height do
         img.Canvas.LineTo(offsetx,a+img.Height);
     img.Canvas.MoveTo(0,offsety);
     for a:=0 to img.Width do
         img.Canvas.LineTo(a+img.width,offsety);
     img.Canvas.pen.Color:=color;
     a:=-10;
     with img.Canvas do
          begin
               y:=trunc(poly(a,xcoes));
               x:=(a*10+offsetx);
               y:=(offsety-y);
               moveto(x,y);
               for a:=-10 to 10 do
                   begin
                        y:=trunc(poly(a,xcoes));
                        x:=a*10+offsetx;
                        y:=offsety-y;
                        lineto(x,y);
                        moveto(x,y);
                   end;
          end;
end;

procedure tfrmpri.limpgraph(var img:Timage);
var
   retag:Trect;
begin
     retag:=rect(0,0,img.width,img.height);
     img.Canvas.Brush.Color:=clwhite;
     img.Canvas.FillRect(retag);
end;

function tfrmpri.eq(grid:TStringGrid;base:real):real;
var
   c,exp:byte;
   res,cel:real;
begin
     res:=0;
     exp:=grid.ColCount-1;
     for c:=0 to grid.ColCount-1 do
         begin
              coluna:=c;
              linha:=1;
              cel:=strtofloat(grid.cells[c,1]);
              res:=cel*(power(base,exp))+res;
              exp:=exp-1;
         end;
     eq:=res;
end;

function tfrmpri.CalcGauss(grid:TstringGrid;fase:byte):TstringGrid;
type
    arr=TstringGrid;
var
   grade:arr;
   m,adp,adc,Lx,Ly,Lz:real;
   x,y,controle:byte;
   ms,fs,acs,aps,lxs,lys,lzs,rs1,rs2,rs3:string;
begin
     coluna:=0;
     linha:=1;
     grade:=(grid);
     controle:=fase+1;
     fs:=inttostr(fase);
     if fase<grade.RowCount-1 then
        begin
             frmpassos.Memopasso.Lines.Append('Fase: '+fs);
             memospace;
             coluna:=fase-1;
             linha:=fase;
             adp:=strtofloat(grade.cells[fase-1,fase]);
             aps:=formatfloat('0.00',adp);
             for x:=controle to grade.RowCount-1 do
                 begin
                      coluna:=controle-2;
                      linha:=x;
                      adc:=strtofloat(grade.Cells[controle-2,x]);
                      acs:=formatfloat('0.00',adc);
                      m:=-adc/adp;
                      ms:=formatfloat('0.00',m);
                      memospace;
                      rs2:='M'+inttostr(x)+inttostr(fase)+' = -A'+inttostr(controle-1)+
                             inttostr(x)+' / A'+inttostr(fase)+inttostr(fase)+' = '+'M'+inttostr(x)+inttostr(fase)+' = -'+acs+' / '+aps+' = '+ms;
                      frmpassos.Memopasso.Lines.Append(rs2);
                      memospace;
                      for y:=0 to grade.ColCount-1 do
                          begin
                               coluna:=y;
                               linha:=x;
                               ly:=strtofloat(grade.Cells[y,x]);
                               lz:=strtofloat(grade.cells[y,fase]);
                               lys:=formatfloat('0.00',ly);
                               lzs:=formatfloat('0.00',lz);
                               lx:=(m*lz)+ly;
                               lxs:=formatfloat('0.00',lx);
                               rs1:=('L'+inttostr(x)+inttostr(y+1)+' = L'+inttostr(x)+inttostr(y+1)+' + '+
                                      'M'+inttostr(x)+inttostr(fase)+' * L'+inttostr(fase)+inttostr(y+1)+' = ');
                               rs3:=lys+' + '+ms+' * '+lzs+' = '+lxs;
                               frmpassos.Memopasso.Lines.Append(rs1+' '+rs3);
                               memospace;
                               grade.Cells[y,x]:=formatfloat('0.00',lx);
                          end;
                 end;
             fase:=fase+1;
             memospace;
             mostramat(grade);
             memospace;
             tracejado;
             grade:=calcgauss(grade,fase);
        end;
     calcgauss:=grade;
end;

procedure tfrmpri.Coeficientes(Var gridres:TstringGrid;gridentr:TstringGrid);
const
     LM=1;
var
   lin,col,colM:integer;
   soma,Ma,Mb:real;
   sums,mas,mbs,final,incg:string;
begin
     colm:=gridentr.colcount-1;
     coluna:=colm;
     linha:=colm;
     Ma:=strtofloat(gridentr.cells[colm,colm]);
     coluna:=colm-1;
     Mb:=strtofloat(gridentr.cells[colm-1,colm]);
     mas:=gridentr.cells[colm,colm];
     mbs:=gridentr.cells[colm-1,colm];
     incg:=gridres.cells[colm-1,0];
     final:=incg+'= '+mas+' / '+mbs;
     gridres.cells[colm-1,LM]:=formatfloat('0.00',(Ma/Mb));
     memospace;
     frmpassos.Memopasso.Lines.append(final);
     memospace;
     for lin:=colm-1 downto 1 do
         begin
              soma:=0;
              sums:='';
              for col:=lin to colm-1 do
                  begin
                       coluna:=col;
                       linha:=lin;
                       Ma:=strtofloat(gridentr.cells[col,lin]);
                       Mb:=strtofloat(gridres.cells[col,LM]);
                       mas:=gridentr.cells[col,lin];
                       mbs:=gridres.cells[col,lm];
                       soma:=soma+(Ma*Mb);
                       sums:=sums+' + '+mas+' * '+mbs;
                  end;
              coluna:=lin-1;
              linha:=lin;
              Ma:=strtofloat(gridentr.cells[lin-1,lin]);
              coluna:=colm;
              mb:=strtofloat(gridentr.cells[colm,lin]);
              mas:=gridentr.Cells[lin-1,lin];
              mbs:=gridentr.cells[colm,lin];
              incg:=gridres.cells[lin-1,0];
              final:=incg+'= '+mbs+' - '+sums+' / '+mas;
              gridres.cells[lin-1,lm]:=formatfloat('0.00',((mb-soma)/ma));
              memospace;
              frmpassos.memopasso.LineS.append(final);
              memospace;
         end;
     memospace;
     frmpassos.Memopasso.Lines.Append('Resultado Final');
     memospace;
     mostramat(gridres);
end;

procedure tfrmpri.tracejado;
begin
     frmpassos.memopasso.lines.Append('----------------------------------------');
end;

procedure tfrmpri.memospace;
begin
     frmpassos.memopasso.Lines.Append('           ');
end;

procedure tfrmpri.acao(sender:Tobject);
begin
     frmpri.visible:=false;
     if (sender=ajuste) or (sender=btbaj) then
        begin
             frmajuste.visible:=true;
             frmzeros.Visible:=false;
             frmsislin.Visible:=false;
             frmlagr.Visible:=false;
             frmintegra.Visible:=false;
        end;
     if (sender=btblagr) or (sender=lagrange) or (sender=newton) or (sender=btbnew) then
        begin
             frmlagr.Visible:=true;
             frmzeros.Visible:=false;
             frmsislin.Visible:=false;
             frmajuste.visible:=false;
             frmintegra.Visible:=false;
             if (sender=btblagr) or (sender=lagrange) then
                frmlagr.PCinter.ActivePage:=frmlagr.TSLagr;
             if (sender=newton) or (sender=btbnew) then
                frmlagr.PCinter.ActivePage:=frmlagr.TSnew;
        end;
     if (sender=btbise) or (sender=biseccao) then
        begin
             frmzeros.Visible:=true;
             frmsislin.Visible:=false;
             frmlagr.Visible:=false;
             frmajuste.Visible:=false;
             frmintegra.Visible:=false;
        end;
     if (sender=btdm) or (sender=btim) or (sender=matriz) or (sender=btdg) or
        (sender=gauss) or (sender=btjac) or (sender=jacobi) then
             begin
                  frmzeros.Visible:=false;
                  frmsislin.Visible:=true;
                  frmlagr.Visible:=false;
                  frmajuste.Visible:=false;
                  frmintegra.Visible:=false;
                  if (sender=btdm)  or (sender=btim) or (sender=matriz) then
                     frmsislin.PCMatriz.ActivePage:=frmsislin.TSMatriz;
                  if (sender=btdg) or (sender=gauss) then
                     frmsislin.PCMatriz.ActivePage:=frmsislin.TSGauss;
                  if (sender=btjac) or (sender=jacobi) then
                     frmsislin.PCMatriz.ActivePage:=frmsislin.TSJacobi;
             end;
     if (sender=matrizi) or (sender=trapezio) or (sender=simpson13) or (sender=simpson38) or
        (sender=btbmat) or (sender=btbtra) or (sender=btbs13) or (sender=btbs38) then
        begin
             frmzeros.Visible:=false;
             frmsislin.Visible:=false;
             frmlagr.Visible:=false;
             frmajuste.Visible:=false;
             frmintegra.Visible:=true;
             if (sender=btbmat)  or (sender=matrizi) then
                frmintegra.PCInte.ActivePage:=frmintegra.TSMatriz;
             if (sender=btbtra) or (sender=trapezio) then
                frmintegra.PCinte.ActivePage:=frmintegra.TSTrap;
             if (sender=btbs13) or (sender=simpson13) then
                frmintegra.PCinte.ActivePage:=frmintegra.TS13;
             if (sender=btbs38) or (sender=simpson38) then
                frmintegra.PCinte.ActivePage:=frmintegra.TS38;
        end;
end;

procedure tfrmpri.limpa(grid:tstringgrid);
var
   a,b:byte;
begin
     for a:=0 to grid.ColCount-1 do
         for b:=1 to grid.RowCount-1 do
             grid.Cells[a,b]:='';
             grid.SetFocus;
             grid.col:=0;
             grid.row:=1;
end;

procedure TFrmpri.BTDMClick(Sender: TObject);
begin
     acao(sender);
     matriz.Enabled:=false;
end;

procedure TFrmpri.BTIMClick(Sender: TObject);
begin
     acao(sender);
     matriz.Enabled:=false;
end;

procedure TFrmpri.BTDGClick(Sender: TObject);
begin
     acao(sender);
     gauss.Enabled:=false;
end;

procedure TFrmpri.BTJacClick(Sender: TObject);
begin
     acao(sender);
     jacobi.Enabled:=false;
end;

procedure TFrmpri.btbiseClick(Sender: TObject);
begin
     acao(sender);
     biseccao.Enabled:=false;
end;

function tfrmpri.precisao(combo:Tcombobox):string;
var
   a,b:byte;
   res:string;
begin
     res:='';
     if (length(combo.Text)<= 2) then
        a:=1
     else
         a:=(length(combo.text)-2);
     for b:=1 to a do
         res:=res+'0';
     precisao:=res;
end;

procedure tfrmpri.mostramat(Grid:TstringGrid);
var
   col,lin,tam,max,k,Tam1,tam2:byte;
   textoentr,blank:string;
begin
     tam:=0;
     for lin:=0 to grid.RowCount-1 do
         for col:=0 to grid.ColCount-1 do
             begin
                  max:=length(grid.cells[col,lin]);
                  if tam<max then
                     tam:=max;
             end;
     for lin:=0 to grid.RowCount-1 do
         begin
              for col:=0 to grid.ColCount-1 do
                  begin
                       tam1:=length(grid.cells[col,lin]);
                       tam2:=tam-tam1;
                       if col<grid.ColCount-1 then
                          if tam1>=tam then
                             blank:='_'
                          else
                              for k:=0 to tam2 do
                                  blank:=blank+'_';
                       textoentr:=textoentr+grid.Cells[col,lin]+blank;
                       blank:='';
                  end;
              blank:='';
              memospace;
              frmpassos.Memopasso.Lines.Append(textoentr);
              textoentr:='';
         end;
end;

procedure tfrmpri.mostrapot(grid:tstringgrid);
var
   col,lin,tam,max,k,Tam1,tam2:byte;
   textoentr,blank:string;
begin
     tam:=0;
     for col:=0 to 1 do
         for lin:=0 to grid.RowCount-1 do
             begin
                  max:=length(grid.cells[col,lin]);
                  if tam<max then
                     tam:=max;
             end;
     for col:=0 to 1 do
         begin
              for lin:=0 to grid.rowcount-1 do
                  begin
                       tam1:=length(grid.cells[col,lin]);
                       tam2:=tam-tam1;
                       if lin<grid.rowcount-1 then
                          if tam1>=tam then
                             blank:='_'
                          else
                              for k:=0 to tam2 do
                                  blank:=blank+'_';
                       textoentr:=textoentr+grid.Cells[col,lin]+blank;
                       blank:='';
                  end;
              blank:='';
              memospace;
              frmpassos.Memopasso.Lines.Append(textoentr);
              textoentr:='';
         end;
end;

procedure tfrmpri.notimple;
begin
     messagedlg('Método não Implementado',mtinformation,[mbok],0);
end;

procedure TFrmpri.BitBtn1Click(Sender: TObject);
begin
     notimple;
end;

procedure TFrmpri.BTGSClick(Sender: TObject);
begin
     notimple;
end;

procedure TFrmpri.Pivotamento1Click(Sender: TObject);
begin
     notimple;
end;

procedure TFrmpri.GaussSeidel1Click(Sender: TObject);
begin
     notimple;
end;

procedure TFrmpri.voltarClick(Sender: TObject);
begin
     if frmsislin.Active then
        begin
             frmsislin.Visible:=false;
             frmsislin.MnuSislin.Unmerge(mnupri);
        end;
     if frmzeros.active then
        begin
             frmzeros.Visible:=false;
             frmzeros.mnuzeros.Unmerge(mnupri);
        end;
     voltar.Visible:=false;
     Matriz.Enabled:=true;
     Gauss.Enabled:=true;
     Jacobi.Enabled:=true;
     biseccao.Enabled:=true;
     frmpri.Visible:=true;
end;

procedure TFrmpri.MatrizClick(Sender: TObject);
begin
     acao(sender);
     matriz.Enabled:=false;
     gauss.Enabled:=true;
     jacobi.Enabled:=true;
end;

procedure TFrmpri.GaussClick(Sender: TObject);
begin
     acao(sender);
     gauss.Enabled:=false;
     matriz.Enabled:=true;
     jacobi.Enabled:=true;
end;

procedure TFrmpri.JacobiClick(Sender: TObject);
begin
     acao(sender);
     jacobi.Enabled:=false;
     matriz.Enabled:=true;
     gauss.Enabled:=true;
end;

procedure TFrmpri.BiseccaoClick(Sender: TObject);
begin
     acao(sender);
     biseccao.Enabled:=false;
end;

procedure TFrmpri.NewtonRaphson1Click(Sender: TObject);
begin
     notimple;
end;

procedure TFrmpri.Sair2Click(Sender: TObject);
begin
     frmpri.Close;     
end;

procedure TFrmpri.FormActivate(Sender: TObject);
begin
     Matriz.Enabled:=true;
     Gauss.Enabled:=true;
     Jacobi.Enabled:=true;
     biseccao.Enabled:=true;
     lagrange.Enabled:=true;
     ajuste.Enabled:=true;
     MatrizI.Enabled:=true;
     Trapezio.Enabled:=true;
     Simpson13.Enabled:=true;
     Simpson38.Enabled:=true;
     voltar.Visible:=false;
     salvar1.Enabled:=false;
end;

procedure TFrmpri.Sobre1Click(Sender: TObject);
begin
     sobre.show;
end;

procedure TFrmpri.Ajuda2Click(Sender: TObject);
begin
     application.HelpCommand(Help_contents,0);
end;

procedure TFrmpri.BtbnewClick(Sender: TObject);
begin
     acao(sender);
     newton.Enabled:=false;
end;

procedure TFrmpri.btblagrClick(Sender: TObject);
begin
     acao(sender);
     lagrange.Enabled:=false;
end;

procedure TFrmpri.NewtonClick(Sender: TObject);
begin
     acao(sender);
     newton.Enabled:=false;
     lagrange.Enabled:=true;
end;

procedure TFrmpri.LagrangeClick(Sender: TObject);
begin
     acao(sender);
     lagrange.Enabled:=false;
     newton.Enabled:=true;
     
end;

procedure TFrmpri.btbajClick(Sender: TObject);
begin
     acao(sender);
     ajuste.Enabled:=false;
end;

procedure TFrmpri.ajusteClick(Sender: TObject);
begin
     acao(sender);
     ajuste.Enabled:=false;
end;

procedure TFrmpri.MatrizIClick(Sender: TObject);
begin
     acao(sender);
     matrizi.Enabled:=false;
     trapezio.Enabled:=true;
     simpson13.Enabled:=true;
     simpson38.Enabled:=true;
end;

procedure TFrmpri.Simpson13Click(Sender: TObject);
begin
     acao(sender);
     matrizi.Enabled:=true;
     trapezio.Enabled:=true;
     simpson13.Enabled:=false;
     simpson38.Enabled:=true;
end;

procedure TFrmpri.TrapezioClick(Sender: TObject);
begin
     acao(sender);
     matrizi.Enabled:=true;
     trapezio.Enabled:=false;
     simpson13.Enabled:=true;
     simpson38.Enabled:=true;
end;

procedure TFrmpri.Simpson38Click(Sender: TObject);
begin
     acao(sender);
     matrizi.Enabled:=true;
     trapezio.Enabled:=true;
     simpson13.Enabled:=true;
     simpson38.Enabled:=false;
end;

procedure TFrmpri.btbmatClick(Sender: TObject);
begin
     acao(sender);
     matrizi.Enabled:=false;
end;

procedure TFrmpri.btbtraClick(Sender: TObject);
begin
     acao(sender);
     trapezio.Enabled:=false;
end;

procedure TFrmpri.btbs13Click(Sender: TObject);
begin
     acao(sender);
     simpson13.Enabled:=false;
end;

procedure TFrmpri.btbs38Click(Sender: TObject);
begin
     acao(sender);
     simpson38.Enabled:=false;
end;

procedure TFrmpri.Salvar1Click(Sender: TObject);
begin
     if frmsislin.Active then
        begin
             if frmsislin.PCMatriz.ActivePage=frmsislin.TSMatriz then
                save(frmsislin.sgm,1);
             if frmsislin.PCMatriz.ActivePage=frmsislin.TSGauss then
                save(frmsislin.sgeg,2);
             if frmsislin.PCMatriz.ActivePage=frmsislin.TSJacobi then
                save(frmsislin.SGEJ,3);
        end;
     if frmzeros.Active then
        save(frmzeros.SGEq,4);
     if frmlagr.active then
        begin
             if frmlagr.PCinter.ActivePage=frmlagr.TSLagr then
                save(frmlagr.Sgp,5);
             if frmlagr.PCinter.ActivePage=frmlagr.TSnew then
                save(frmlagr.SGPn,11);
        end;
     if frmajuste.Active then
        save(frmajuste.sgp,6);
     if frmintegra.Active then
        begin
             if frmintegra.PCInte.ActivePage=frmintegra.TSMatriz then
                save(frmintegra.sgp,7);
             if frmintegra.PCInte.ActivePage=frmintegra.TSTrap then
                save(frmintegra.sgtp,8);
             if frmintegra.PCInte.ActivePage=frmintegra.TS13 then
                save(frmintegra.sgs13,9);
             if frmintegra.PCInte.ActivePage=frmintegra.TS38 then
                save(frmintegra.sgs38,10);
        end;
end;



procedure TFrmpri.Abrir1Click(Sender: TObject);
var
   fl:textfile;
   arq,blank:string;
   col,lin,tam,cont:byte;
begin
     try
        begin
             if odpri.Execute then
                begin
                     assignfile(fl,odpri.FileName);
                     reset(fl);
                     readln(fl,arq);
                     frmpri.Visible:=false;
                     if arq='m' then
                        begin

                             frmsislin.Visible:=true;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=false;
                             frmsislin.PCMatriz.ActivePage:=frmsislin.TSMatriz;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmsislin.sgm.ColCount:=tam;
                             frmsislin.sgm.rowcount:=tam;
                             frmsislin.colocalabels(1);
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmsislin.sgm.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmsislin.sgm.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmsislin.BtbMg.Enabled:=true;
                             frmsislin.btbmj.Enabled:=true;
                             frmsislin.btbml.Enabled:=true;
                        end;
                     if arq='g' then
                        begin
                             frmsislin.Visible:=true;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=false;
                             frmsislin.PCMatriz.ActivePage:=frmsislin.TSGauss;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmsislin.sgeg.ColCount:=tam;
                             frmsislin.sgeg.RowCount:=tam;
                             frmsislin.sgpg.ColCount:=tam;
                             frmsislin.sgpg.Rowcount:=tam;
                             frmsislin.sgrg.ColCount:=tam-1;
                             frmsislin.colocalabels(2);
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmsislin.sgeg.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmsislin.sgeg.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmsislin.btbcg.Enabled:=true;
                             frmsislin.btbpg.Enabled:=true;
                             frmsislin.btblg.Enabled:=true;
                        end;
                     if arq='j' then
                        begin
                             frmsislin.Visible:=true;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=false;
                             frmsislin.PCMatriz.ActivePage:=frmsislin.TSJacobi;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmsislin.sgej.ColCount:=tam;
                             frmsislin.sgej.RowCount:=tam;
                             frmsislin.sgpj.ColCount:=tam;
                             frmsislin.sgpj.Rowcount:=tam;
                             frmsislin.SGIJ.RowCount:=tam;
                             frmsislin.SGIJ.ColCount:=tam+1;
                             frmsislin.sgrj.ColCount:=tam-1;
                             frmsislin.colocalabels(3);
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmsislin.sgej.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmsislin.sgej.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmsislin.btbcj.Enabled:=true;
                             frmsislin.btbpj.Enabled:=true;
                             frmsislin.btblj.Enabled:=true;
                        end;
                     if arq='b' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=true;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=false;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmzeros.SGEq.ColCount:=tam;
                             frmzeros.labels;
                             readln(fl,arq);
                             blank:='';
                             col:=0;
                             cont:=1;
                             while cont<= length(arq) do
                                   begin
                                        if arq[cont]<>'*' then
                                           blank:=blank+arq[cont]
                                        else
                                            begin
                                                 frmzeros.SGEq.Cells[col,1]:=blank;
                                                 col:=col+1;
                                                 blank:='';
                                            end;
                                        cont:=cont+1;
                                   end;
                             frmzeros.SGEq.Cells[col,1]:=blank;
                             frmzeros.btcb.Enabled:=true;
                             frmzeros.btbl.Enabled:=true;
                             frmzeros.btpb.Enabled:=true;
                        end;
                     if arq='l' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=true;
                             frmlagr.PCinter.ActivePage:=frmlagr.TSLagr;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=false;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmlagr.Sgp.RowCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmlagr.Sgp.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmlagr.sgp.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmlagr.btbCal.Enabled:=true;
                             frmlagr.btblimp.Enabled:=true;
                             frmlagr.btbstep.Enabled:=true;
                        end;
                     if arq='n' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=true;
                             frmlagr.PCinter.ActivePage:=frmlagr.TSnew;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=false;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmlagr.Sgpn.RowCount:=tam;
                             frmlagr.Sgc.RowCount:=tam;
                             frmlagr.Sgc.ColCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmlagr.Sgpn.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmlagr.sgpn.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmlagr.btbnc.Enabled:=true;
                             frmlagr.btbnl.Enabled:=true;
                             
                        end;
                     if arq='a' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=true;
                             frmintegra.Visible:=false;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmajuste.Sgp.RowCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmajuste.Sgp.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmajuste.sgp.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmajuste.btbret.Enabled:=true;
                             frmajuste.btbquad.Enabled:=true;
                             frmajuste.btbcub.Enabled:=true;
                             frmajuste.btblimp.Enabled:=true;
                        end;
                     if arq='i' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=true;
                             frmintegra.PCInte.ActivePage:=frmintegra.TSMatriz;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmintegra.sgp.RowCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmintegra.Sgp.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmintegra.sgp.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmintegra.btbtrap.Enabled:=true;
                             frmintegra.btb13.Enabled:=true;
                             frmintegra.btb38.Enabled:=true;
                             frmintegra.btblimp.Enabled:=true;
                        end;
                     if arq='t' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=true;
                             frmintegra.PCInte.ActivePage:=frmintegra.TSTrap;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmintegra.sgtp.RowCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmintegra.Sgtp.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmintegra.sgtp.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmintegra.btbcalc.Enabled:=true;
                             frmintegra.btbstep.Enabled:=true;
                             frmintegra.btbclean.Enabled:=true;
                        end;
                     if arq='13' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=true;
                             frmintegra.PCInte.ActivePage:=frmintegra.TS13;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmintegra.sgs13.RowCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmintegra.Sgs13.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmintegra.sgs13.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmintegra.btbs13.Enabled:=true;
                             frmintegra.btbp13.Enabled:=true;
                             frmintegra.btbl13.Enabled:=true;
                        end;
                     if arq='38' then
                        begin
                             frmsislin.Visible:=false;
                             frmzeros.visible:=false;
                             frmlagr.Visible:=false;
                             frmajuste.Visible:=false;
                             frmintegra.Visible:=true;
                             frmintegra.PCInte.ActivePage:=frmintegra.TS38;
                             readln(fl,arq);
                             tam:=strtoint(arq);
                             frmintegra.sgs38.RowCount:=tam;
                             lin:=1;
                             while not eof(fl) do
                                   begin
                                        readln(fl,arq);
                                        blank:='';
                                        col:=0;
                                        cont:=1;
                                        while cont<= length(arq) do
                                              begin
                                                   if arq[cont]<>'*' then
                                                      blank:=blank+arq[cont]
                                                   else
                                                       begin
                                                            frmintegra.Sgs38.Cells[col,lin]:=blank;
                                                            col:=col+1;
                                                            blank:='';
                                                       end;
                                                   cont:=cont+1;
                                              end;
                                        frmintegra.sgs38.Cells[col,lin]:=blank;
                                        lin:=lin+1;
                                   end;
                             frmintegra.btbs38.Enabled:=true;
                             frmintegra.btbp38.Enabled:=true;
                             frmintegra.btbl38.Enabled:=true;
                        end;
                end;
             end;
        except
              on EInOutError do
                 messagedlg('Error ao abrir o arquivo',mterror,[mbok],0);
        end;
end;

end.
