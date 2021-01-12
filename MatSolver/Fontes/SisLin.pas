unit SisLin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,olectrls, Grids, StdCtrls, Buttons, Menus;

type
  TFrmSisLin = class(TForm)
    PCMatriz: TPageControl;
    TSMatriz: TTabSheet;
    TSGauss: TTabSheet;
    GBEntr: TGroupBox;
    sgeg: TStringGrid;
    GBPasso: TGroupBox;
    sgpg: TStringGrid;
    tbg: TTrackBar;
    GBresultado: TGroupBox;
    sgrg: TStringGrid;
    btblg: TBitBtn;
    btbcg: TBitBtn;
    btbsg: TBitBtn;
    btbpg: TBitBtn;
    TSJacobi: TTabSheet;
    GroupBox1: TGroupBox;
    SGEJ: TStringGrid;
    GroupBox2: TGroupBox;
    SGPJ: TStringGrid;
    GroupBox3: TGroupBox;
    SGIJ: TStringGrid;
    GroupBox4: TGroupBox;
    lbint: TLabel;
    lberr: TLabel;
    sgrj: TStringGrid;
    btblj: TBitBtn;
    btbsj: TBitBtn;
    GroupBox5: TGroupBox;
    btbmj: TBitBtn;
    BtbMg: TBitBtn;
    MnuSislin: TMainMenu;
    GroupBox6: TGroupBox;
    tbj: TTrackBar;
    GroupBox7: TGroupBox;
    cberr: TComboBox;
    GroupBox8: TGroupBox;
    cbint: TComboBox;
    btbcj: TBitBtn;
    btbpj: TBitBtn;
    GroupBox9: TGroupBox;
    sgm: TStringGrid;
    tbm: TTrackBar;
    GroupBox10: TGroupBox;
    btbms: TBitBtn;
    btbml: TBitBtn;
    GroupBox11: TGroupBox;
    lbj: TLabel;
    lbg: TLabel;
    GroupBox12: TGroupBox;
    lbm: TLabel;
    procedure tbmChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btbmlClick(Sender: TObject);
    procedure PCMatrizChange(Sender: TObject);
    procedure btbcgClick(Sender: TObject);
    procedure btblgClick(Sender: TObject);
    procedure btbsgClick(Sender: TObject);
    procedure tbgChange(Sender: TObject);
    procedure BtbMgClick(Sender: TObject);
    procedure btbpgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbjChange(Sender: TObject);
    procedure cberrChange(Sender: TObject);
    procedure btbljClick(Sender: TObject);
    procedure sgmKeyPress(Sender: TObject; var Key: Char);
    procedure btbsjClick(Sender: TObject);
    procedure sgegKeyPress(Sender: TObject; var Key: Char);
    procedure SGEJKeyPress(Sender: TObject; var Key: Char);
    procedure btbcjClick(Sender: TObject);
    procedure cbintChange(Sender: TObject);
    procedure btblijClick(Sender: TObject);
    procedure cberrKeyPress(Sender: TObject; var Key: Char);
    procedure cbintKeyPress(Sender: TObject; var Key: Char);
    procedure btbmjClick(Sender: TObject);
    procedure btbpjClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btbmsClick(Sender: TObject);
    procedure sgmClick(Sender: TObject);
    procedure SGEJClick(Sender: TObject);
    procedure sgegClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure matriz(var L:Tlabel;g:TstringGrid); // mostra tamanho da matriz no label
    //procedure colocalabels(met:byte); // coloca rotulos na stringgrid
    procedure CopiaMatriz; // Copia a stringgrid do menu matriz para a matriz entrada
    procedure tstlin;// teste de linhas para Jacobi
    procedure CJacobi; // calcula jacobi
    procedure Ejacobi(linha:byte); // calcula o erro
    procedure tstVJ; //verifica se tem valor na sgij
    procedure inij; // inicia o calculo por jacobi
    procedure finalJ(x:byte); // mostra resultado jacobi
    procedure verimat; // verifica matriz se vazia para habilitar botao limpar
    procedure mostrini; // mostra o inicio de Gauss
  public
    { Public declarations }
    procedure TamMatriz(pos:byte); // altera o tamanho das matrizes
    procedure colocalabels(met:byte); // coloca rotulos na stringgrid
  end;

var
  FrmSisLin: TFrmSisLin;
  formulario:TTabSheet;
  jac,tst:boolean;
  linhaant:byte;

implementation

{$R *.DFM}

uses step,princ;

procedure tfrmsislin.matriz(var L:Tlabel;g:Tstringgrid);
begin
     l.Caption:=inttostr(g.colcount-1)+' X '+inttostr(g.ColCount-1);
end;

procedure Tfrmsislin.TamMatriz(pos:byte);
begin
     case pos of
          1:begin
                 sgm.ColCount:=tbm.Position;
                 sgm.rowcount:=tbm.Position;
             end;
          2:begin
                 sgeg.ColCount:=tbg.Position;
                 sgeg.RowCount:=tbg.Position;
                 sgpg.ColCount:=tbg.Position;
                 sgpg.RowCount:=tbg.Position;
                 sgrg.ColCount:=tbg.Position-1;
             end;
          3:begin
                 sgej.ColCount:=tbj.Position;
                 sgpj.ColCount:=tbj.Position;
                 sgej.RowCount:=tbj.Position;
                 sgpj.RowCount:=tbj.Position;
                 sgrj.ColCount:=tbj.Position-1;
                 sgij.ColCount:=tbj.Position+1;
             end;
     end;
end;

procedure Tfrmsislin.colocalabels(met:byte);
const l=0;
      res='=';
var
   c,d:byte;
begin
     case met of
          1:begin
                 for c:=0 to sgm.ColCount-1 do
                     if c<=2 then
                        sgm.Cells[c,l]:=chr(c+88)
                     else
                         sgm.Cells[c,l]:=chr(90-c);
          end;
          2:begin
                 for c:=0 to sgeg.ColCount-1 do
                     if c<=2 then
                        begin
                             sgeg.Cells[c,l]:=chr(c+88);
                             sgpg.Cells[c,l]:=chr(c+88);
                        end
                     else
                         begin
                              sgeg.Cells[c,l]:=chr(90-c);
                              sgpg.Cells[c,l]:=chr(90-c);
                         end;
                 for d:=0 to sgrg.ColCount do
                     if d<=2 then
                        sgrg.Cells[d,l]:=chr(d+88)
                     else
                         sgrg.Cells[d,l]:=chr(90-d);
          end;
          3:begin
                 for c:=0 to sgej.ColCount-1 do
                     if c<=2 then
                        begin
                             sgej.Cells[c,l]:=chr(c+88);
                             sgpj.Cells[c,l]:=chr(c+88);
                             sgij.Cells[c+1,l]:=chr(c+88);
                        end
                     else
                         begin
                              sgej.Cells[c,l]:=chr(90-c);
                              sgpj.Cells[c,l]:=chr(90-c);
                              sgij.Cells[c+1,l]:=chr(90-c);
                         end;
                 for d:=0 to sgrj.ColCount do
                     if d<=2 then
                        sgrj.Cells[d,l]:=chr(d+88)
                     else
                         sgrj.Cells[d,l]:=chr(90-d);
          end;
     end;
     sgeg.Cells[sgeg.ColCount-1,l]:=res;
     sgpg.Cells[sgpg.ColCount-1,l]:=res;
     sgm.Cells[sgm.ColCount-1,l]:=res;
     sgej.Cells[sgej.ColCount-1,l]:=res;
     sgpj.Cells[sgpj.ColCount-1,l]:=res;
     cberr.text:=cberr.items.strings[3];
     sgij.Cells[sgij.ColCount-1,l]:='E<='+cberr.Text;
     cbint.Text:=cbint.Items.Strings[4];
     sgij.cells[0,0]:='Int.= '+cbint.text;
end;

procedure tfrmSisLin.CopiaMatriz;
var
   i,j:byte;
begin
     for i:=1 to sgm.rowcount-1 do
         for j:=0 to sgm.ColCount-1 do
             begin
                  sgeg.Cells[j,i]:=sgm.Cells[j,i];
                  sgej.Cells[j,i]:=sgm.cells[j,i];
             end;
end;

procedure tfrmsislin.mostrini;
begin
     frmpassos.Memopasso.Clear;
     frmpri.tracejado;
     frmpassos.Memopasso.Lines.Append('Método de Gauss');
     frmpri.tracejado;
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Matriz de Entrada');
     frmpri.mostramat(sgeg);
     frmpri.tracejado;
end;

procedure tfrmsislin.tstlin;
var
   A:array [1..10] of byte;
   col,lin,k,j,pos:byte;
   M,t:real;
   v:boolean;
   mp,tp:string;
begin
     tst:=true;
     v:=false;
     t:=0;
     frmpri.tracejado;
     frmpassos.memopasso.lines.append('Método de Jacobi -- Passo-a-Passo');
     frmpri.tracejado;
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Matriz de Entrada');
     frmpri.memospace;
     frmpri.mostramat(sgej);
     frmpri.memospace;
     for k:=1 to 10 do
         A[k]:=0;
     for lin:=1 to sgej.rowcount-1 do
         begin
              for col:=0 to sgej.colcount-2 do
                  begin
                       if not v then
                          if sgej.Cells[col,lin]<>'0' then
                             begin
                                  mp:=sgej.Cells[col,lin];
                                  coluna:=col;
                                  linha:=lin;
                                  m:=strtofloat(sgej.Cells[col,lin]);
                                  for k:=0 to sgej.ColCount-2 do
                                      begin
                                           Tp:=Tp+' + '+sgej.Cells[k,lin];
                                           coluna:=k;
                                           T:=T+strtofloat(sgej.Cells[k,lin]);
                                      end;
                                  t:=(t-m)/m;
                                  tp:=tp+' - '+mp+' / '+mp+' = '+formatfloat('0.00',abs(t))+' <=1? para a linha: '+inttostr(col+1);
                                  frmpri.memospace;
                                  frmpassos.Memopasso.Lines.Append(Tp);
                                  frmpri.memospace;
                                  if (abs(t)<=1) then
                                     begin
                                          A[lin]:=col+1;
                                          frmpri.memospace;
                                          frmpassos.Memopasso.Lines.Append('Equação '+inttostr(lin)+' para a linha '+inttostr(col+1));
                                          frmpri.memospace;
                                          v:=true;
                                     end;
                                  t:=0;
                                  tp:='';
                             end;
                  end;
            v:=false;
            if a[lin]=0 then
               a[lin]:=lin;
         end;
     for k:=1 to sgej.ColCount-1 do
         begin
              pos:=A[k];
              for j:=k+1 to sgej.ColCount-1 do
                  if tst then
                     if a[j]=pos then
                        begin
                             frmpri.memospace;
                             messagedlg('O sistema não converge',mterror,[mbok],0);
                             tst:=false;
                             frmpassos.Memopasso.Lines.Append('Sistema não converge');
                        end;
         end;
     if tst then
        begin
             for lin:=1 to sgej.RowCount-1 do
                 for col:=0 to sgej.ColCount-1 do
                     sgpj.Cells[col,A[lin]]:=sgej.Cells[col,lin];
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Matriz Equacionada');
             frmpri.memospace;
             frmpri.mostramat(sgpj);
             frmpri.memospace;
        end;
end;

procedure tfrmsislin.tstVJ;
const
     l=1;
var
   z:byte;
begin
     for z:=1 to sgij.ColCount-2 do
         if (sgij.Cells[z,l]='') then
            sgij.Cells[z,l]:='0';
     sgij.Cells[0,l]:='1';
     sgij.Cells[sgij.colcount-1,l]:='-----';
end;

procedure tfrmsislin.CJacobi;
var
   lin,col,A,fin:byte;
   Res,eq,P,m:real;
   fim:boolean;
   Rs,eqs,ms,ps,ic,it:string;
begin
     res:=0;
     fin:=0;
     fim:=false;
     for lin:=2 to strtoint(cbint.Text) do
         begin
              if not fim then
                 begin
                      for col:=1 to sgpj.ColCount-1 do
                          begin
                               sgij.Cells[0,lin]:=inttostr(lin);
                               linha:=col;
                               coluna:=col-1;
                               m:=strtofloat(sgpj.cells[col-1,col]);
                               ms:=sgpj.cells[col-1,col];
                               coluna:=sgpj.colcount-1;
                               eq:=strtofloat(sgpj.Cells[sgpj.colcount-1,col]);
                               eqs:=sgpj.cells[sgpj.colcount-1,col];
                               for a:=0 to sgpj.ColCount-2 do
                                   if (a+1 <> col) then
                                      begin
                                           res:=res-((strtofloat(sgpj.cells[a,col]))*(strtofloat(sgij.cells[a+1,lin-1])));
                                           rs:=rs+' - '+sgpj.cells[a,col]+' * '+sgij.cells[a+1,lin-1];
                                      end;
                               p:=((eq+res)/m);
                               it:=sgij.cells[0,lin];
                               ic:=sgij.cells[col,0];
                               ps:=it+' => '+ic+' = '+eqs+' + '+rs+' / '+ms+' = '+formatfloat('0.'+frmpri.precisao(cberr),p);
                               sgij.cells[col,lin]:=formatfloat('0.'+frmpri.precisao(cberr),p);
                               frmpri.memospace;
                               frmpassos.Memopasso.Lines.Append(ps);
                               frmpri.memospace;
                               rs:='';
                               res:=0;
                          end;
                      fin:=lin;
                      ejacobi(lin);
                      if (strtofloat(sgij.Cells[sgij.colcount-1,lin])<=strtofloat(cberr.text)) or (strtoint(sgij.Cells[0,lin])>=(strtoint(cbint.text))) then
                         fim:=true;
                 end;
         end;
     finalj(fin);
end;

procedure tfrmsislin.finalJ(x:byte);
var
   a:byte;
begin
     for a:=0 to sgrj.ColCount-1 do
         sgrj.Cells[a,1]:=sgij.Cells[a+1,x];
     lbint.Caption:='Interações: '+inttostr(x);
     lberr.Caption:='Erro: '+sgij.Cells[sgij.colcount-1,x];
     frmpri.memospace;
     frmpri.tracejado;
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Resultado das Interações');
     frmpri.memospace;
     frmpri.mostramat(sgij);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Resultado Final');
     frmpri.memospace;
     frmpri.mostramat(sgrj);
end;

procedure tfrmsislin.Ejacobi(linha:byte);
var
   col,c,l:byte;
   a,b,d,e,f,columm,res:real;
   es,cs,bs:string;
begin
     c:=0;
     l:=0;
     f:=0;
     for col:=1 to sgij.ColCount-2 do
         begin
              a:=abs(strtofloat(sgij.cells[col,linha]));
              d:=abs(strtofloat(sgij.cells[col,linha-1]));
              e:=abs(a-d);
              if e>f then
                 begin
                      l:=linha;
                      c:=col;
                      f:=e;
                 end;
         end;
     b:=abs(strtofloat(sgij.Cells[c,l]));
     bs:=formatfloat('0.'+frmpri.precisao(cberr),b);
     columm:=abs(strtofloat(sgij.Cells[c,l-1]));
     cs:=formatfloat('0.'+frmpri.precisao(cberr),columm);
     res:=abs(columm-b);
     es:='Erro: '+cs+' - '+bs+' = '+formatfloat('0.'+frmpri.precisao(cberr),res);
     sgij.Cells[sgij.ColCount-1,linha]:=formatfloat('0.'+frmpri.precisao(cberr),res);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append(es);
     frmpri.memospace;
     frmpri.tracejado;
end;

procedure TFrmSisLin.tbmChange(Sender: TObject);
begin
     tammatriz(1);
     matriz(lbm,sgm);
     colocalabels(1);
end;

procedure TFrmSisLin.FormActivate(Sender: TObject);
begin
     frmpri.voltar.visible:=true;
     frmpri.Salvar1.Enabled:=true;
     frmpri.Biseccao.Enabled:=true;
     frmpri.Lagrange.Enabled:=true;
     frmpri.ajuste.Enabled:=true;
     frmpri.MatrizI.Enabled:=true;
     frmpri.Trapezio.Enabled:=true;
     frmpri.Simpson13.Enabled:=true;
     frmpri.Simpson38.Enabled:=true;
     mnusislin.Merge(frmpri.mnupri);
     colocalabels(1);
     colocalabels(2);
     colocalabels(3);
     PCMatriz.ActivePage:=formulario;
     matriz(lbm,sgm);
     verimat;
end;

procedure TFrmSisLin.btbmlClick(Sender: TObject);
begin
     frmpri.limpa(sgm);
     btbml.Enabled:=false;
     frmpri.Matriz.Enabled:=false;
     frmpri.Gauss.Enabled:=true;
     frmpri.Jacobi.Enabled:=true;
end;

procedure TFrmSisLin.PCMatrizChange(Sender: TObject);
begin
     if pcmatriz.ActivePage=TSGauss then
        begin
             frmpri.Matriz.Enabled:=true;
             frmpri.Jacobi.Enabled:=true;
             frmpri.Gauss.Enabled:=false;
             sgpg.ColCount:=sgm.ColCount;
             sgpg.RowCount:=sgm.RowCount;
             frmpri.copiamat(sgeg,sgm);
             sgrg.ColCount:=sgm.ColCount-1;
             matriz(lbg,sgpg);
             colocalabels(2);
        end;
     if pcmatriz.ActivePage=TSJacobi then
        begin
             frmpri.Matriz.Enabled:=true;
             frmpri.Jacobi.Enabled:=false;
             frmpri.Gauss.Enabled:=true;
             sgpj.ColCount:=sgm.ColCount;
             sgpj.RowCount:=sgm.RowCount;
             sgrj.ColCount:=sgm.ColCount-1;
             sgij.ColCount:=sgm.colcount+1;
             frmpri.copiamat(sgej,sgm);
             matriz(lbj,sgpj);
             colocalabels(3);
             cberr.Text:=cberr.Items.Strings[3];
             cbint.Text:=cbint.Items.Strings[4];
             sgij.Cells[0,0]:='Int.= '+cbint.Text;
             sgij.Cells[sgij.ColCount-1,0]:='E<='+cberr.text;
             sgij.rowcount:=strtoint(cbint.text)+1;
        end;
     if pcmatriz.ActivePage=TSMatriz then
        begin
             frmpri.Matriz.Enabled:=false;
             frmpri.Jacobi.Enabled:=true;
             frmpri.Gauss.Enabled:=true;
             matriz(lbm,sgm);
        end;
     copiamatriz;
     verimat;
end;

procedure TFrmSisLin.btbcgClick(Sender: TObject);
var
   x,y:byte;
begin
     frmpassos.Memopasso.Clear;
     try
        begin
             mostrini;
             for x:=1 to sgeg.RowCount-1 do
                 for y:=0 to sgeg.ColCount-1 do
                     sgpg.Cells[y,x]:=sgeg.Cells[y,x];
             sgpg:=frmpri.CalcGauss(sgpg,1);
             frmpri.Coeficientes(sgrg,sgpg);
             btbpg.Enabled:=true;
             btbcg.Enabled:=false;
             tbg.Enabled:=false;
        end;
     except
           on EDivByZero do
              messagedlg('Divisão por Zero, verifique se os valores estão corretos.',mterror,[mbok],0);
           on EZeroDivide do
              begin
                   messagedlg('Divisão por zero, verifique se os valores estão corretos.',mterror,[mbok],0);
                   sgeg.col:=coluna;
                   sgeg.row:=linha;
              end;
           on EInvalidOp do
              messagedlg('Matriz mal dimensionada, confira os valores.',mterror,[mbok],0);
           on EConvertError do
              begin
                   Messagedlg('Caracteres inválidos encontrado',mterror,[mbok],0);
                   sgeg.col:=coluna;
                   sgeg.row:=linha;
              end;
     end;
end;

procedure TFrmSisLin.btblgClick(Sender: TObject);
begin
     frmpri.limpa(sgeg);
     frmpri.limpa(sgpg);
     frmpri.limpa(sgrg);
     btblg.Enabled:=false;
     btbcg.Enabled:=false;
     btbpg.Enabled:=false;
     tbg.Enabled:=true;
end;

procedure tfrmsislin.verimat;
var
   a,b:byte;
begin
     if pcmatriz.ActivePage=tsgauss then
        for a:=1 to sgeg.Rowcount-1 do
            for b:=0 to sgeg.ColCount-1 do
                if sgeg.Cells[b,a]='' then
                   btblg.Enabled:=false
                else
                    begin
                         btblg.Enabled:=true;
                         btbcg.Enabled:=true;
                    end;
     if pcmatriz.ActivePage=tsjacobi then
        for a:=1 to sgej.Rowcount-1 do
            for b:=0 to sgej.ColCount-1 do
                if sgej.Cells[b,a]='' then
                   btblj.Enabled:=false
                else
                    begin
                         btblj.Enabled:=true;
                         btbcj.Enabled:=true;
                    end;
end;

procedure TFrmSisLin.btbsgClick(Sender: TObject);
begin
     frmpri.limpa(sgeg);
     frmpri.limpa(sgpg);
     frmpri.limpa(sgrg);
     frmpri.Visible:=true;
     frmsislin.visible:=false;
end;

procedure TFrmSisLin.tbgChange(Sender: TObject);
begin
     tammatriz(2);
     matriz(lbg,sgeg);
     colocalabels(2);
end;

procedure TFrmSisLin.BtbMgClick(Sender: TObject);
var
   x,y:byte;
begin
     frmpassos.Memopasso.Clear;
     try
        begin
             frmpri.Matriz.Enabled:=true;
             frmpri.Gauss.Enabled:=false;
             frmpri.Jacobi.Enabled:=true;
             pcmatriz.activepage:=tsgauss;
             sgeg.ColCount:=sgm.ColCount;
             sgeg.RowCount:=sgm.RowCount;
             sgpg.ColCount:=sgm.ColCount;
             sgpg.RowCount:=sgm.ColCount;
             sgrg.ColCount:=sgm.ColCount-1;
             matriz(lbg,sgeg);
             colocalabels(2);
             copiamatriz;
             mostrini;
             for x:=1 to sgeg.RowCount-1 do
                 for y:=0 to sgeg.colcount-1 do
                     sgpg.Cells[y,x]:=sgeg.Cells[y,x];
             sgpg:=frmpri.CalcGauss(sgpg,1);
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Isolando os coeficientes');
             frmpri.memospace;
             frmpri.Coeficientes(sgrg,sgpg);
             btbpg.Enabled:=true;
             btblg.Enabled:=true;
        end;
     except
           on EDivByZero do
              messagedlg('Divisão por Zero, verifique se os valores estão corretos.',mterror,[mbok],0);
           on EZeroDivide do
              messagedlg('Divisão por zero, verifique se os valores estão corretos.',mterror,[mbok],0);
           on EInvalidOp do
              messagedlg('Matriz mal dimensionada, confira os valores.',mterror,[mbok],0);
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbok],0);
                   sgeg.Col:=coluna;
                   sgeg.row:=linha;
              end;
     end;
end;

procedure TFrmSisLin.btbpgClick(Sender: TObject);
begin
     formulario:=PCmatriz.ActivePage;
     frmpassos.Show;
end;

procedure TFrmSisLin.FormCreate(Sender: TObject);
begin
     formulario:=TSMatriz;
end;

procedure TFrmSisLin.tbjChange(Sender: TObject);
begin
     tammatriz(3);
     matriz(lbj,sgej);
     colocalabels(3);
end;

procedure TFrmSisLin.cberrChange(Sender: TObject);
begin
     sgij.Cells[sgij.ColCount-1,0]:='E<='+cberr.text;
end;

procedure TFrmSisLin.btbljClick(Sender: TObject);
begin
     if messagedlg('Deseja limpar todas as tabelas, clique em [all]'+chr(10)+chr(13)+'Caso queira limpar as interações, clique em [No]',mtinformation,[mbAll,mbNo],0)=mrAll then
        begin
             frmpri.limpa(sgej);
             frmpri.limpa(sgpj);
        end;
     frmpri.limpa(sgrj);
     frmpri.limpa(sgij);
     lbint.Caption:='Interações:';
     lberr.Caption:='Erro:';
     btblj.Enabled:=false;
     btbcj.Enabled:=false;
     btbpj.Enabled:=false;
     tbj.Enabled:=true;
end;

procedure TFrmSisLin.sgmKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure TFrmSisLin.btbsjClick(Sender: TObject);
begin
     frmpri.limpa(sgej);
     frmpri.limpa(sgpj);
     frmpri.limpa(sgrj);
     frmpri.limpa(sgij);
     frmsislin.Visible:=false;
     frmpri.Visible:=true;
end;

procedure TFrmSisLin.sgegKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure TFrmSisLin.SGEJKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', '-', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure TFrmSisLin.btbcjClick(Sender: TObject);
begin
     frmpassos.Memopasso.Clear;
     try
        begin
             inij;
             tstlin;
             if tst then
                begin
                     tstvj;
                     cjacobi;
                end;
             btbpj.Enabled:=true;
             btbcj.Enabled:=false;
             tbj.Enabled:=false;
        end;
     except
           on EDivByZero do
              messagedlg('Divisão por Zero, verifique se os valores estão corretos.',mterror,[mbok],0);
           on EZeroDivide do
              messagedlg('Divisão por zero, verifique se os valores estão corretos.',mterror,[mbok],0);
           on EInvalidOp do
              messagedlg('Matriz mal dimensionada, confira os valores.',mterror,[mbok],0);
           on EConvertError do
              begin
                   lbint.Caption:='Interações:';
                   lberr.Caption:='Erro:';
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbok],0);
                   sgej.Col:=coluna;
                   sgej.row:=linha;
              end;
     end;
end;

procedure tfrmsislin.inij;
begin
     if cberr.Text='' then
        cberr.text:=cberr.Items.Strings[3];
     if cbint.text='' then
        cbint.text:=cbint.Items.Strings[4];
     sgij.RowCount:=strtoint(cbint.text)+1;
end;

procedure TFrmSisLin.cbintChange(Sender: TObject);
begin
     sgij.Cells[0,0]:='Int.= '+cbint.Text;
end;

procedure TFrmSisLin.btblijClick(Sender: TObject);
begin
     frmpri.limpa(sgpj);
     frmpri.limpa(sgrj);
     frmpri.limpa(sgij);
     lbint.Caption:='Interações:';
     lberr.Caption:='Erro:';
     btbcj.Enabled:=true;
end;

procedure TFrmSisLin.cberrKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', ',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure TFrmSisLin.cbintKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure TFrmSisLin.btbmjClick(Sender: TObject);
begin
     frmpassos.Memopasso.Clear;
     try
        begin
             pcmatriz.activepage:=tsjacobi;
             frmpri.Matriz.Enabled:=true;
             frmpri.Gauss.Enabled:=true;
             frmpri.Jacobi.Enabled:=false;
             sgej.ColCount:=sgm.ColCount;
             sgej.RowCount:=sgm.RowCount;
             sgpj.ColCount:=sgm.ColCount;
             sgpj.RowCount:=sgm.RowCount;
             sgrj.ColCount:=sgm.ColCount-1;
             sgij.ColCount:=sgm.colcount+1;
             cberr.Text:=cberr.Items.Strings[3];
             cbint.Text:=cbint.Items.Strings[4];
             sgij.Cells[0,0]:='Int.= '+cbint.Text;
             sgij.Cells[sgij.ColCount-1,0]:='E<='+cberr.text;
             sgij.rowcount:=strtoint(cbint.text)+1;
             colocalabels(3);
             matriz(lbj,sgej);
             copiamatriz;
             inij;
             btbpj.Enabled:=true;
             btblj.Enabled:=true;
        end;
     except
           on EDivByZero do
              messagedlg('Divisão por Zero, o sistema não converge pelo método de Gauss',mterror,[mbok],0);
           on EZeroDivide do
              messagedlg('Divisão por zero, o sistema não converge pelo método de Gauss',mterror,[mbok],0);
           on EInvalidOp do
              messagedlg('Matriz mal dimensionada, confira os valores.',mterror,[mbok],0);
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbok],0);
                   sgej.Col:=coluna;
                   sgej.row:=linha;
              end;
     end;
end;

procedure TFrmSisLin.btbpjClick(Sender: TObject);
begin
     formulario:=PCmatriz.ActivePage;
     frmpassos.show;
end;

procedure TFrmSisLin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmsislin.Visible:=false;
     frmpri.Visible:=true;
     frmpri.voltar.Visible:=false;
     mnusislin.Unmerge(frmpri.mnupri);
end;

procedure TFrmSisLin.btbmsClick(Sender: TObject);
begin
     frmpri.limpa(sgm);
     frmpri.Visible:=true;
     frmsislin.Visible:=false;
end;

procedure TFrmSisLin.sgmClick(Sender: TObject);
begin
     btbml.Enabled:=true;
     btbmg.Enabled:=true;
     btbmj.Enabled:=true;
end;

procedure TFrmSisLin.SGEJClick(Sender: TObject);
begin
     verimat;
     btblj.Enabled:=true;
end;

procedure TFrmSisLin.sgegClick(Sender: TObject);
begin
     verimat;
     btblg.Enabled:=true;
end;

procedure TFrmSisLin.FormShow(Sender: TObject);
begin
     PCMatriz.ActivePage:=formulario;
end;

end.
