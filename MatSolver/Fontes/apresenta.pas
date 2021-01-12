unit apresenta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ComCtrls ,Buttons, ExtCtrls;

type
  TFrmApresenta = class(TForm)
    Label2: TLabel;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Label3: TLabel;
    Memo2: TMemo;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Image2: TImage;
    BitBtn2: TBitBtn;
    Image1: TImage;
    Image3: TImage;
    BitBtn3: TBitBtn;
    Memo3: TMemo;
    Label1: TLabel;
    Splitter2: TSplitter;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmApresenta: TFrmApresenta;


implementation



{$R *.DFM}

uses princ;

procedure TFrmApresenta.BitBtn1Click(Sender: TObject);
begin
     frmapresenta.close;
     frmpri.Visible:=true;
end;

procedure TFrmApresenta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     action:=cafree;
end;

procedure TFrmApresenta.BitBtn2Click(Sender: TObject);
begin
     frmapresenta.Close;
     frmpri.Close;
end;

procedure TFrmApresenta.FormActivate(Sender: TObject);
begin
     bitbtn1.SetFocus;     
end;

procedure TFrmApresenta.BitBtn3Click(Sender: TObject);
begin
     frmapresenta.FormStyle:=fsNormal;
     application.HelpContext(1);
     frmapresenta.FormStyle:=fsStayOnTop;
end;




end.
