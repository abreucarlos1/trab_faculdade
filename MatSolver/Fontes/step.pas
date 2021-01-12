unit step;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,printers,clipbrd;

type
  Tfrmpassos = class(TForm)
    Memopasso: TMemo;
    btbstepimp: TBitBtn;
    btbstepvoltar: TBitBtn;
    Pd: TPrintDialog;
    btbcopiar: TBitBtn;
    BtbSalva: TBitBtn;
    sd1: TSaveDialog;
    procedure btbstepvoltarClick(Sender: TObject);
    procedure btbstepimpClick(Sender: TObject);
    procedure BtbSalvaClick(Sender: TObject);
    procedure btbcopiarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmpassos: Tfrmpassos;


implementation

{$R *.DFM}

uses sislin;

procedure Tfrmpassos.btbstepvoltarClick(Sender: TObject);
begin
     frmpassos.visible:=false;
end;

procedure Tfrmpassos.btbstepimpClick(Sender: TObject);
var
   i,j:word;
   texto:system.text;
begin
     try
        if pd.Execute then
           begin
                btbstepimp.Enabled:=false;
                printer.Copies:=pd.Copies;
                printer.Title:=memopasso.Lines.Strings[1];
                assignprn(texto);
                rewrite(texto);
                printer.Canvas.Font:=memopasso.Font;
                for i:=1 to printer.Copies do
                    for j:=0 to memopasso.Lines.Count-1 do
                        begin
                             writeln(texto,memopasso.lines[j]);
                             if j>=printer.PageHeight then
                                printer.NewPage;
                        end;
                    system.Close(texto);
                    btbstepimp.Enabled:=true;
           end;
        except
              on EPrinter do
                 begin
                      messagedlg('Erro, não é possível realizar a impressão' ,mtError,[mbok],0);
                      btbstepvoltar.Enabled:=true;
                      btbstepimp.Enabled:=true;
                 end;
     end;
end;

procedure Tfrmpassos.BtbSalvaClick(Sender: TObject);
begin
     try
        if sd1.Execute then
           memopasso.Lines.SaveToFile(sd1.filename);
     except
           on EFCreateError do
              messagedlg('Não é possível salvar no dispositivo selecionado',mterror,[mbok],0);
           on EFilerError do
              messagedlg('Não é possível salvar no dispositivo selecionado',mterror,[mbok],0);
     end;
end;

procedure Tfrmpassos.btbcopiarClick(Sender: TObject);
var
   x:string;
begin
     if messagedlg('Deseja apagar o conteúdo da Área de Transferencia?',MtInformation,[mbyes,mbno],0)=mryes then
        begin
             x:=memopasso.Text;
             clipboard.Clear;
             clipboard.AsText:=x;
        end;
end;

end.


