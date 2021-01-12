unit intervalo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids;

type
  Tfrminter = class(TForm)
    g1: TGroupBox;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Sgneg: TStringGrid;
    sgpos: TStringGrid;
    btok: TBitBtn;
    GroupBox2: TGroupBox;
    sgir: TStringGrid;
    GroupBox3: TGroupBox;
    eda: TEdit;
    edb: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btokClick(Sender: TObject);
    procedure sgposSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure SgnegSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edaClick(Sender: TObject);
    procedure edbClick(Sender: TObject);
    procedure edaKeyPress(Sender: TObject; var Key: Char);
    procedure edbKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure raizes;
    procedure intervalo;
    procedure limpa(grid:tstringgrid);
  public
    { Public declarations }
  end;

var
  frminter: Tfrminter;
  maior,menor:shortint;

implementation

{$R *.DFM}

uses princ,zeros,step;

procedure tfrminter.raizes;
var
   a:integer;
   d,e:byte;
   res:real;
begin
     a:=0;
     e:=0;
     d:=1;
     maior:=0;
     menor:=0;
     repeat
           sgir.RowCount:=d+1;
           maior:=e;
           sgir.cells[0,d]:=inttostr(e);
           if (d mod 2)=0 then
              res:=frmpri.eq(frmzeros.sgeq,e)
           else
               res:=frmpri.eq(frmzeros.sgeq,a);
           if (d mod 2)=0 then
              sgir.Cells[0,d]:=inttostr(e)
           else
               begin
                    sgir.cells[0,d]:=inttostr(a);
                    menor:=a;
                    e:=e+1;
               end;
           frmpassos.Memopasso.Lines.Append('F('+inttostr(a)+') * F('+inttostr(e)+') <0 ? ('+floattostr(res)+')');
           sgir.cells[1,d]:=floattostr(res);
           a:=e*-1;
           d:=d+1;
           frmzeros.lbil.caption:=inttostr(menor);
           frmzeros.lbih.caption:=inttostr(maior);
     until (d>=20);
     frmpri.memospace;
     frmpassos.Memopasso.Lines.Append('Isolamento das Raízes');
     frmpri.memospace;
     frmpri.mostrapot(sgir);
     frmpri.memospace;
     frmpri.tracejado;
end;

procedure tfrminter.intervalo;
const
     c0=0;
     c1=1;
var
   a,b:shortint;
   countp,countn:byte;
begin
     countp:=1;
     countn:=1;
     a:=0;
     b:=1;
     while b<=maior do
         begin
              if ((frmpri.eq(frmzeros.sgeq,a))*(frmpri.eq(frmzeros.sgeq,b))<0) then
                 begin
                      sgpos.Visible:=true;
                      sgpos.Cells[c0,countp]:=inttostr(a);
                      sgpos.Cells[c1,countp]:=inttostr(b);
                      countp:=countp+1;
                      sgpos.RowCount:=countp;
                 end;
              a:=b;
              b:=b+1;
         end;
     a:=0;
     b:=-1;
     while b>=menor do
         begin
              if ((frmpri.eq(frmzeros.sgeq,a))*(frmpri.eq(frmzeros.sgeq,b))<0) then
                 begin
                      sgneg.Visible:=true;
                      sgneg.Cells[c0,countn]:=inttostr(a);
                      sgneg.Cells[c1,countn]:=inttostr(b);
                      countn:=countn+1;
                      sgneg.RowCount:=countn;
                 end;
              a:=b;
              b:=b-1;
         end;
     if ((not(sgpos.Visible)) and (not(sgneg.Visible))) then
        begin
             messagedlg('Não é possível concluir que há raízes reais entre '+inttostr(menor)+' e '+inttostr(maior)+' intervalo',mtinformation,[mbok],0);
             btok.Enabled:=true;
             frmpassos.Memopasso.Lines.Append('Não é possível concluir que há raízes reais entre  '+inttostr(menor)+' e '+inttostr(maior)+' intervalo');
        end;
end;

procedure Tfrminter.FormActivate(Sender: TObject);
begin
     try
        begin
             sgpos.Cells[0,0]:='a';
             sgpos.Cells[1,0]:='b';
             sgneg.Cells[0,0]:='a';
             sgneg.Cells[1,0]:='b';
             sgir.cells[0,0]:='X';
             sgir.Cells[1,0]:='Y';
             sgpos.Visible:=false;
             sgneg.Visible:=false;
             eda.clear;
             edb.Clear;
             raizes;
             intervalo;
        end;
     except
           on EConvertError do
              begin
                   messagedlg('Caracter invalido encontrado!',mterror,[mbok],0);
                   btok.Enabled:=true;
                   frmzeros.btpb.enabled:=false;
                   frmzeros.SGEq.col:=coluna;
                   frmzeros.sgeq.Row:=linha;
              end;
     end;
end;

procedure Tfrminter.btokClick(Sender: TObject);
begin
     if eda.text='' then
        if sgpos.Visible then
           eda.text:=(sgpos.cells[0,1])
        else
            eda.text:=(sgneg.cells[0,1]);
     if edb.text='' then
        if sgpos.Visible then
           edb.text:=(sgpos.cells[1,1])
        else
            edb.text:=(sgneg.cells[1,1]);
     if eda.Text<>'' then
        i:=strtofloat(eda.text);
     if edb.Text<>'' then
        j:=strtofloat(edb.text);
     if i>j then
           begin
                i:=strtofloat(edb.text);
                j:=strtofloat(eda.text);
           end;
     if (sgpos.Visible) or (sgneg.Visible) then
        if ((frmpri.eq(frmzeros.sgeq,i))*(frmpri.eq(frmzeros.sgeq,j))<0) then
                begin
                     frmzeros.lbmenor.Caption:=floattostr(i);
                     frmzeros.lbmaior.Caption:=floattostr(j);
                     frmpassos.Memopasso.Lines.Append('Intervalo escolhido: '+floattostr(i)+' |-----| '+floattostr(j));
                     frmpri.memospace;
                     frmpri.tracejado;
                     frmzeros.calcula;
                     frmpri.memospace;
                     frmpassos.Memopasso.Lines.Append('Interações');
                     frmpri.memospace;
                     frmpri.mostramat(frmzeros.sgib);
                     frmzeros.resultado;
                     frminter.close;
                end
             else
                 messagedlg('Não é possível concluir se existe raízes entre'+eda.text+' e '+edb.text+' intervalo',mterror,[mbok],0)
        else
            frminter.close;
end;

procedure Tfrminter.sgposSelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
begin
     btok.Enabled:=true;
     if col=0 then
        begin
             i:=strtoint(sgpos.cells[col,row]);
             j:=strtoint(sgpos.cells[col+1,row]);
        end;
     if col=1 then
        begin
             i:=strtoint(sgpos.cells[col-1,row]);
             j:=strtoint(sgpos.cells[col,row]);
        end;
     eda.Text:=floattostr(i);
     edb.Text:=floattostr(j);
end;

procedure Tfrminter.SgnegSelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
begin
     btok.Enabled:=true;
     if col=0 then
        begin
             i:=strtoint(sgneg.cells[col,row]);
             j:=strtoint(sgneg.cells[col+1,row]);
        end;
     if col=1 then
        begin
             i:=strtoint(sgneg.cells[col-1,row]);
             j:=strtoint(sgneg.cells[col,row]);
        end;
     eda.Text:=floattostr(i);
     edb.Text:=floattostr(j);
end;

procedure tfrminter.limpa(grid:tstringgrid);
var
   a,b:byte;
begin
     for a:=0 to grid.ColCount-1 do
         for b:=1 to grid.RowCount-1 do
             grid.Cells[a,b]:='';
end;

procedure Tfrminter.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     limpa(sgneg);
     limpa(sgpos);
     limpa(sgir);
end;

procedure Tfrminter.edaClick(Sender: TObject);
begin
     btok.Enabled:=true;
end;

procedure Tfrminter.edbClick(Sender: TObject);
begin
     btok.Enabled:=true;
end;

procedure Tfrminter.edaKeyPress(Sender: TObject; var Key: Char);
begin
       if not (key in ['0'..'9', ',','-',#8,#9]) then
        begin
             key := #0;
             beep;
        end;
end;

procedure Tfrminter.edbKeyPress(Sender: TObject; var Key: Char);
begin
       if not (key in ['0'..'9', ',','-',#8,#9]) then
        begin
             key := #0;
             beep;
        end;
end;

end.
