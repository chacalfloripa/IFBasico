program AppFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  fm_main in 'fm_main.pas' {frm_main},
  IFB_ConnFD in '..\Database\IFB_ConnFD.pas',
  IFB_ConnFIBPlus in '..\Database\IFB_ConnFIBPlus.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
