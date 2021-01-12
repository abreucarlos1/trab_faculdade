unit about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  Tsobre = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    La: TLabel;
    BitBtn1: TBitBtn;
    Image2: TImage;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  sobre: Tsobre;

implementation

{$R *.DFM}

procedure Tsobre.BitBtn1Click(Sender: TObject);
begin
     sobre.Close;
end;


end.
