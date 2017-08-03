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
  FireDAC.Phys.IBBase, IFB_App, FireDAC.Comp.DataSet;

type
  Tfrm_main = class(TForm)
    btnConnORMBr_01: TButton;
    btnGetParhHome: TButton;
    FDMemTable1: TFDMemTable;
    procedure btnConnORMBr_01Click(Sender: TObject);
    procedure btnGetParhHomeClick(Sender: TObject);
  private
    { Private declarations }
  public
    FIFB_App : TIFB_App;
    ConnFD : TIFB_ConnFD;
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure Tfrm_main.btnConnORMBr_01Click(Sender: TObject);
begin
  FreeAndNil(ConnFD);
  if not Assigned(ConnFD) then
  begin
    ConnFD := TIFB_ConnFD.Create('CONN_01');
    ConnFD.connect;
    //
  end;
end;

procedure Tfrm_main.btnGetParhHomeClick(Sender: TObject);
begin
  ShowMessage(FIFB_App.AppHome);
end;

end.
