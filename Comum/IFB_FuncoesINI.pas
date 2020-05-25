unit IFB_FuncoesINI;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles;

type
  TIFB_FuncoesINI = class
  private
    { Private declarations }
  public
    function getINIParam(prNameArqINI, prGroupParam, prParam, prParamValue : string ) : string; overload;
    procedure setINIParam(prNameArqINI, prGroupParam, prParam,
      prParamValue: string);
    procedure deleteINIParam(prNameArqINI, prGroupParam, prParam: string);
    function getStringListOfArqINI(prNameArqINI,
      prGroupParam: string): TStringList;
    procedure setStrinListToArqINI(prNameArqINI, prGroupParam: string;
      prStringList: TStringList);
    { Public declarations }
  end;

implementation

{ TIFB_FuncoesINI }

function TIFB_FuncoesINI.getINIParam(prNameArqINI, prGroupParam, prParam,
  prParamValue: string): string;
var
  ArqINI : TIniFile;
begin
  ArqINI := TIniFile.Create( prNameArqINI );
  try
    Result := ArqINI.ReadString( prGroupParam, prParam, '' );
    if Result = '' then
    begin
      setINIParam( prNameArqINI, prGroupParam, prParam, prParamValue );
      Result := prParamValue;
    end;
  finally
    ArqINI.Free;
  end;
end;

procedure TIFB_FuncoesINI.setINIParam( prNameArqINI, prGroupParam, prParam, prParamValue : string );
var
  ArqINI : TIniFile;
begin
  try
    ArqINI := TIniFile.Create( prNameArqINI );
    try
      ArqINI.WriteString( prGroupParam, prParam, prParamValue );
      ArqINI.UpdateFile;
    finally
      ArqINI.Free;
    end;
  except
  end;
end;

procedure TIFB_FuncoesINI.deleteINIParam( prNameArqINI, prGroupParam, prParam : string );
var
  ArqINI : TIniFile;
begin
  ArqINI := TIniFile.Create( prNameArqINI );
  try
    ArqINI.DeleteKey( prGroupParam, prParam );
  finally
    ArqINI.Free;
  end;
end;

function TIFB_FuncoesINI.getStringListOfArqINI( prNameArqINI, prGroupParam : string ) : TStringList;
var
  iCountParam : Integer;
  iCount : Integer;
begin
  Result := TStringList.Create;
  Result.Text := '';
  iCountParam := StrToInt( getINIParam( prNameArqINI, prGroupParam, 'CountParam', '-1' ) );
  if iCountParam > -1 then
  begin
    for iCount := 0 to iCountParam - 1 do
    begin
      Result.Add( getINIParam( prNameArqINI, prGroupParam, IntToStr( iCount ), '' ) );
    end;
  end;
end;

procedure TIFB_FuncoesINI.setStrinListToArqINI( prNameArqINI, prGroupParam : string; prStringList : TStringList );
var
  iCount : Integer;
begin
  setINIParam( prNameArqINI, prGroupParam, 'CountParam', IntToStr( prStringList.Count ) );
  for iCount := 0 to prStringList.Count - 1 do
  begin
    setINIParam( prNameArqINI, prGroupParam, IntToStr( iCount ), prStringList.Strings[ iCount ] );
  end;
end;

end.
