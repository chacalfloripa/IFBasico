unit IFB_ConnZeos;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, DB, IFB_Conn, IFB_FuncoesINI, ZConnection, ZDataset;

type

  { TIFB_ConnZeos }

  TIFB_ConnZeos = class(TIFB_Conn)
  private
    FDBConn: TZConnection;
    { Private declarations }
  public
    function connect:Boolean; override;
    function Disconnect:Boolean; override;
    function getDataSet(const TableName : string):TIFB_Table; override;
    function getQuery(const SQL : string):TIFB_Query; override;
    procedure ExecSQL(const SQL : string); override;
    procedure ExecScript(const SQLs : array of string); override;
    function connected:Boolean; override;
    function getServeTime : TTime; override;
    function getServeDate : TDate; override;
    function getServeDateTime : TDateTime; override;
    { Public declarations }
  end;

  { TIFB_DataSetZeos }

  TIFB_TableZeos = class(TZTable, IIFB_DataSet, IIFB_Table)
  private
  public

  end;

  TIFB_QueryZeos = class(TZQuery, IIFB_DataSet, IIFB_Query)
  private
  public
  end;

implementation

uses
  App;

{ TIFB_DataSetZeos }

{ TIFB_ConnZeos }

function TIFB_ConnZeos.connect: Boolean;
begin
  Result := False;
  try
    if not Assigned(FDBConn) then
      FDBConn := TZConnection.Create(nil);
    Driver := ctDriveFB;
    FDBConn.Disconnect;
    FDBConn.Protocol := 'firebird-3.0';
    FDBConn.HostName := oApp.FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'server', '127.0.0.1');
    FDBConn.Port := oApp.FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'port', '3050').ToInteger;
    FDBConn.Database := oApp.FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'database', 'C:\'+oApp.SiglaEmpresa+'\'+oApp.SiglaProjeto+'\data\dados.fdb');
    FDBConn.LibraryLocation := oApp.FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'LibraryName', '');
    FDBConn.User := oApp.FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'usuer', '');
    FDBConn.Password := oApp.FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'password', '');;
    FDBConn.Connect;
    Result := FDBConn.Connected;
  except
    //
  end;
end;

function TIFB_ConnZeos.Disconnect: Boolean;
begin
  FDBConn.Disconnect;
end;

function TIFB_ConnZeos.connected: Boolean;
begin
  Result := FDBConn.Connected;
end;

procedure TIFB_ConnZeos.ExecScript(const SQLs: array of string);
var
//  oSQLScript : TpFIBScripter;
  i : Integer;
begin

(*  try
    oSQLScript := TpFIBScripter.Create(nil);
    try
      //
      oSQLScript.Database := FBConn;
      for i := 0 to Length(SQLs)-1 do
        oSQLScript.Script.Add(SQLs[i]);
      oSQLScript.ExecuteScript();
    except
    end;
  finally
    FreeAndNil(oSQLScript);
  end; *)
end;

procedure TIFB_ConnZeos.ExecSQL(const SQL: string);
var
  qry_temp : TIFB_QueryZeos;
begin
  TDataSet(qry_temp) := getQuery('');
  try
    try
      qry_temp.SQL.Add(SQL);
      qry_temp.ExecSQL;
    except
    end;
  finally
     qry_temp.Close;
     FreeAndNil(qry_temp);
  end;
end;

function TIFB_ConnZeos.getDataSet(const TableName: string): TIFB_Table;
begin
  TDataSet(Result) := TIFB_TableZeos.Create(nil);
  TIFB_TableZeos(Result).Connection := FDBConn;
  TIFB_TableZeos(Result).TableName := TableName;
end;

function TIFB_ConnZeos.getQuery(const SQL: string): TIFB_Query;
begin
  TDataSet(Result) := TIFB_QueryZeos.Create(nil);
  TIFB_QueryZeos(Result).Connection := FDBConn;
  TIFB_QueryZeos(Result).SQL.Text := SQL;
end;

function TIFB_ConnZeos.getServeDate: TDate;
begin
  Result := getServeDateTime;
end;

function TIFB_ConnZeos.getServeDateTime: TDateTime;
const
  ctSQL_FB = 'select first 1 current_timestamp as dh from RDB$DATABASE';
var
  qry_temp : TIFB_Query;
begin
  qry_temp := getQuery(ctSQL_FB);
  try
    qry_temp.Open;
    Result := qry_temp.FieldByName('dh').AsDateTime;
  finally
    FreeAndNil(qry_temp);
  end;
end;

function TIFB_ConnZeos.getServeTime: TTime;
begin
  Result := getServeDateTime;
end;

end.
