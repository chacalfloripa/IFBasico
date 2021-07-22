unit IFB_App;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  SysUtils, Classes, IFB_FuncoesINI
  {$IFDEF FPC}
    , Forms
  {$else}
    {$IF DECLARED(FireMonkeyVersion)}
        , FMX.Forms
    {$else}
      , Vcl.Forms
    {$ENDIF}
 {$ENDIF}
  ;

type
  TIFB_App = class
  private
    FHomePath : string;
    FAppPath : string;
    FAppConfPath : string;
    FAppImagePath : string;
    FAppLibPath : string;
    FSiglaProjeto: string;
    FSiglaEmpresa: string;
    FIDSistema: Word;
    FNomeLongoSistema: string;
    FNomeSistema: string;
    FDescricaoSistema: string;
    FFuncoesINI : TIFB_FuncoesINI;
    function getAppPath: string;
    procedure setAppPath(const Value: string);
    function getAppConfPath: string;
    function getAppHome: string;
    procedure setAppConfPath(const Value: string);
    procedure setAppHome(const Value: string);
    function getSiglaProjeto: string;
    function getSiglaEmpresa: string;
    function getIDSistema: Word;
    function getDescricaoSistema: string;
    function getNomeLongoSistema: string;
    function getNomeSistema: string;
    function getLibPath: string;
    procedure setLibPath(const Value: string);
    function getAppImagePath: string;
    procedure setAppImagePath(const Value: string);
    function getFuncoesINI: TIFB_FuncoesINI; virtual;
    { Private declarations }
  public
    constructor Create; virtual;
    property AppHome : string read getAppHome write setAppHome;
    property AppPath : string read getAppPath write setAppPath;
    property AppLibPath : string read getLibPath write setLibPath;
    property AppConfPath : string read getAppConfPath write setAppConfPath;
    property AppImagePath : string read getAppImagePath write setAppImagePath;
    property SiglaEmpresa : string read getSiglaEmpresa write FSiglaEmpresa;
    property SiglaProjeto : string read getSiglaProjeto write FSiglaProjeto;
    property IDSistema : Word read getIDSistema write FIDSistema;
    property NomeSistema : string read getNomeSistema write FNomeSistema;
    property NomeLongoSistema : string read getNomeLongoSistema write FNomeLongoSistema;
    property DescricaoSistema : string read getDescricaoSistema write FDescricaoSistema;
    property FuncoesINI : TIFB_FuncoesINI read getFuncoesINI;
    { Public declarations }
  end;

implementation


{ TIFB_App }

constructor TIFB_App.Create;
begin
  FFuncoesINI := TIFB_FuncoesINI.Create;
end;

function TIFB_App.getAppConfPath: string;
begin
  if Trim(FAppConfPath) = '' then
  begin
    FAppConfPath := 'conf';
    if copy(Trim(AppHome), Length(AppHome), 1) <> PathDelim then
      FAppConfPath := PathDelim+FAppConfPath;
    FAppConfPath := AppHome+FAppConfPath;
    if not DirectoryExists(FAppConfPath) then
    begin
      CreateDir(FAppConfPath)
    end;
  end;
  Result := FAppConfPath;
end;

function TIFB_App.getAppHome: string;
begin
  if Trim(FHomePath) = '' then
  begin
    {$IFDEF MSWINDOWS}
      FHomePath := ExtractFileDir(ExcludeTrailingBackslash(ExtractFilePath(Application.ExeName )));
    {$ENDIF MSWINDOWS}
    {$IFDEF ANDROID}
      FHomePath := ExtractFilePath(TPath.GetPublicPath);
    {$ENDIF ANDROID}
    if not DirectoryExists(FHomePath) then
    begin
      CreateDir(FHomePath)
    end;
  end;
  Result := FHomePath;
end;

function TIFB_App.getAppImagePath: string;
begin
  if Trim(FAppImagePath) = '' then
  begin
    FAppImagePath := 'Image';
    if copy(Trim(AppHome), Length(AppHome), 1) <> PathDelim then
      FAppImagePath := PathDelim+FAppImagePath;
    FAppImagePath := AppHome+FAppImagePath;
    if not DirectoryExists(FAppImagePath) then
    begin
      CreateDir(FAppImagePath)
    end;
  end;
  Result := FAppImagePath;
end;

function TIFB_App.getAppPath: string;
begin
  if Trim(FAppPath) = '' then
  begin
    FAppPath := getAppHome+PathDelim+'bin';
    if not DirectoryExists(FAppPath) then
    begin
      CreateDir(FAppPath)
    end;
  end;
  Result := FAppPath;
end;

function TIFB_App.getDescricaoSistema: string;
begin
  Result := FDescricaoSistema;
end;

function TIFB_App.getFuncoesINI: TIFB_FuncoesINI;
begin
  Result := FFuncoesINI;
end;

function TIFB_App.getIDSistema: Word;
begin
  Result := FIDSistema;
end;

function TIFB_App.getLibPath: string;
begin
  if Trim(FAppLibPath) = '' then
  begin
    FAppLibPath := 'lib';
    if copy(Trim(AppHome), Length(AppHome), 1) <> PathDelim then
      FAppLibPath := PathDelim+FAppLibPath;
    FAppLibPath := AppHome+FAppLibPath;
    if not DirectoryExists(FAppLibPath) then
    begin
      CreateDir(FAppLibPath)
    end;
  end;
  Result := FAppLibPath;
end;

function TIFB_App.getNomeLongoSistema: string;
begin
  Result := FNomeLongoSistema;
end;

function TIFB_App.getNomeSistema: string;
begin
  Result := FNomeSistema;
end;

function TIFB_App.getSiglaEmpresa: string;
begin
  Result := FSiglaEmpresa;
end;

function TIFB_App.getSiglaProjeto: string;
begin
  Result := FSiglaProjeto;
end;

procedure TIFB_App.setAppConfPath(const Value: string);
begin
end;

procedure TIFB_App.setAppHome(const Value: string);
begin
  if Trim(Value) = '' then
  begin
    FHomePath := Value;
    CreateDir(FAppPath)
  end;
end;

procedure TIFB_App.setAppImagePath(const Value: string);
begin

end;

procedure TIFB_App.setAppPath(const Value: string);
begin

end;

procedure TIFB_App.setLibPath(const Value: string);
begin

end;

end.
