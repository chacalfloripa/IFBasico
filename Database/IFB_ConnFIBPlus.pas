unit IFB_ConnFIBPlus;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TIFB_ConnFIBPlus = class
  private
    FDCon_01: TFDConnection;
    { Private declarations }
  public
    function connect:Boolean;
    { Public declarations }
  end;

implementation

{ TIFB_ConnFIBPlus }

function TIFB_ConnFIBPlus.connect: Boolean;
begin
  Result := False;
  try
    if not Assigned(FDCon_01) then
      FDCon_01 := TFDConnection.Create(nil);
    //
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
