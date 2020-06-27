unit un_DBFuncoes;

{$MODE Delphi}

interface

uses
  DB, StrUtils, SysUtils, DateUtils;

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

{-------------------------------------------------------------------------------
Nome       : AddField
Objetivo   : Criar um campo em uma tabela no banco de dados.
Retorno    : Boolean.
Parametros : prTable : String
               Nome da tabela para criação
             prField : String
               Nome do campo a ser criado.
             prDataType: TFieldType
               Tipo do campo a ser criado.
             prSize: Integer;
               Tamanho do campo, somente sera usado para campos que exista essa opção.
             prRequired: Boolean
               Determina se o campo será de not null no banco de dados.
Compativel : FB
Homologado : FD
Criado em  : 27/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
-------------------------------------------------------------------------------}
function TDBFuncoes.AddField(const prTable, prField: String;
  prDataType: TFieldType; prSize: Integer; prRequired: Boolean): Boolean;
var
  sSQL : String;
begin
  Result := False;
  sSQL := '';
  if not ExistField(prTable, prField) then
  begin
    try
      sSQL := sSQL + ' ALTER TABLE '+UpperCase( prTable )+'' ;
      sSQL := sSQL + ' ADD '+UpperCase( prField )+' '+UpperCase( getStrSQLFieldType(prDataType, prSize, prRequired) );
      sSQL := sSQL + ';';
      ExecSQL(sSQL);
      Result := True;
    except
    end;
  end;
end;

{-------------------------------------------------------------------------------
Nome       : AddFieldFK
Objetivo   : Cria um campo no banco de dados invocando o método addField e ser
             o retornar sucesso cria uma foreng key pelo invocando o método
             addFK.
Retorno    : Boolean.
Parametros : prForeignKey : string
               Nome da chave, se deixa em branco ser gerado um nome aleatorio.
             prTable : String
               Nome da tabela para criação
             prField : String
               Nome do campo a ser criado.
             prTableRef : String
               Tabela que será ser referenciada.
             prFieldRef : String
               Campo q será referenciado.
             prDataType: TFieldType
               Tipo do campo a ser criado.
             prSize: Integer;
               Tamanho do campo, somente sera usado para campos que exista essa opção.
             prRequired: Boolean
               Determina se o campo será de not null no banco de dados.
Compativel : FB
Homologado : FD
Criado em  : 27/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
-------------------------------------------------------------------------------}
function TDBFuncoes.AddFieldFK(const prForeignKey, prTable, prField, prTableRef,
  prFieldRef: String; prDataType: TFieldType; prSize: Integer;
  prRequired: Boolean): Boolean;
begin
  if addField(prTable, prField, prDataType, prSize, prRequired) then
    AddFK(prForeignKey, prTable, prField, prTableRef, prFieldRef);
end;

{-------------------------------------------------------------------------------
Nome       : AddFieldFK
Objetivo   : Cria um campo no banco de dados invocando o método addField e ser
             o retornar sucesso cria uma foreng key pelo invocando o método
             addFK.
Retorno    : Boolean.
Parametros : prForeignKey : string
               Nome da chave, se deixa em branco ser gerado um nome aleatorio.
             prTable : String
               Nome da tabela para criação
             prField : String
               Nome do campo a ser criado.
             prTableRef : String
               Tabela que será ser referenciada.
             prFieldRef : String
               Campo q será referenciado.
Compativel : FB
Homologado : FD
Criado em  : 27/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
-------------------------------------------------------------------------------}
function TDBFuncoes.AddFK(const prForeignKey, prTable, prField, prTableRef,
  prFieldRef: String): Boolean;
begin
  if ExistTable(prTable) and
     ExistTable(prTableRef) then
  begin
    if ExistField(prTable, prField) and
       ExistField(prTableRef, prFieldRef) then
    begin
      ExecSQL(' ALTER TABLE '+UpperCase(prTable)+
              ' ADD CONSTRAINT '+UpperCase(prForeignKey)+
              ' FOREIGN KEY ('+UpperCase(prField)+') '+
              ' REFERENCES '+UpperCase(prTableRef)+'('+UpperCase(prFieldRef)+')'+
              ' USING INDEX IDX_'+UpperCase(prForeignKey));
    end;
  end;
end;
{-------------------------------------------------------------------------------
Nome       : AddTable
Objetivo   : Criar a tabela no banco de dados com um campo padrão ID.
Retorno    : Boolean.
Parametros : prTable : String
               Nome da tabela para criação
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
                  Se o campo é obrigatório no dataset.
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
Compativel : FB
Homologado : FD
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
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
