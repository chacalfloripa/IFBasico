unit IFB_ConnSQLDB;

interface

{$mode objfpc}{$H+}

uses
  SysUtils, Classes, DB, IFB_Conn, IFB_FuncoesINI, sqldb, IBConnection, sqldblib;

type

  { TIFB_ConnSQLDB }

  TIFB_ConnSQLDB = class(TIFB_Conn)
  private
    FLibraryLoader : TSQLDBLibraryLoader;
    { Private declarations }
  public
    FConn: TIBConnection;
    FDefTrans : TSQLTransaction;
    function connect:Boolean; override;
    function disconnect:Boolean; override;
    function getDataSet(const TableName : string):TIFB_Table; override;
    function getQuery(const SQL : string):TIFB_Query; override;
    procedure ExecSQL(const SQL : string); override;
    procedure ExecScript(const SQLs : array of string); override;
    function connected:Boolean; override;
    function getServeTime : TTime; virtual;
    function getServeDate : TDate; virtual;
    function getServeDateTime : TDateTime; virtual;
    { Public declarations }
  end;

implementation

uses
  App;

{ TIFB_ConnSQLDB }

function TIFB_ConnSQLDB.connect: Boolean;
begin
  Result := False;
  try
    if not Assigned(FLibraryLoader) then
    begin
      FLibraryLoader := TSQLDBLibraryLoader.Create(nil);
      FLibraryLoader.ConnectionType:= 'firebird';
      FLibraryLoader.LibraryName:= oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'LibraryName', '');
    end;
    if not Assigned(FConn) then
      FConn := TIBConnection.Create(nil);
    if not Assigned(FDefTrans) then
      FDefTrans := TSQLTransaction.Create(nil);
    //
    Driver := ctDriveFB;
    FConn.Connected:= False;
    FConn.Transaction := FDefTrans;
    FConn.KeepConnection:= True;
    FConn.HostName:= oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'server', '127.0.0.1');
    FConn.Port := StrToInt(oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'port', '3050'));
    FConn.Dialect := StrToInt(oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'SQLDialect', '3'));
    FConn.DatabaseName := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'database', 'C:\'+oApp.SiglaEmpresa+'\'+oApp.SiglaProjeto+'\data\dados.fdb');
    FConn.UserName:= oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'username', 'SYSDBA');
    FConn.Password:= oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'password', 'masterkey');
    FConn.Connected := True;
    FDefTrans.DataBase := FConn;
    Result := FConn.Connected;
  except
    //
  end;
end;

function TIFB_ConnSQLDB.Disconnect: Boolean;
begin
  FConn.Connected:= False;
  Result := Connected;
end;

function TIFB_ConnSQLDB.connected: Boolean;
begin
  Result := FConn.Connected;
end;

procedure TIFB_ConnSQLDB.ExecScript(const SQLs: array of string);
var
  oSQLScript : TSQLScript;
  i : Integer;
begin
  try
    oSQLScript := TSQLScript.Create(nil);
    try
      //
      oSQLScript.DataBase := FConn;
      for i := 0 to Length(SQLs)-1 do
        oSQLScript.Script.Add(SQLs[i]);
      oSQLScript.ExecuteScript();
    except
    end;
  finally
    FreeAndNil(oSQLScript);
  end;
end;

procedure TIFB_ConnSQLDB.ExecSQL(const SQL: string);
var
  qry_temp : TSQLScript;
begin
  qry_temp := TSQLScript.Create(nil);
  try
    try
      qry_temp.Database := FConn;
      qry_temp.Script.Add(SQL);
      qry_temp.ExecuteScript;
    except
      on E: Exception do
      begin
      end;
    end;
  finally
     FreeAndNil(qry_temp);
  end;
end;

function TIFB_ConnSQLDB.getDataSet(const TableName: string): TIFB_Table;
begin
  TDataSet(result) := TSQLQuery.Create(nil);
  TSQLQuery(^result).DataBase := FConn;
  TSQLQuery(result).SQL.Text  := 'select * from '+TableName;
  Result.Open;
end;

function TIFB_ConnSQLDB.getQuery(const SQL: string): TIFB_Query;
begin
  TDataSet(result) := TSQLQuery.Create(nil);
  TSQLQuery(result).Database := FConn;
  TSQLQuery(result).SQL.Text  := SQL;
end;

function TIFB_ConnSQLDB.getServeDate: TDate;
begin
  Result := getServeDateTime;
end;

function TIFB_ConnSQLDB.getServeDateTime: TDateTime;
const
  ctSQL = 'select first 1 current_timestamp as dh from RDB$DATABASE';
var
  qry_temp : TDataSet;
begin
  qry_temp := getQuery(ctSQL);
  try
     Result := qry_temp.FieldByName('dh').AsDateTime;
  finally
    FreeAndNil(qry_temp);
  end;
end;

function TIFB_ConnSQLDB.getServeTime: TTime;
begin
  Result := getServeDateTime;
end;

end.
