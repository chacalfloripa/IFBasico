unit fm_main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IFB_ConnFD,
  IFB_ConnFIBPlus, FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Phys.FBDef,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase;

type
  Tfrm_main = class(TForm)
    btnConnFD_01: TButton;
    btnConnORMBr_01: TButton;
    FDCommand1: TFDCommand;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDConnection1: TFDConnection;
    procedure btnConnFD_01Click(Sender: TObject);
  private
    { Private declarations }
  public
     ConnFD : TIFB_ConnFD;
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure Tfrm_main.btnConnFD_01Click(Sender: TObject);
begin
  if not Assigned(ConnFD) then
  begin
    ConnFD := TIFB_ConnFD.Create;
    ConnFD.connect;
  end;
end;

end.
