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
  FireDAC.Comp.UI, IFB_Conn, IFB_FuncoesINI, IFB_App;

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
    FDConn.Params.Add(oIFB_FuncoesINI.getStringListOfArqINI(DataBaseFileConf, ConnName+'_PARAMS').Text);
    FDConn.Connected := True;
    Result := FDConn.Connected;
  except
    //
  end;
end;

function TIFB_ConnFD.getDatabase: string;
begin
  Result := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'database', '');
  if Trim(Result) = '' then
  begin
    {$IFDEF MSWINDOWS}
      Result := FIFB_App.AppHome+'data'+PathDelim+'data.db';
    {$ENDIF MSWINDOWS}
    {$IFDEF ANDROID}
      Result := FIFB_App.AppHome+'data'+PathDelim+'data.db';
      if not DirectoryExists(FIFB_App.AppHome+'data') then
      begin
        CreateDir(FIFB_App.AppHome+'data');
      end;
    {$ENDIF ANDROID}
    Database := Result;
  end;
end;

function TIFB_ConnFD.getDriver: string;
begin
  Result := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'driverid', '');
  if Trim(Result) = '' then
  begin
    Result := 'sqlite';
    DriverID := Result;
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
