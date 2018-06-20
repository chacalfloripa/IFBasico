unit IFB_ConnFIBPlus;

interface

uses
  System.SysUtils, System.Classes, DB, IFB_Conn, IFB_FuncoesINI,
  FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, FIBDataSet, pFIBDataSet,
  pFIBScripter;

type
  TIFB_ConnFIBPlus = class(TIFB_Conn)
  private
    { Private declarations }
  public
    FBConn: TpFIBDatabase;
    FDefTrans : TpFIBTransaction;
    function connect:Boolean; override;
    function getDataSet(const TableName : string):TDataSet; override;
    function getQuery(const SQL : string):TDataSet; override;
    procedure ExecSQL(const SQL : string); override;
    procedure ExecScript(const SQLs : array of string); override;
    function connected:Boolean; override;
    { Public declarations }
  end;

implementation

{ TIFB_ConnFIBPlus }

function TIFB_ConnFIBPlus.connect: Boolean;
begin
  Result := False;
  try
    if not Assigned(FBConn) then
      FBConn := TpFIBDatabase.Create(nil);
    if not Assigned(FDefTrans) then
    begin
      FDefTrans := TpFIBTransaction.Create(nil);
      FDefTrans.DefaultDatabase := FBConn;
    end;
    //
    Driver := ctDriveFB;
    FBConn.Close;
    FBConn.DefaultTransaction := FDefTrans;
    FBConn.DBName := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'database', 'C:\IFBasico\dados\dados.fdb');
    FBConn.SQLDialect := StrToInt(oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'SQLDialect', '3'));
    FBConn.LibraryName := oIFB_FuncoesINI.getINIParam(DataBaseFileConf, ConnName, 'LibraryName', '');
    FBConn.DBParams.Text := oIFB_FuncoesINI.getStringListOfArqINI(DataBaseFileConf, ConnName+'_PARAMS').Text;
    FBConn.Connected := True;
    Result := FBConn.Connected;
  except
    //
  end;
end;

function TIFB_ConnFIBPlus.connected: Boolean;
begin
  Result := FBConn.Connected;
end;

procedure TIFB_ConnFIBPlus.ExecScript(const SQLs: array of string);
var
  oSQLScript : TpFIBScripter;
  i : Integer;
begin
  inherited;
  try
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
  end;
end;

procedure TIFB_ConnFIBPlus.ExecSQL(const SQL: string);
var
  qry_temp : TpFIBQuery;
begin
  inherited;
  qry_temp := TpFIBQuery.Create(nil);
  try
    try
      qry_temp.Database := FBConn;
      qry_temp.SQL.Add(SQL);
      qry_temp.Transaction.StartTransaction;
      qry_temp.ExecQuery;
      qry_temp.Transaction.Commit;
    except
      on E: Exception do
      begin
        if qry_temp.Transaction.Active then
          if qry_temp.Transaction.InTransaction then
            qry_temp.Transaction.Rollback;
      end;
    end;
  finally
     qry_temp.Close;
     FreeAndNil(qry_temp);
  end;
end;

function TIFB_ConnFIBPlus.getDataSet(const TableName: string): TDataSet;
begin
  result := TpFIBDataSet.Create(nil);
  //
  TpFIBDataSet(result).DefaultFormats.DateTimeDisplayFormat := 'dd/mm/yyyy hh:mm';
  TpFIBDataSet(result).DefaultFormats.DisplayFormatDate := 'dd/mm/yyyy';
  TpFIBDataSet(result).DefaultFormats.DisplayFormatTime := 'hh:mm';
  //
  TpFIBDataSet(result).Database := FBConn;
  TpFIBDataSet(result).SQLs.SelectSQL.Text  := 'select * from '+TableName;
  TpFIBDataSet(result).SQLs.UpdateSQL.Text  := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skModify);
  TpFIBDataSet(result).SQLs.InsertSQL.Text  := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skInsert);
  TpFIBDataSet(result).SQLs.DeleteSQL.Text  := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skDelete);
  TpFIBDataSet(result).SQLs.RefreshSQL.Text := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skRefresh);
  TpFIBDataSet(result).AutoCommit := True;
  Result.Open;
  TpFIBDataSet(result).FetchAll;
end;

function TIFB_ConnFIBPlus.getQuery(const SQL: string): TDataSet;
begin
  result := TpFIBDataSet.Create(nil);
  //
  TpFIBDataSet(result).DefaultFormats.DateTimeDisplayFormat := 'dd/mm/yyyy hh:mm';
  TpFIBDataSet(result).DefaultFormats.DisplayFormatDate := 'dd/mm/yyyy';
  TpFIBDataSet(result).DefaultFormats.DisplayFormatTime := 'hh:mm';
  //
  TpFIBDataSet(result).Database := FBConn;
  TpFIBDataSet(result).SQLs.SelectSQL.Text  := SQL;
  TpFIBDataSet(result).AutoCommit := True;
  Result.Open;
  TpFIBDataSet(result).FetchAll;
end;

end.
