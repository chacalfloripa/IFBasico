program AppFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  fm_main in 'fm_main.pas' {frm_main},
  IFB_ConnFD in '..\Database\IFB_ConnFD.pas',
  IFB_ConnFIBPlus in '..\Database\IFB_ConnFIBPlus.pas',
  IFB_Conn in '..\Database\IFB_Conn.pas',
  IFB_FuncoesINI in '..\Comum\IFB_FuncoesINI.pas',
  IFB_App in '..\Comum\IFB_App.pas' {$R *.res},
  App in 'App.pas',
  un_IFBBuildDataBase in 'un_IFBBuildDataBase.pas';

{$R *.res}

begin
  Application.Initialize;
  oApp.start;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
