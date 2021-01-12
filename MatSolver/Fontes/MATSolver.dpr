program MATSolver;

uses
  Forms,
  apresenta in 'apresenta.pas' {FrmApresenta},
  SisLin in 'SisLin.pas' {FrmSisLin},
  step in 'step.pas' {frmpassos},
  Princ in 'Princ.pas' {Frmpri},
  zeros in 'zeros.pas' {frmzeros},
  intervalo in 'intervalo.pas' {frminter},
  about in 'about.pas' {sobre},
  interp in 'interp.pas' {frmlagr},
  ajuste in 'ajuste.pas' {frmajuste},
  detail in 'detail.pas' {frmdet},
  integra in 'integra.pas' {frmintegra};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Calculo Numérico';
  Application.HelpFile := 'C:\MSolver\Help\calculo.hlp';
  Application.CreateForm(TFrmpri, Frmpri);
  Application.CreateForm(TFrmSisLin, FrmSisLin);
  Application.CreateForm(Tfrmpassos, frmpassos);
  Application.CreateForm(Tfrmzeros, frmzeros);
  Application.CreateForm(Tfrminter, frminter);
  Application.CreateForm(TFrmApresenta, FrmApresenta);
  Application.CreateForm(Tsobre, sobre);
  Application.CreateForm(Tfrmlagr, frmlagr);
  Application.CreateForm(Tfrmajuste, frmajuste);
  Application.CreateForm(Tfrmdet, frmdet);
  Application.CreateForm(Tfrmintegra, frmintegra);
  Application.Run;
  
end.
