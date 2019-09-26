unit IFB_Conn;

interface

uses
  System.SysUtils, System.Classes, DB, strUtils;

const
  ctDriveFB = 'FB';
  ctDriveSQLite = 'SQLite';

type
  TIFB_Conn = class
  private
    FConnName: string;
    FDriver: string;
    FCreateIDLargeint: Boolean;
    procedure setConnName(const Value: string);
    function getDataBaseFileConf: string;
    function getStrSQLFieldType(const DataType : TFieldType; const Size : Integer = 0;
                                const Required : Boolean = False):String;

    { Private declarations }
  public
    constructor Create(const ConnName:  string);
    function connect:Boolean; virtual; abstract;
    function connected:Boolean; virtual; abstract;
    procedure ExecSQL(const SQL : string); virtual; abstract;
    procedure ExecScript(const SQLs : array of string); virtual; abstract;
    function getDataSet(const TableName : string):TDataSet; virtual; abstract;
    function getQuery(const SQL : string):TDataSet; virtual; abstract;
    procedure addTable(const TableName: string); overload;  virtual;
    procedure addTable(const TableName: string;
                       const CreatePK : Boolean;
                       const AutoInc : Boolean); overload;  virtual;
    procedure addField(const TableName: string;
                       const FieldName: string;
                       const FieldType: TFieldType;
                       const Size : Integer;
                       const Requerid : Boolean); virtual;
    function addForeignKey(const ForeignKeyName:String;
                           const TableName : String;
                           const FieldName : String;
                           const TableNameRef : String;
                           const FieldNameRef : String):Boolean; virtual;
	  procedure DropTable(const TableName : string);
    procedure setFieldPrimaryKey(const TableName: string;
                                 const FieldName: string);
    procedure setDefaultValue(const TableName: string;
                              const FieldName: string;
                              const Value : string);
    function tableExist(const TableName: String): Boolean;
    function fieldExist(const TableName: string;
                        const FieldName: string):Boolean;
    function triggerExist(const TableName: string;
                          const TriggerName: string):Boolean;
    function ForeignKeyExist(const ForeignKeyName: String): Boolean;
    function generatorExist(const GenName: string): Boolean;
    function primaryKeyExist(const PrimaryKeyName: string): Boolean;
    function getSeq(const SeqName:string) : Variant;
    function getServeTime : TTime; virtual;
    function getServeDate : TDate; virtual;
    function getServeDateTime : TDateTime; virtual;
    property ConnName : string read FConnName  write setConnName;
    property Driver : string read FDriver  write FDriver;
    property DataBaseFileConf : string read getDataBaseFileConf;
    property CreateIDLargeint : Boolean read FCreateIDLargeint write FCreateIDLargeint;
    { Public declarations }
  end;

implementation

uses
  App;

{ TIFB_Conn }

procedure TIFB_Conn.addField(const TableName, FieldName: string;
  const FieldType: TFieldType; const Size: Integer; const Requerid: Boolean);
begin
  ExecSQL('alter table '+UpperCase(TableName)+' add '+UpperCase(FieldName)+' '+getStrSQLFieldType(FieldType, Size, Requerid) );
end;

procedure TIFB_Conn.addTable(const TableName: string);
begin
  addTable(TableName, True, True);
end;

function TIFB_Conn.addForeignKey(const ForeignKeyName, TableName, FieldName,
  TableNameRef, FieldNameRef: String): Boolean;
begin
  if not ForeignKeyExist(ForeignKeyName) then
  begin
    if tableExist(TableName) and
       tableExist(TableNameRef) then
    begin
      if fieldExist(TableName, FieldName) and
         fieldExist(TableNameRef, FieldNameRef) then
      begin
        ExecSQL(' ALTER TABLE '+UpperCase(TableName)+
                    ' ADD CONSTRAINT '+UpperCase(ForeignKeyName)+
                    ' FOREIGN KEY ('+UpperCase(FieldName)+') '+
                    ' REFERENCES '+UpperCase(TableNameRef)+'('+UpperCase(FieldNameRef)+')'+
                    ' USING INDEX IDX_'+UpperCase(ForeignKeyName));
      end;
    end;
  end;
end;

procedure TIFB_Conn.addTable(const TableName: string; const CreatePK: Boolean;
  const AutoInc : Boolean);
var
  sSQL : string;
begin
  sSQL := '';
  sSQL := sSQL + 'create table '+UpperCase(TableName)+' ';
  if CreateIDLargeint then
    sSQL := sSQL + ' (ID '+getStrSQLFieldType(ftLargeint, 0, True)
  else
    sSQL := sSQL + ' (ID '+getStrSQLFieldType(ftInteger, 0, True);
  // SQLite
  if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
  begin
    if not AutoInc then
      sSQL := sSQL + ', PRIMARY KEY(ID) );'
    else
      sSQL := sSQL + IfThen(AutoInc, ' PRIMARY KEY AUTOINCREMENT); ', '');
  end;
  // Firebird
  if (UpperCase(Driver) = UpperCase(ctDriveFB)) then
  begin
    sSQL := sSQL + '); ';
  end;
  ExecSQL(sSQL);
  // Firebird
  if (UpperCase(Driver) = UpperCase(ctDriveFB)) then
  begin
    sSQL := ' ALTER TABLE '+ UpperCase(TableName);
    sSQL := sSQL + ' ADD CONSTRAINT PK_'+UpperCase( TableName )+'_ID';
    sSQL := sSQL + ' PRIMARY KEY ( ID ); ';
    ExecSQL(sSQL);
  end;
end;

constructor TIFB_Conn.Create(const ConnName: string);
begin
  Self.ConnName := ConnName;
  FCreateIDLargeint := False;
end;

procedure TIFB_Conn.DropTable(const TableName: string);
var
  sSQL : string;
begin
  sSQL := 'drop table '+TableName;
  ExecSQL(sSQL);
end;

function TIFB_Conn.tableExist(const TableName: String): Boolean;
begin
  Result := False;
  try
    with getQuery('select RDB$RELATION_NAME from RDB$RELATIONS where RDB$RELATION_NAME = '+QuotedStr(UpperCase(TableName))) do
    begin
      if not IsEmpty then
        Result := True;
      Free;
    end;
  except
  end;
end;

function TIFB_Conn.fieldExist(const TableName, FieldName: string): Boolean;
begin
  Result := False;
  try
    if tableExist(TableName) then
      if Assigned(getQuery('select '+ UpperCase(FieldName) +' from '+UpperCase(TableName)+ ' where ID is null ')) then
        Result := True;
  except
  end;
end;

function TIFB_Conn.ForeignKeyExist(const ForeignKeyName: String): Boolean;
var
  sSQL : string;
begin
  if (UpperCase(Driver) = UpperCase(ctDriveFB)) then
  begin
    Result := False;
    sSQL := 'select 0 '+
            '  from RDB$RELATION_CONSTRAINTS  '+
            ' where RDB$CONSTRAINT_NAME =  '+ QuotedStr(ForeignKeyName);
    with getQuery(sSQL) do
    begin
      if not IsEmpty then
        Result := True;
      Close;
      Free;
    end;
  end;
end;

function TIFB_Conn.generatorExist(const GenName: string): Boolean;
const
  ctSQLFB = 'select a.RDB$GENERATOR_NAME '+
            '  from RDB$GENERATORS a '+
            ' where a.RDB$GENERATOR_NAME = ';
var
  qry_temp : TDataSet;
begin
  Result := False;
  if Driver = ctDriveFB then
  begin
    qry_temp := getQuery(ctSQLFB+QuotedStr(GenName));
    try
      qry_temp.Open;
      if not qry_temp.IsEmpty then
        Result := True;
    finally
      FreeAndNil(qry_temp);
    end;
  end;
end;

function TIFB_Conn.getDataBaseFileConf: string;
begin
  Result := oApp.AppConfPath+PathDelim+'database.ini';
end;

function TIFB_Conn.getSeq(const SeqName: string): Variant;
begin

end;

function TIFB_Conn.getServeDate: TDate;
begin

end;

function TIFB_Conn.getServeDateTime: TDateTime;
begin

end;

function TIFB_Conn.getServeTime: TTime;
begin

end;

function TIFB_Conn.getStrSQLFieldType(const DataType: TFieldType; const Size: Integer;
  const Required: Boolean): String;
begin
  if DataType = ftBoolean then
  begin
    if Driver = ctDriveFB then
      Result := 'SMALLINT'+IfThen(Required, ' NOT NULL', '');;
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      Result := 'BOOLEAN'+IfThen(Required, ' NOT NULL DEFAULT 0 ', '');;
  end;
  if DataType = ftCurrency then
  begin
    if Driver = ctDriveFB then
      Result := 'NUMERIC(12,2)'+IfThen(Required, ' NOT NULL', '');
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      Result := 'NUMERIC'+IfThen(Required, ' NOT NULL  DEFAULT 0 ', '');
  end;
  if DataType = ftTime then
  begin
    if Driver = ctDriveFB then
      Result := 'TIME'+IfThen(Required, ' NOT NULL', '');
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      Result := 'DATETIME';
  end;
  if DataType = ftDate then
    Result := 'DATE'+IfThen(Required, ' NOT NULL', '');;
  if DataType = ftDateTime then
  begin
    if Driver = ctDriveFB then
      Result := 'TIMESTAMP'+IfThen(Required, ' NOT NULL', '');;
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      Result := 'DATETIME';
  end;
  if DataType = ftInteger then
  begin
    if Driver = ctDriveFB then
      Result := 'INT'+IfThen(Required, ' NOT NULL', '');
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      Result := 'INTEGER'+IfThen(Required, ' NOT NULL DEFAULT 0 ', '');
  end;
  if DataType = ftSmallint then
  begin
    if Driver = ctDriveFB then
      Result := 'smallint'+IfThen(Required, ' NOT NULL', '');
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      raise Exception.Create('Tipo ftSmallint não implementado para SQLite.');
  end;
  if DataType = ftLargeint then
    Result := 'BIGINT'+IfThen(Required, ' NOT NULL', '');
  if DataType = ftString then
  begin
    if Driver = ctDriveFB then
      Result := 'VARCHAR('+IntToStr(Size)+') CHARACTER SET ISO8859_1 '+IfThen(Required, 'NOT NULL', '')+' COLLATE PT_BR ';
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) then
      Result := ' TEXT ' +  IfThen(Required, 'NOT NULL DEFAULT '''' ', '');
  end;
  if DataType = ftBlob then
    Result := 'BLOB SUB_TYPE 1 SEGMENT SIZE 16384 CHARACTER SET ISO8859_1 ';
end;

function TIFB_Conn.primaryKeyExist(const PrimaryKeyName: string): Boolean;
begin

end;

procedure TIFB_Conn.setConnName(const Value: string);
begin
  FConnName := Value;
end;

procedure TIFB_Conn.setDefaultValue(const TableName, FieldName : string;
  const Value: string);
begin
  ExecSQL('alter table '+TableName+' alter '+FieldName+' set default '+Value+' ');
end;

procedure TIFB_Conn.setFieldPrimaryKey(const TableName, FieldName: string);
var
  sText : String;
begin
  sText := '';
  if fieldExist(TableName, FieldName) then
  begin
    try
      sText := 'ALTER TABLE '+ UpperCase(TableName);
      sText := sText + ' ADD CONSTRAINT PK_'+UpperCase( TableName )+'_ID';
      sText := sText + ' PRIMARY KEY ( '+FieldName+' ) ';
      ExecSQL(sText);
    except
    end;
  end;
end;

function TIFB_Conn.triggerExist(const TableName, TriggerName: string): Boolean;
var
  sSQL : string;
begin
  if (UpperCase(Driver) = UpperCase(ctDriveFB)) then
  begin
    Result := False;
    sSQL := 'select RDB$TRIGGER_NAME, '+
            '       RDB$RELATION_NAME '+
            '  from RDB$TRIGGERS  '+
            ' where RDB$RELATION_NAME =  '+ QuotedStr(TableName)+
            '   and RDB$TRIGGER_NAME =  '+ QuotedStr(TriggerName);
    with getDataSet(sSQL) do
    begin
      if not IsEmpty then
        Result := True;
      Free;
    end;
  end;
end;

end.
