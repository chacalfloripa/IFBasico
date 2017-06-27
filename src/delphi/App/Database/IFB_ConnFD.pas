unit IFB_ConnFD;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, ormbr.factory.interfaces,
  ormbr.container.clientdataset, ormbr.container.dataset.interfaces,
  ormbr.types.database, ormbr.factory.firedac, ormbr.ddl.commands,
  ormbr.database.abstract, ormbr.modeldb.compare, ormbr.database.compare,
  ormbr.database.interfaces, ormbr.dml.generator.sqlite, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI;

type
  TIFB_ConnFD = class
  private
    { Private declarations }
  public
    FDConn: TFDConnection;
    oConn: IDBConnection;
    function connect:Boolean;
    { Public declarations }
  end;

implementation

{ TIFB_ConnFD }

function TIFB_ConnFD.connect: Boolean;
var
  oManager: IDatabaseCompare;
  cDDL: TDDLCommand;
begin
  Result := False;
  try
    if not Assigned(FDConn) then
      FDConn := TFDConnection.Create(nil);
    //
(*    FDConn.Params.DriverID := 'FB';
    FDConn.Params.Database := 'C:\Users\ismael\Documents\IFBasico\data\data.fdb';
    FDConn.Params.UserName := 'SYSDBA';
    FDConn.Params.Password := 'masterkey';
    FDConn.Params.add('Server=127.0.0.1');
    FDConn.Params.add('Port=3050');
    FDConn.Connected := True; *)

    FDConn.CloneConnection;
    FDConn.Params.DriverID := 'SQLite';
    FDConn.Params.Database := 'C:\Users\ismael\Documents\IFBasico\data\data.db3';
    FDConn.Params.UserName := '';
    FDConn.Params.Password := '';

    //
    if not Assigned(oConn) then
    begin
      oConn := TFactoryFireDAC.Create(FDConn, dnSQLite);
      oManager := TModelDbCompare.Create(oConn);
      oManager.CommandsAutoExecute := True;
      oManager.BuildDatabase;
      //oConn.SetCommandMonitor(TFSQLMonitor.GetInstance);
    end;
    //
    Result := FDConn.Connected;
  except
    //
  end;
end;

end.
