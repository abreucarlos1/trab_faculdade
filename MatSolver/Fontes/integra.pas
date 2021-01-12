unit integra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, Buttons, Menus;

type
  Tfrmintegra = class(TForm)
    PCInte: TPageControl;
    TSMatriz: TTabSheet;
    TSTrap: TTabSheet;
    TS13: TTabSheet;
    TS38: TTabSheet;
    GroupBox1: TGroupBox;
    sgp: TStringGrid;
    tbp: TTrackBar;
    GroupBox2: TGroupBox;
    btbtrap: TBitBtn;
    btb13: TBitBtn;
    btblimp: TBitBtn;
    btbsair: TBitBtn;
    btb38: TBitBtn;
    GroupBox3: TGroupBox;
    sgtp: TStringGrid;
    tbtr: TTrackBar;
    GroupBox4: TGroupBox;
    sgs13: TStringGrid;
    tbs13: TTrackBar;
    GroupBox5: TGroupBox;
    sgs38: TStringGrid;
    tbs38: TTrackBar;
    GroupBox6: TGroupBox;
    btbcalc: TBitBtn;
    btbstep: TBitBtn;
    btbclean: TBitBtn;
    btbsai: TBitBtn;
    GroupBox7: TGroupBox;
    btbs13: TBitBtn;
    btbp13: TBitBtn;
    btbl13: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox8: TGroupBox;
    btbs38: TBitBtn;
    btbp38: TBitBtn;
    btbl38: TBitBtn;
    BitBtn8: TBitBtn;
    GroupBox9: TGroupBox;
    lbtr: TLabel;
    GroupBox10: TGroupBox;
    lbs13: TLabel;
    GroupBox11: TGroupBox;
    lbs38: TLabel;
    mnuint: TMainMenu;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    lbtp: TLabel;
    lbtt: TLabel;
    GroupBox14: TGroupBox;
    lbp3: TLabel;
    GroupBox15: TGroupBox;
    lbt3: TLabel;
    GroupBox16: TGroupBox;
    lbp8: TLabel;
    GroupBox17: TGroupBox;
    lbt8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure sgpKeyPress(Sender: TObject; var Key: Char);
    procedure tbpChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btblimpClick(Sender: TObject);
    procedure btbcleanClick(Sender: TObject);
    procedure btbl13Click(Sender: TObject);
    procedure btbl38Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure btbsairClick(Sender: TObject);
    procedure btbsaiClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure tbtrChange(Sender: TObject);
    procedure tbs13Change(Sender: TObject);
    procedure tbs38Change(Sender: TObject);
    procedure btbtrapClick(Sender: TObject);
    procedure btb13Click(Sender: TObject);
    procedure btb38Click(Sender: TObject);
    procedure sgpClick(Sender: TObject);
    procedure PCInteChange(Sender: TObject);
    procedure btbcalcClick(Sender: TObject);
    procedure btbs13Click(Sender: TObject);
    procedure btbs38Click(Sender: TObject);
    procedure btbstepClick(Sender: TObject);
    procedure sgtpClick(Sender: TObject);
    procedure sgs13Click(Sender: TObject);
    procedure sgs38Click(Sender: TObject);
    procedure btbp13Click(Sender: TObject);
    procedure btbp38Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function trapezio(grid:TstringGrid):string;
    function Simp13(grid:TstringGrid):String;
    function Simp38(grid:Tstringgrid):string;
    procedure verimat;
  public
    { Public declarations }
  end;

var
  frmintegra: Tfrmintegra;
  formulario:TTabSheet;

implementation

{$R *.DFM}


uses princ,step;

procedure tfrmintegra.verimat;
var
   a,b:byte;
begin
     if pcinte.ActivePage=tstrap then
        for a:=1 to sgtp.Rowcount-1 do
            for b:=0 to 1 do
                if sgtp.Cells[b,a]='' then
                   btbclean.Enabled:=false
                else
                    begin
                         btbcalc.Enabled:=true;
                         btbclean.Enabled:=true;
                    end;
     if pcinte.ActivePage=ts13 then
        for a:=1 to sgs13.Rowcount-1 do
            for b:=0 to 1 do
                if sgs13.Cells[b,a]='' then
                   btbl13.Enabled:=false
                else
                    begin
                         btbl13.Enabled:=true;
                         btbs13.Enabled:=true;
                    end;
     if pcinte.ActivePage=ts38 then
        for a:=1 to sgs38.Rowcount-1 do
            for b:=0 to 1 do
                if sgs38.Cells[b,a]='' then
                   btbl38.Enabled:=false
                else
                    begin
                         btbl38.Enabled:=true;
                         btbs38.Enabled:=true;
                    end;
end;

function tfrmintegra.trapezio(Grid:Tstringgrid):string;
var
   a:byte;
   S,T:string;
   H,i,j,soma,temp:real;
begin
     coluna:=0;
     linha:=1;
     s:='';
     t:='';
     i:=strtofloat(grid.Cells[0,1]);
     linha:=grid.RowCount-1;
     j:=strtofloat(grid.cells[0,grid.rowcount-1]);
     H:=((abs(j))+(abs(i)))/(grid.RowCount-2);
     lbtp.Caption:=inttostr(grid.rowcount-2);
     frmpassos.Memopasso.Lines.Append('Número de Pontos');
     frmpassos.Memopasso.Lines.Append(lbtp.caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Tamanho do Intervalo');
     lbtt.Caption:=formatfloat('0.00',h);
     frmpassos.Memopasso.Lines.Append(lbtt.caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Cálculos');
     frmpri.memospace;
     soma:=0;
     for a:=2 to grid.RowCount-2 do
         begin
              coluna:=1;
              linha:=a;
              t:=grid.cells[1,a];
              temp:=strtofloat(grid.Cells[1,a]);
              s:=s+' + 2 * '+t;
              soma:=soma+2*temp;
         end;
     coluna:=1;
     linha:=1;
     i:=strtofloat(grid.cells[1,1]);
     linha:=grid.rowcount-1;
     j:=strtofloat(grid.cells[1,grid.rowcount-1]);
     frmpassos.Memopasso.Lines.Append(grid.cells[1,1]+' + '+s+' + '+grid.cells[1,grid.rowcount-1]+' * '+formatfloat('0.00',h)+' / 2');
     trapezio:=formatfloat('0.00',(i+soma+j)*(h/2));
end;

function tfrmintegra.Simp13(grid:TstringGrid):string;
var
   a,b:byte;
   s,t:string;
   H,i,j,soma,temp:real;
begin
     coluna:=0;
     linha:=1;
     t:='';
     s:='';
     i:=strtofloat(grid.Cells[0,1]);
     b:=grid.RowCount-2;
     lbp3.Caption:=inttostr(b);
     frmpassos.Memopasso.Lines.Append('Número de Pontos');
     frmpassos.Memopasso.Lines.Append(lbp3.caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Tamanho do Intervalo');
     if not (b mod 2=0) then
        b:=b-1;
     linha:=b+1;
     j:=strtofloat(grid.cells[0,b+1]);
     H:=((abs(j))+(abs(i)))/(b);
     soma:=0;
     lbt3.Caption:=formatfloat('0.00',H);
     frmpassos.Memopasso.Lines.Append(lbt3.caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Cálculos');
     frmpri.memospace;
     for a:=2 to grid.RowCount-2 do
         begin
              coluna:=1;
              linha:=a;
              temp:=strtofloat(grid.Cells[1,a]);
              t:=grid.cells[1,a];
              if (a mod 2=0) then
                 begin
                      soma:=soma+4*temp;
                      s:=s+' + 4 * '+t;
                 end
              else
                  begin
                       soma:=soma+2*temp;
                       s:=s+' + 2 * '+t;
                  end;
         end;
     coluna:=1;
     linha:=1;
     i:=strtofloat(grid.cells[1,1]);
     linha:=grid.RowCount-1;
     j:=strtofloat(grid.cells[1,grid.rowcount-1]);
     frmpassos.Memopasso.Lines.Append(grid.cells[1,1]+' + '+s+' + '+grid.cells[1,grid.rowcount-1]+' * '+lbt3.Caption+' / 3');
     simp13:=formatfloat('0.00',(i+soma+j)*(h/3));
end;

function tfrmintegra.Simp38(grid:tstringgrid):string;
var
   a,b:byte;
   t,s:string;
   H,i,j,soma,temp:real;
begin
     coluna:=0;
     linha:=1;
     t:='';
     s:='';
     i:=strtofloat(grid.Cells[0,1]);
     b:=grid.RowCount-2;
     linha:=grid.rowcount-1;
     j:=strtofloat(grid.cells[0,grid.rowcount-1]);
     H:=((abs(j))+(abs(i)))/(b);
     soma:=0;
     lbp8.Caption:=inttostr(b);
     frmpassos.Memopasso.Lines.Append('Número de Pontos');
     frmpassos.Memopasso.Lines.Append(lbp8.caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Tamanho do Intervalo');
     lbt8.Caption:=formatfloat('0.00',H);
     frmpassos.Memopasso.Lines.Append(lbtt.caption);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Cálculos');
     frmpri.memospace;
     for a:=2 to grid.RowCount-2 do
         begin
              b:=a-1;
              coluna:=1;
              linha:=a;
              temp:=strtofloat(grid.Cells[1,a]);
              t:=grid.cells[1,a];
              if (b mod 3=0) then
                 begin
                      soma:=soma+2*temp;
                      s:=s+' + 2 * '+t;
                 end
              else
                  begin
                       soma:=soma+3*temp;
                       s:=s+' + 3 * '+t;
                  end;
         end;
     coluna:=1;
     linha:=1;
     i:=strtofloat(grid.cells[1,1]);
     linha:=grid.rowcount-1;
     j:=strtofloat(grid.cells[1,grid.rowcount-1]);
     frmpassos.Memopasso.Lines.Append(grid.cells[1,1]+' + '+s+' + '+grid.cells[1,grid.rowcount-1]+' 3 * '+lbt8.Caption+' / 8');
     simp38:=formatfloat('0.00',(i+soma+j)*((3*h)/8));
end;

procedure Tfrmintegra.sgpKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','-',',', #8, #9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrmintegra.tbpChange(Sender: TObject);
begin
     sgp.rowcount:=tbp.Position;
     label1.Caption:=inttostr(tbp.position-1);
end;


procedure Tfrmintegra.FormActivate(Sender: TObject);
begin
     label1.Caption:=inttostr(sgp.RowCount-1);
     label2.Caption:=inttostr(sgtp.RowCount-1);
     label3.Caption:=inttostr(sgs13.RowCount-1);
     label4.Caption:=inttostr(sgs38.RowCount-1);

     frmpri.Salvar1.Enabled:=true;
     frmpri.Matriz.Enabled:=true;
     frmpri.Gauss.Enabled:=true;
     frmpri.Jacobi.Enabled:=true;
     frmpri.voltar.Visible:=true;
     frmpri.Biseccao.Enabled:=true;
     frmpri.Lagrange.Enabled:=true;
     frmpri.Ajuste.Enabled:=true;
     frmpri.voltar.visible:=true;
     mnuint.Merge(frmpri.mnupri);
     PCinte.ActivePage:=formulario;
     sgp.Cells[0,0]:='X';
     sgp.Cells[1,0]:='Y';
     sgtp.Cells[0,0]:='X';
     sgtp.Cells[1,0]:='Y';
     sgs13.Cells[0,0]:='X';
     sgs13.cells[1,0]:='Y';
     sgs38.cells[0,0]:='X';
     sgs38.cells[1,0]:='Y';
end;

procedure Tfrmintegra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmintegra.Visible:=false;
     frmpri.Visible:=true;
     frmpri.voltar.Visible:=false;
     mnuint.Unmerge(frmpri.mnupri);
end;

procedure Tfrmintegra.btblimpClick(Sender: TObject);
begin
     frmpri.limpa(sgp);
end;

procedure Tfrmintegra.btbcleanClick(Sender: TObject);
begin
     frmpri.limpa(sgtp);
     lbtp.Caption:='';
     lbtr.Caption:='';
     lbtt.Caption:='';
end;

procedure Tfrmintegra.btbl13Click(Sender: TObject);
begin
     frmpri.limpa(sgs13);
     lbs13.Caption:='';
     lbp3.Caption:='';
     lbt3.Caption:='';
end;

procedure Tfrmintegra.btbl38Click(Sender: TObject);
begin
     frmpri.limpa(sgs38);
     lbs38.Caption:='';
     lbp8.Caption:='';
     lbt8.Caption:='';
end;

procedure Tfrmintegra.BitBtn8Click(Sender: TObject);
begin
     frmpri.limpa(sgs38);
     frmintegra.Visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmintegra.btbsairClick(Sender: TObject);
begin
     frmpri.limpa(sgp);
     frmintegra.Visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmintegra.btbsaiClick(Sender: TObject);
begin
     frmpri.limpa(sgtp);
     frmintegra.Visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmintegra.BitBtn4Click(Sender: TObject);
begin
     frmpri.limpa(sgs13);
     frmintegra.Visible:=false;
     frmpri.Visible:=true;
end;

procedure Tfrmintegra.tbtrChange(Sender: TObject);
begin
     sgtp.RowCount:=tbtr.Position;
     label2.Caption:=inttostr(tbtr.position-1);
end;

procedure Tfrmintegra.tbs13Change(Sender: TObject);
begin
     sgs13.RowCount:=tbs13.position;
     label3.Caption:=inttostr(tbs13.position-1);
end;

procedure Tfrmintegra.tbs38Change(Sender: TObject);
begin
     sgs38.RowCount:=tbs38.position;
     label4.Caption:=inttostr(tbs38.position-1);
end;

procedure Tfrmintegra.btbtrapClick(Sender: TObject);
begin
     try
        begin
             label2.Caption:=inttostr(sgtp.rowcount-1);
             frmpassos.Memopasso.Clear;
             frmpri.tracejado;
             frmpassos.Memopasso.Lines.Append('Ajuste de Curvas: Trapézios');
             frmpri.tracejado;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Pontos');
             frmpri.memospace;
             frmpri.mostrapot(sgtp);
             frmpri.memospace;
             btbclean.Enabled:=true;
             btbstep.Enabled:=true;
             frmpri.copiamat(sgtp,sgp);
             pcinte.ActivePage:=TStrap;
             lbtr.Caption:=trapezio(sgtp);
             frmpri.tracejado;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Resultado');
             frmpassos.Memopasso.Lines.Append(lbtr.caption);
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgtp.col:=coluna;
                   sgtp.row:=linha;
              end;
     end;
end;

procedure Tfrmintegra.btb13Click(Sender: TObject);
begin
     try
        begin
             label3.Caption:=inttostr(sgs13.rowcount-1);
             frmpassos.Memopasso.Clear;
             frmpri.tracejado;
             frmpassos.Memopasso.Lines.Append('Ajuste de Curvas: Simpson 1/3');
             frmpri.tracejado;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Pontos');
             frmpri.memospace;
             frmpri.copiamat(sgs13,sgp);
             frmpri.mostrapot(sgs13);
             frmpri.memospace;
             btbl13.Enabled:=true;
             btbp13.Enabled:=true;
             pcinte.ActivePage:=Ts13;
             lbs13.Caption:=simp13(sgs13);
             frmpri.tracejado;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Resultado');
             frmpassos.Memopasso.Lines.Append(lbs13.caption);
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgs13.col:=coluna;
                   sgs13.row:=linha;
              end;
     end;
end;

procedure Tfrmintegra.btb38Click(Sender: TObject);
begin
     try
        begin
             btbl38.Enabled:=true;
             btbp38.Enabled:=true;
             frmpri.copiamat(sgs38,sgp);
             label4.Caption:=inttostr(sgs38.rowcount-1);
             frmpassos.Memopasso.Clear;
             frmpri.tracejado;
             frmpassos.Memopasso.Lines.Append('Ajuste de Curvas: Simpson 3/8');
             frmpri.tracejado;
             frmpri.memospace;
             frmpri.copiamat(sgs38,sgp);
             frmpassos.Memopasso.Lines.Append('Pontos');
             frmpri.memospace;
             frmpri.mostrapot(sgs38);
             frmpri.memospace;
             pcinte.ActivePage:=ts38;
             lbs38.Caption:=simp38(sgs38);
             frmpri.tracejado;
             frmpri.memospace;
             frmpassos.Memopasso.Lines.Append('Resultado');
             frmpassos.Memopasso.Lines.Append(lbs38.caption);
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgs38.col:=coluna;
                   sgs38.row:=linha;
              end;
     end;
end;

procedure Tfrmintegra.sgpClick(Sender: TObject);
begin
     btblimp.Enabled:=true;
     btbtrap.Enabled:=true;
     btb13.Enabled:=true;
     btb38.Enabled:=true;
end;

procedure Tfrmintegra.PCInteChange(Sender: TObject);
begin
     if pcinte.ActivePage=TStrap then
        begin
             frmpri.MatrizI.Enabled:=true;
             frmpri.Trapezio.Enabled:=false;
             frmpri.simpson13.Enabled:=true;
             frmpri.Simpson38.Enabled:=true;
             frmpri.copiamat(sgtp,sgp);
             label2.caption:=inttostr(sgtp.rowcount-1);
             verimat;
        end;
     if pcinte.ActivePage=TS13 then
        begin
             frmpri.MatrizI.Enabled:=true;
             frmpri.Trapezio.Enabled:=true;
             frmpri.simpson13.Enabled:=false;
             frmpri.Simpson38.Enabled:=true;
             frmpri.copiamat(sgs13,sgp);
             label3.caption:=inttostr(sgs13.rowcount-1);
             verimat;
        end;
     if pcinte.ActivePage=TS38 then
        begin
             frmpri.MatrizI.Enabled:=true;
             frmpri.Trapezio.Enabled:=true;
             frmpri.simpson13.Enabled:=true;
             frmpri.Simpson38.Enabled:=false;
             frmpri.copiamat(sgs38,sgp);
             label4.caption:=inttostr(sgs38.rowcount-1);
             verimat;
        end;
     if pcinte.ActivePage=TSMatriz then
        begin
             frmpri.MatrizI.Enabled:=false;
             frmpri.Trapezio.Enabled:=true;
             frmpri.simpson13.Enabled:=true;
             frmpri.Simpson38.Enabled:=true;
             label1.caption:=inttostr(sgp.rowcount-1);
        end;
end;


procedure Tfrmintegra.btbcalcClick(Sender: TObject);
begin
     try
        frmpassos.Memopasso.Clear;
        frmpri.tracejado;
        frmpassos.Memopasso.Lines.Append('Ajuste de Curvas: Trapézios');
        frmpri.tracejado;
        frmpri.memospace;
        frmpassos.Memopasso.Lines.Append('Pontos');
        frmpri.memospace;
        frmpri.mostrapot(sgtp);
        frmpri.memospace;
        lbtr.Caption:=trapezio(sgtp);
        frmpri.tracejado;
        frmpri.memospace;
        frmpassos.Memopasso.Lines.Append('Resultado');
        frmpassos.Memopasso.Lines.Append(lbtr.caption);
        btbcalc.Enabled:=false;
        btbstep.Enabled:=true;
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgtp.col:=coluna;
                   sgtp.row:=linha;
              end;
     end;
end;

procedure Tfrmintegra.btbs13Click(Sender: TObject);
begin
     try
        frmpassos.Memopasso.Clear;
        frmpri.tracejado;
        frmpassos.Memopasso.Lines.Append('Ajuste de Curvas: Simpson 1/3');
        frmpri.tracejado;
        frmpri.memospace;
        frmpassos.Memopasso.Lines.Append('Pontos');
        frmpri.memospace;
        frmpri.mostrapot(sgs13);
        frmpri.memospace;
        lbs13.Caption:=simp13(sgs13);
        frmpri.tracejado;
        frmpri.memospace;
        frmpassos.Memopasso.Lines.Append('Resultado');
        frmpassos.Memopasso.Lines.Append(lbs13.caption);
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgs13.col:=coluna;
                   sgs13.row:=linha;
              end;
     end;
end;

procedure Tfrmintegra.btbs38Click(Sender: TObject);
begin
     try
        
        frmpassos.Memopasso.Clear;
        frmpri.tracejado;
        frmpassos.Memopasso.Lines.Append('Ajuste de Curvas: Simpson 3/8');
        frmpri.tracejado;
        frmpri.memospace;
        frmpassos.Memopasso.Lines.Append('Pontos');
        frmpri.memospace;
        frmpri.mostrapot(sgs38);
        frmpri.memospace;
        lbs38.Caption:=simp38(sgs38);
        frmpri.tracejado;
        frmpri.memospace;
        frmpassos.Memopasso.Lines.Append('Resultado');
        frmpassos.Memopasso.Lines.Append(lbs38.caption);
     except
           on EConvertError do
              begin
                   messagedlg('Caracteres inválidos encontrado',mterror,[mbOK],0);
                   sgs38.col:=coluna;
                   sgs38.row:=linha;
              end;
     end;
end;

procedure Tfrmintegra.btbstepClick(Sender: TObject);
begin
     formulario:=PCinte.ActivePage;
     frmpassos.show;
end;

procedure Tfrmintegra.sgtpClick(Sender: TObject);
begin
     btbcalc.Enabled:=true;
     btbclean.Enabled:=true;
end;

procedure Tfrmintegra.sgs13Click(Sender: TObject);
begin
     btbs13.Enabled:=true;
     btbl13.Enabled:=true;
end;

procedure Tfrmintegra.sgs38Click(Sender: TObject);
begin
     btbs38.Enabled:=true;
     btbl38.Enabled:=true;
end;

procedure Tfrmintegra.btbp13Click(Sender: TObject);
begin
     formulario:=PCinte.ActivePage;
     frmpassos.show;
end;

procedure Tfrmintegra.btbp38Click(Sender: TObject);
begin
     formulario:=PCinte.ActivePage;
     frmpassos.show;
end;

procedure Tfrmintegra.FormCreate(Sender: TObject);
begin
     formulario:=TSMatriz;
end;

procedure Tfrmintegra.FormShow(Sender: TObject);
begin
     PCinte.ActivePage:=formulario;
end;

end.

