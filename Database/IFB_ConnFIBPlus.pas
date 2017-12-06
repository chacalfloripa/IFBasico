unit IFB_ConnFIBPlus;

interface

uses
  System.SysUtils, System.Classes, DB, IFB_Conn, IFB_FuncoesINI,
  FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, FIBDataSet, pFIBDataSet;

type
  TIFB_ConnFIBPlus = class(TIFB_Conn)
  private
    { Private declarations }
  public
    FBConn: TpFIBDatabase;
    function connect:Boolean; override;
    function getDataSet(const TableName : string):TDataSet; override;
    procedure ExecSQL(const SQL : string); override;
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
    //
    Driver := ctDriveFB;
    FBConn.Close;
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

procedure TIFB_ConnFIBPlus.ExecSQL(const SQL: string);
var
  qry_temp : TpFIBQuery;
begin
  inherited;
  qry_temp := TpFIBQuery.Create(nil);
  try
    try
      qry_temp.Database := FBConn;
      qry_temp.Transaction := TpFIBTransaction.Create(nil);
      qry_temp.Transaction.DefaultDatabase := FBConn;
      qry_temp.SQL.Add(SQL);
      qry_temp.Transaction.StartTransaction;
      qry_temp.ExecQuery;
      qry_temp.Transaction.Commit;
    except
      on E: Exception do
      begin
        qry_temp.Transaction.Rollback;
      end;
    end;
  finally
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
  TpFIBDataSet(result).Transaction := TpFIBTransaction.Create(nil);
  TpFIBDataSet(result).Transaction.DefaultDatabase := FBConn;
  TpFIBDataSet(result).SQLs.SelectSQL.Text  := 'select * from '+TableName;
  TpFIBDataSet(result).SQLs.UpdateSQL.Text  := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skModify);
  TpFIBDataSet(result).SQLs.InsertSQL.Text  := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skInsert);
  TpFIBDataSet(result).SQLs.DeleteSQL.Text  := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skDelete);
  TpFIBDataSet(result).SQLs.RefreshSQL.Text := TpFIBDataSet(result).GenerateSQLText(TableName, 'ID', skRefresh);
  Result.Open;
  TpFIBDataSet(result).FetchAll;
end;

end.
