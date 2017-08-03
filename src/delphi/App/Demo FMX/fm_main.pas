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
  FireDAC.Phys.IBBase, IFB_App, FireDAC.Comp.DataSet, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, app;

type
  Tfrm_main = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    colID: TIntegerColumn;
    colNomeSituacao: TStringColumn;
    procedure Button1Click(Sender: TObject);
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
{$R *.iPhone55in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure Tfrm_main.Button1Click(Sender: TObject);
var
  oCol : TColumn;
begin
  with oApp.oConn.getDataSet('select * from gen_situacao') do
  begin
    while not Eof do
    begin
      StringGrid1.Cells[0, RecNo-1] := FieldByName('id').AsString;
      StringGrid1.Cells[1, RecNo-1] := FieldByName('nm_situacao').AsString;
      Next;
    end;
  end;
end;

end.
