unit un_DBFuncoesFD;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, un_DBFuncoes;

type
 TDBFuncoesFD = class(TDBFuncoes)
  private
  public
    FCon: TFDConnection;
    function Select(const prSQL : string):TDataSet; override;
    function ExecSQL(const prSQL : string):Boolean; override;
 end;

implementation

{ TDBFuncoesFD }


{-------------------------------------------------------------------------------
Nome       : ExecSQL
Objetivo   : Executa uma instrução SQL.
Retorno    : Boolean.
Parametros : prSQL: string
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
-------------------------------------------------------------------------------}
function TDBFuncoesFD.ExecSQL(const prSQL: string): Boolean;
var
  oQry : TFDQuery;
begin
  Result := False;
  try
    oQry := TFDQuery.Create(nil);
    try
      TFDQuery(Result).Connection := FCon;
      TFDQuery(Result).Close;
      TFDQuery(Result).SQL.Clear;
      TFDQuery(Result).SQL.Add(prSQL);
      TFDQuery(Result).ExecSQL;
      Result :=  True;
    finally
      oQry.Free;
    end;
  except
    Result := False;
  end;
end;

{-------------------------------------------------------------------------------
Nome       : Select
Objetivo   : Retorna um DataSet com o resultado da consulta.
Retorno    : TDataSet.
Parametros : prSQL: string
Criado em  : 26/12/2016
Responsável: Ismael Leandro Faustino
--------------------------------------------------------------------------------
Histórico de alteração:
   - [Responsável] em [Data da alteração]
        [descrição da alteração]
-------------------------------------------------------------------------------}
function TDBFuncoesFD.Select(const prSQL: string): TDataSet;
begin
  Result := TFDQuery.Create(nil);
  try
    TFDQuery(Result).Connection := FCon;
    TFDQuery(Result).Close;
    TFDQuery(Result).SQL.Clear;
    TFDQuery(Result).SQL.Add(prSQL);
    TFDQuery(Result).Open;
  except
    Result := nil;
  end;
end;

end.
