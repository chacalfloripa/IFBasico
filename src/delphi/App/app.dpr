program app;

uses
  Vcl.Forms,
  fm_main in 'fm_main.pas' {Form1},
  dm_connect in 'Database\dm_connect.pas' {dtm_connect: TDataModule},
  un_DBFuncoesIF in 'Database\un_DBFuncoesIF.pas',
  un_DBFuncoes in 'Database\un_DBFuncoes.pas',
  un_DBFuncoesFD in 'Database\un_DBFuncoesFD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tdtm_connect, dtm_connect);
  Application.Run;
end.
