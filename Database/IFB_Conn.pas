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
    procedure setConnName(const Value: string);
    function getDataBaseFileConf: string;
    function getStrSQLFieldType(const DataType : TFieldType; const Size : Integer = 0;
                                const Required : Boolean = False):String;
    { Private declarations }
  public
    constructor Create(const ConnName:  string);
    function connect:Boolean; virtual; abstract;
    procedure ExecSQL(const SQL : string); virtual; abstract;
    function getDataSet(const SQL : string):TDataSet; virtual; abstract;
    procedure addTable(const TableName: string); overload;
    procedure addTable(const TableName: string;
                       const CreatePK : Boolean;
                       const AutoInc : Boolean); overload;
    procedure addField(const TableName: string;
                       const FieldName: string;
                       const FieldType: TFieldType;
                       const Size : Integer;
                       const Requerid : Boolean);
    function getSeq(const prSeqName:string) : Variant;
    property ConnName : string read FConnName  write setConnName;
    property Driver : string read FDriver  write FDriver;
    property DataBaseFileConf : string read getDataBaseFileConf;
    { Public declarations }
  end;

implementation

uses
  App;

{ TIFB_Conn }

procedure TIFB_Conn.addField(const TableName, FieldName: string;
  const FieldType: TFieldType; const Size: Integer; const Requerid: Boolean);
begin
  ExecSQL('alter table '+TableName+' add '+FieldName+' '+getStrSQLFieldType(FieldType, Size, Requerid) );
end;

procedure TIFB_Conn.addTable(const TableName: string);
begin
  addTable(TableName, True, True);
end;

procedure TIFB_Conn.addTable(const TableName: string; const CreatePK: Boolean;
  const AutoInc : Boolean);
var
  sSQL : string;
begin
  sSQL := '';
  sSQL := sSQL + 'create table '+TableName+' ';
  sSQL := sSQL + ' (ID '+getStrSQLFieldType(ftInteger, 0, True)+' '+IfThen(AutoInc, ' PRIMARY KEY AUTOINCREMENT); ', '');
  if CreatePK then
  begin
    if (UpperCase(Driver) = UpperCase(ctDriveSQLite)) and (not AutoInc) then
      sSQL := sSQL + ', PRIMARY KEY(ID) );';
  end;
  ExecSQL(sSQL);
end;

constructor TIFB_Conn.Create(const ConnName: string);
begin
  Self.ConnName := ConnName;
end;

function TIFB_Conn.getDataBaseFileConf: string;
begin
  Result := oApp.AppConfPath+PathDelim+'database.ini';
end;

function TIFB_Conn.getSeq(const prSeqName: string): Variant;
begin

end;

function TIFB_Conn.getStrSQLFieldType(const DataType: TFieldType; const Size: Integer;
  const Required: Boolean): String;
begin
  if DataType = ftBoolean then
    Result := 'SMALLINT'+IfThen(Required, ' NOT NULL', '');;
  if DataType = ftCurrency then
    Result := 'NUMERIC(12,2)'+IfThen(Required, ' NOT NULL', '');
  if DataType = ftTime then
    Result := 'TIME'+IfThen(Required, ' NOT NULL', '');;
  if DataType = ftDate then
    Result := 'DATE'+IfThen(Required, ' NOT NULL', '');;
  if DataType = ftDateTime then
  begin
    if Driver = ctDriveFB then
      Result := 'TIMESTAMP'+IfThen(Required, ' NOT NULL', '');;
    if Driver = ctDriveSQLite then
      Result := 'DATETIME';
  end;
  if DataType = ftInteger then
  begin
    Result := 'INTEGER'+IfThen(Required, ' NOT NULL', '');;
  end;
  if DataType = ftLargeint then
    Result := 'BIGINT'+IfThen(Required, ' NOT NULL', '');;
  if DataType = ftString then
  begin
    if Driver = ctDriveFB then
      Result := 'VARCHAR('+IntToStr(Size)+') CHARACTER SET ISO8859_1 '+IfThen(Required, 'NOT NULL', '')+' COLLATE PT_BR ';
    if Driver = ctDriveSQLite then
      Result := IfThen(Required, 'NOT NULL', '')+' TEXT ';
  end;
  if DataType = ftBlob then
    Result := 'BLOB SUB_TYPE 1 SEGMENT SIZE 16384 CHARACTER SET ISO8859_1 ';
end;

procedure TIFB_Conn.setConnName(const Value: string);
begin
  FConnName := Value;
end;

end.
