program AppVCL;

uses
  Vcl.Forms,
  fm_main in 'fm_main.pas' {Form1},
  App in 'App.pas',
  IFB_App in '..\Comum\IFB_App.pas',
  IFB_FuncoesINI in '..\Comum\IFB_FuncoesINI.pas',
  IFB_Conn in '..\Database\IFB_Conn.pas',
  IFB_ConnFD in '..\Database\IFB_ConnFD.pas',
  IFB_ConnFIBPlus in '..\Database\IFB_ConnFIBPlus.pas',
  un_DBFuncoes in '..\Database\un_DBFuncoes.pas',
  un_DBFuncoesFD in '..\Database\un_DBFuncoesFD.pas',
  un_DBFuncoesIF in '..\Database\un_DBFuncoesIF.pas',
  un_IFBBuildDataBase in '..\Database\un_IFBBuildDataBase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
