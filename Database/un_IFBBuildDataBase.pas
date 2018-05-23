unit un_IFBBuildDataBase;

interface

uses
  System.SysUtils, System.Classes, DB;

type
  TIFB_BuildDataBase = class
  private
    { Private declarations }
  public
     procedure Build;
    { Public declarations }
  protected
    function existExecScript(const gruid: string):Boolean;
    function addExecScript(const gruid: string):Boolean;
    { Public declarations }
  end;

implementation

uses
  App;

{ TIFB_BuildDataBase }

function TIFB_BuildDataBase.addExecScript(const gruid: string): Boolean;
begin

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
    except
    end;
  end;
  //
end;

function TIFB_BuildDataBase.existExecScript(const gruid: string): Boolean;
begin

end;

end.
