unit un_DBFuncoes;

interface

uses
  Data.DB, System.StrUtils, System.SysUtils, System.DateUtils;

type
 TDBFuncoes = class
  private
    FDriver: string;
  public
    function getStrSQLFieldType(prDataType : TFieldType; prSize : Integer = 0;
                                prRequired : Boolean = False):String; virtual;
    //
    function Select(const prSQL : string):TDataSet; virtual; abstract;
    function ExecSQL(const prSQL : string):Boolean; virtual; abstract;
    function getDateTimeServer: TDateTime; virtual;
    function getDateServer: TDate; virtual;
    function getTimeServer: TTime; virtual;

    function ExistTable(const prTable:String):Boolean; virtual;
    function ExistField(const prTable:String; const prField:String):Boolean; virtual;
    function AddTable(const prTable : String):Boolean; virtual;

    function AddField( const prTable : String;
                       const prField : String;
                       prDataType : TFieldType;
                       prSize : Integer = 0;
                       prRequired : Boolean = False):Boolean; virtual;
    function AddFieldFK(const prForeignKey:String;
                        const prTable : String;
                        const prField : String;
                        const prTableRef : String;
                        const prFieldRef : String;
                        prDataType : TFieldType;
                        prSize : Integer = 0;
                        prRequired : Boolean = False):Boolean; virtual;
    function AddFK(const prForeignKey:String;
                   const prTable : String;
                   const prField : String;
                   const prTableRef : String;
                   const prFieldRef : String):Boolean; virtual;
    function AddUniqueField(const prUnique:String;
                            const prTable : String;
                            const prField : String;
                            prDataType : TFieldType;
                            prSize : Integer = 0;
                            prRequired : Boolean = False):Boolean; virtual;
    function AddUnique(const prUnique:String;
                       const prTable : String;
                       const prField : String):Boolean; virtual;
    function DropTable(const prTable:String):Boolean; virtual;
    function DropField(const prTable:String;
                       const prField : String):Boolean; virtual;
    function DropForeignKey(const prForeignKey:String;
                            const prTable : String):Boolean; virtual;
    function RenameField(const prTable:String;
                         const prField:String;
                         const prNewField:String):Boolean; virtual;
    function RenameTable(const prTable:String;
                         const prNewTable:String):Boolean; virtual;
    property Driver : string read FDriver write FDriver;
 end;

implementation

{ TDBFuncoes }


function TDBFuncoes.AddField(const prTable, prField: String;
  prDataType: TFieldType; prSize: Integer; prRequired: Boolean): Boolean;
begin

end;

function TDBFuncoes.AddFieldFK(const prForeignKey, prTable, prField, prTableRef,
  prFieldRef: String; prDataType: TFieldType; prSize: Integer;
  prRequired: Boolean): Boolean;
begin

end;

function TDBFuncoes.AddFK(const prForeignKey, prTable, prField, prTableRef,
  prFieldRef: String): Boolean;
begin

end;

{-------------------------------------------------------------------------------
Nome       : AddTable
Objetivo   : Criar a tabela no banco de dados com um campo padr�o ID.
Retorno    : Boolean.
Parametros : prTable : String
               Nome da tabela para cria��o
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.AddTable(const prTable: String): Boolean;
var
  sSQL : String;
begin
  Result := False;
  sSQL := '';
  if not ExistTable(prTable) then
  begin
    try
      sSQL := sSQL + ' CREATE TABLE "'+UpperCase( prTable )+'" ' ;
      sSQL := sSQL + ' ( ID BIGINT ) ';
      ExecSQL(sSQL);
      try
        sSQL := 'ALTER TABLE '+ UpperCase(prTable);
        sSQL := sSQL + ' ADD CONSTRAINT PK_'+UpperCase( prTable );
        sSQL := sSQL + ' PRIMARY KEY ( ID ) ';
        ExecSQL(sSQL);
        Result := True;
      except
      end;
    except
    end;
  end;
end;

function TDBFuncoes.AddUnique(const prUnique, prTable,
  prField: String): Boolean;
begin

end;

function TDBFuncoes.AddUniqueField(const prUnique, prTable, prField: String;
  prDataType: TFieldType; prSize: Integer; prRequired: Boolean): Boolean;
begin

end;

function TDBFuncoes.DropField(const prTable, prField: String): Boolean;
begin

end;

function TDBFuncoes.DropForeignKey(const prForeignKey,
  prTable: String): Boolean;
begin

end;

function TDBFuncoes.DropTable(const prTable: String): Boolean;
begin

end;

{-------------------------------------------------------------------------------
Nome       : ExistField
Objetivo   : Verifica se o campo existe no banco de dados.
Retorno    : Boolean.
Parametros : prTable : String
               Nome da tabela para verificar
             prField: String
               Nome do campo a ser verificado no banco de dados.
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.ExistField(const prTable, prField: String): Boolean;
begin
  Result := False;
  try
    if ExistTable(prTable) then
      if Assigned(Select('select '+ UpperCase(prField) +' from '+UpperCase(prTable)+ ' where id is null ')) then
        Result := True;
  except
  end;
end;

{-------------------------------------------------------------------------------
Nome       : ExistTable
Objetivo   : Verifica se a tabela existe no banco de dados.
Retorno    : Boolean.
Parametros : prTable : String
              Nome da tabela a ser verificada.
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.ExistTable(const prTable: String): Boolean;
begin
  Result := False;
  try
    if Assigned(Select('select id from '+UpperCase(prTable)+ ' where id is null ')) then
      Result := True;
  except
  end;
end;

{-------------------------------------------------------------------------------
Nome       : getDateServer
Objetivo   : Retorna a data atual do servidor.
Retorno    : TDate.
Parametros : []
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.getDateServer: TDate;
begin
  Result := TDate(getDateTimeServer);
end;

{-------------------------------------------------------------------------------
Nome       : getDateTimeServer
Objetivo   : Retorna a data e hora atual do servidor.
Retorno    : TDateTime.
Parametros : []
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.getDateTimeServer: TDateTime;
const
  ctSQLFB = 'select first 1 current_timestamp as dh from RDB$DATABASE';
var
  oDts : TDataSet;
begin
  Result := Now;
  if Driver = 'FD' then
   oDts := Select(ctSQLFB);
  try
    if not oDts.IsEmpty then
      Result := oDts.FieldByName('dh').AsDateTime;
  finally
    FreeAndNil(oDts);
  end;
end;

{-------------------------------------------------------------------------------
Nome       : getStrSQLFieldType
Objetivo   : Retorna um string com o SQL para o tipo do campo informado.
Retorno    : String.
Parametros : - prDataType : TFieldType
                  Tipo do campo no dataset.
             - prSize : Integer
                  Tamanho do campo, usado para campos do tipo texto.
             - prRequired : Boolean
                  Se o campo � obrigat�rio no dataset.
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.getStrSQLFieldType(prDataType: TFieldType; prSize: Integer;
  prRequired: Boolean): String;
begin
  if Driver = 'FB' then
  begin
    if prDataType = ftBoolean then
      Result := 'SMALLINT'+IfThen(prRequired, ' NOT NULL', '');;
    if prDataType = ftCurrency then
      Result := 'NUMERIC(12,2)'+IfThen(prRequired, ' NOT NULL', '');
    if prDataType = ftTime then
      Result := 'TIME'+IfThen(prRequired, ' NOT NULL', '');;
    if prDataType = ftDate then
      Result := 'DATE'+IfThen(prRequired, ' NOT NULL', '');;
    if prDataType = ftDateTime then
      Result := 'TIMESTAMP'+IfThen(prRequired, ' NOT NULL', '');;
    if prDataType = ftInteger then
      Result := 'INTEGER'+IfThen(prRequired, ' NOT NULL', '');;
    if prDataType = ftLargeint then
      Result := 'BIGINT'+IfThen(prRequired, ' NOT NULL', '');;
    if prDataType = ftString then
      Result := 'VARCHAR('+IntToStr(prSize)+') CHARACTER SET ISO8859_1 '+IfThen(prRequired, 'NOT NULL', '')+' COLLATE PT_BR ';
    if prDataType = ftBlob then
      Result := 'BLOB SUB_TYPE 1 SEGMENT SIZE 16384 CHARACTER SET ISO8859_1 ';
  end;
end;

{-------------------------------------------------------------------------------
Nome       : getTimeServer
Objetivo   : Retorna a hora atual do servidor.
Retorno    : TTime.
Parametros : []
Criado em  : 26/12/2016
Respons�vel: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Hist�rico de altera��o:
   - [Respons�vel] em [Data da altera��o]
        [descri��o da altera��o]
-------------------------------------------------------------------------------}
function TDBFuncoes.getTimeServer: TTime;
begin
  Result := TTime(getDateTimeServer);
end;

function TDBFuncoes.RenameField(const prTable, prField,
  prNewField: String): Boolean;
begin

end;

function TDBFuncoes.RenameTable(const prTable, prNewTable: String): Boolean;
begin

end;

end.
