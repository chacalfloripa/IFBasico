unit dm_connect;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  Tdtm_connect = class(TDataModule)
    FDCon_01: TFDConnection;
  private
    { Private declarations }
  public
    function connect:Boolean;
    { Public declarations }
  end;

var
  dtm_connect: Tdtm_connect;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdtm_connect }

function Tdtm_connect.connect: Boolean;
begin
  Result := False;
  try
    FDCon_01.CloneConnection;
    FDCon_01.Params.DriverID := 'FB';
    FDCon_01.Params.Database := 'C:\eSesPark Dev\dados\dados.fdb';
    FDCon_01.Params.UserName := 'SYSDBA';
    FDCon_01.Params.Password := '123456';
    FDCon_01.Params.add('Server=127.0.0.1');
    FDCon_01.Params.add('Port=3050');
    FDCon_01.Connected := True;
    Result := FDCon_01.Connected;
  except
    //
  end;
end;

end.
