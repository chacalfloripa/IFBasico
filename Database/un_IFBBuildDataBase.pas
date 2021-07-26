unit un_IFBBuildDataBase;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  SysUtils, Classes, DB;

type
  TIFB_BuildDataBase = class
  private
    { Private declarations }
  public
     procedure Build;
    { Public declarations }
  protected
    function existExecScript(const AGuid: string):Boolean;
    function addExecScript(const AGuid: string):Boolean;
    { Public declarations }
  end;

implementation

uses
  App;

{ TIFB_BuildDataBase }

function TIFB_BuildDataBase.addExecScript(const AGuid: string): Boolean;
begin
  oApp.oConn.ExecSQL('insert into SYS_EXEC_SCRIPT (ID, DE_GUID, DH_EXEC) '+
                     '   values ( gen_id(GEN_SYS_EXEC_SCRIPT_ID, 1), '+QuotedStr(AGuid)+', current_timestamp); ');
end;

procedure TIFB_BuildDataBase.Build;
begin
  //
  oApp.oConn.addTable('SYS_EXEC_SCRIPT', True, False);
  oApp.oConn.addField('SYS_EXEC_SCRIPT', 'DE_GUID', ftString, 100, True);
  oApp.oConn.addField('SYS_EXEC_SCRIPT', 'HE_EXEC', ftDateTime, 0, True);
  //
  oApp.oConn.addTable('GEN_SITUACAO', True, False);
  oApp.oConn.addField('GEN_SITUACAO', 'NM_SITUACAO', ftString, 50, True);
  //
  with oApp.oConn.getDataSet('GEN_SITUACAO') do
  begin
    try
      // Verifica se existe a situação ATIVO.
      if not Locate('id', 1, []) then
      begin
        Append;
        FieldByName('id').AsInteger := 1;
        FieldByName('nm_situacao').AsString := 'ATIVO';
        Post;
      end;
      // Verifica se existe a situação EXCLUIDO.
      if not Locate('id', 2, []) then
      begin
        Append;
        FieldByName('id').AsInteger := 2;
        FieldByName('nm_situacao').AsString := 'EXCLUIDO';
        Post;
      end;
      // Verifica se existe a situação CANCELADO.
      if not Locate('id', 3, []) then
      begin
        Append;
        FieldByName('id').AsInteger := 3;
        FieldByName('nm_situacao').AsString := 'CANCELADO';
        Post;
      end;
      // Verifica se existe a situação FECHADO.
      if not Locate('id', 4, []) then
      begin
        Append;
        FieldByName('id').AsInteger := 4;
        FieldByName('nm_situacao').AsString := 'FECHADO';
        Post;
      end;
      // Verifica se existe a situação BLOQUEADO.
      if not Locate('id', 5, []) then
      begin
        Append;
        FieldByName('id').AsInteger := 5;
        FieldByName('nm_situacao').AsString := 'BLOQUEADO';
        Post;
      end;
      // Verifica se existe a situação LIBERADO.
      if not Locate('id', 6, []) then
      begin
        Append;
        FieldByName('id').AsInteger := 6;
        FieldByName('nm_situacao').AsString := 'LIBERADO';
        Post;
      end;
    except
    end;
    Close;
    Free;
    //
    if not existExecScript('C7F9ABDE-1229-4D17-9D0A-31BDA9668E56') then
    begin
      oApp.oConn.addField('SYS_EXEC_SCRIPT', 'DH_EXEC', ftDateTime, 0, False);
      if oApp.oConn.fieldExist('SYS_EXEC_SCRIPT', 'HE_EXEC') then
      begin
        oApp.oConn.ExecSQL('update SYS_EXEC_SCRIPT set DH_EXEC = HE_EXEC where DH_EXEC is null and HE_EXEC is not null');
        oApp.oConn.ExecSQL('ALTER TABLE SYS_EXEC_SCRIPT DROP HE_EXEC');
        oApp.oConn.ExecSQL('update SYS_EXEC_SCRIPT set DH_EXEC = current_timestamp where DH_EXEC is null');
        oApp.oConn.ExecSQL('ALTER TABLE SYS_EXEC_SCRIPT ALTER DH_EXEC SET NOT NULL');
      end;
      addExecScript('C7F9ABDE-1229-4D17-9D0A-31BDA9668E56');
    end;

  end;
  //
end;

function TIFB_BuildDataBase.existExecScript(const AGuid: string): Boolean;
const
  ctSQL = 'select * from SYS_EXEC_SCRIPT where DE_GUID = ';
begin
  with oApp.oConn.getQuery(ctSQL+ QuotedStr(AGuid)) do
  begin
    Open;
    Result := not IsEmpty;
    Free;
  end;
end;

end.
