program prjpolinomio;

uses
  Forms,
  polinomio1 in 'polinomio1.pas' {Form1},
  polinomio2 in 'polinomio2.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
