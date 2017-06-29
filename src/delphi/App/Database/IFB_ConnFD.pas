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
  FireDAC.Comp.UI, IFB_Conn, IFB_FuncoesINI;

type
  TIFB_ConnFD = class(TIFB_Conn)
  private
    procedure setDriver(const Value: string);
    procedure setPassword(const Value: string);
    procedure setUserName(const Value: string);
    function getDriver: string;
    function getPassword: string;
    function getUserName: string;
    function getDatabase: string;
    procedure setDatabase(const Value: string);
    { Private declarations }
  public
    FDConn: TFDConnection;
    oConn: IDBConnection;
    function connect:Boolean;
    property DriverID : string read getDriver write setDriver;
    property Database : string read getDatabase write setDatabase;
    property UserName : string read getUserName write setUserName;
    property Password : string read getPassword write setPassword;
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
    FDConn.CloneConnection;
    FDConn.Params.DriverID := DriverID;
    FDConn.Params.Database := Database;
    FDConn.Params.UserName := UserName;
    FDConn.Params.Password := Password;
    FDConn.Params.Add(oIFB_FuncoesINI.getStringListOfArqINI('..\conf\database.ini', ConnName+'_PARAMS').Text);
    //
    FDConn.Connected := True;
    //
    if not Assigned(oConn) then
    begin
      oConn := TFactoryFireDAC.Create(FDConn, dnSQLite);
      oManager := TModelDbCompare.Create(oConn);
      oManager.CommandsAutoExecute := True;
      oManager.BuildDatabase;
    end;
    //
    Result := FDConn.Connected;
  except
    //
  end;
end;

function TIFB_ConnFD.getDatabase: string;
begin
  Result := oIFB_FuncoesINI.getINIParam('..\conf\database.ini', ConnName, 'database', '');
end;

function TIFB_ConnFD.getDriver: string;
begin
  Result := oIFB_FuncoesINI.getINIParam('..\conf\database.ini', ConnName, 'driverid', '');
end;

function TIFB_ConnFD.getPassword: string;
begin
  Result := oIFB_FuncoesINI.getINIParam('..\conf\database.ini', ConnName, 'password', '');
end;

function TIFB_ConnFD.getUserName: string;
begin
  Result := oIFB_FuncoesINI.getINIParam('..\conf\database.ini', ConnName, 'username', '');
end;

procedure TIFB_ConnFD.setDatabase(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam('..\conf\database.ini', ConnName, 'databse', Value);
end;

procedure TIFB_ConnFD.setDriver(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam('..\conf\database.ini', ConnName, 'driverid', Value);
end;

procedure TIFB_ConnFD.setPassword(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam('..\conf\database.ini', ConnName, 'password', Value);
end;

procedure TIFB_ConnFD.setUserName(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam('..\conf\database.ini', ConnName, 'username', Value);
end;

end.
