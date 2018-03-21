unit IFB_ConnFD;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, IFB_Conn, IFB_FuncoesINI, FireDAC.Phys.MySQL,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TIFB_ConnFD = class(TIFB_Conn)
  private
    FFDDriverLink : TFDPhysDriverLink;
    FDGUIxWaitCursor : TFDGUIxWaitCursor;
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
    function connect:Boolean; override;
    function connected:Boolean; override;
    function getDataSet(const SQL : string):TDataSet; override;
    procedure ExecSQL(const SQL : string); override;
    procedure ExecScript(const SQLs: array of string); override;
    property DriverID : string read getDriver write setDriver;
    property Database : string read getDatabase write setDatabase;
    property UserName : string read getUserName write setUserName;
    property Password : string read getPassword write setPassword;
    { Public declarations }
  end;

implementation

uses
  App;
{ TIFB_ConnFD }

function TIFB_ConnFD.connect: Boolean;
begin
  Result := False;
  try
    if not Assigned(FDConn) then
    begin
      FDConn := TFDConnection.Create(nil);
      FDGUIxWaitCursor := TFDGUIxWaitCursor.Create(nil);
    end;
    //
    FDConn.Connected := False;
    FDConn.Params.DriverID := DriverID;
    FDConn.Params.Database := Database;
    FDConn.Params.UserName := UserName;
    FDConn.Params.Password := Password;
    FDConn.Params.Add(oIFB_FuncoesINI.getStringListOfArqINI(DataBaseFileConf, ConnName+'_PARAMS').Text);
    FDConn.Connected := True;
    Result := FDConn.Connected;
  except
  end;
end;

function TIFB_ConnFD.connected: Boolean;
begin
  Result := False;
  if Assigned(FDConn) then
    Result := FDConn.Connected;
end;

procedure TIFB_ConnFD.ExecScript(const SQLs: array of string);
var
  i : integer;
  oQuery : TFDScript;
begin
  inherited;
  oQuery := TFDScript.Create(nil);
  try
    try
      oQuery.Connection := FDConn;
      for i := 0 to Length(SQLs)-1 do
        oQuery.SQLScripts.Add.SQL.Text := SQLs[i];
      oQuery.ExecuteAll;
    except
    end;
  finally
    FreeAndNil(oQuery);
  end;
end;

procedure TIFB_ConnFD.ExecSQL(const SQL: string);
var
  oQuery : TFDQuery;
begin
  inherited;
  oQuery := TFDQuery.Create(nil);
  try
    try
    FDConn.RefreshMetadataCache();
      oQuery.Connection := FDConn;
      oQuery.SQL.Text := SQL;
      oQuery.ExecSQL;
    except
    end;
  finally
    FreeAndNil(oQuery);
  end;
end;

function TIFB_ConnFD.getDatabase: string;
begin
  Result := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'database', '');
  if Trim(Result) = '' then
  begin
    {$IFDEF MSWINDOWS}
      Result := oApp.AppHome+'data'+PathDelim+'data.db';
    {$ENDIF MSWINDOWS}
    {$IFDEF ANDROID}
      Result := oApp.AppHome+'data'+PathDelim+'data.db';
      if not DirectoryExists(oApp.AppHome+'data') then
      begin
        CreateDir(oApp.AppHome+'data');
      end;
    {$ENDIF ANDROID}
    Database := Result;
  end;
end;

function TIFB_ConnFD.getDataSet(const SQL: string): TDataSet;
begin
  Result := TFDQuery.Create(nil);
  TFDQuery(Result).Connection := FDConn;
  TFDQuery(Result).SQL.Text := SQL;
  Result.Open;
end;

function TIFB_ConnFD.getDriver: string;
begin
  Result := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'driverid', '');
  if Trim(Result) = '' then
  begin
    Result := 'sqlite';
    DriverID := Result;
  end;
  if Result = 'FB' then
  begin
    Driver := 'FB';
    FFDDriverLink := TFDPhysFBDriverLink.Create(nil);
    TFDPhysFBDriverLink(FFDDriverLink).VendorHome := oApp.AppLibPath+'\firebird';
    TFDPhysFBDriverLink(FFDDriverLink).VendorLib := 'fbclient.dll';
  end;
  if Result = 'sqlite' then
  begin
    Driver := 'sqlite';
  end;
  if Result = 'MYSQL' then
  begin
    Driver := 'MYSQL';
    FFDDriverLink := TFDPhysMySQLDriverLink.Create(nil);
    TFDPhysMySQLDriverLink(FFDDriverLink).VendorHome := oApp.AppLibPath+'\mysql';
    TFDPhysMySQLDriverLink(FFDDriverLink).VendorLib := 'libmysql.dll';
  end;
end;

function TIFB_ConnFD.getPassword: string;
begin
  Result := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'password', '');
end;

function TIFB_ConnFD.getUserName: string;
begin
  Result := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'username', '');
end;

procedure TIFB_ConnFD.setDatabase(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam(DataBaseFileConf, ConnName, 'databse', Value);
end;

procedure TIFB_ConnFD.setDriver(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam(DataBaseFileConf, ConnName, 'driverid', Value);
end;

procedure TIFB_ConnFD.setPassword(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam(DataBaseFileConf, ConnName, 'password', Value);
end;

procedure TIFB_ConnFD.setUserName(const Value: string);
begin
  oIFB_FuncoesINI.setINIParam(DataBaseFileConf, ConnName, 'username', Value);
end;

end.
