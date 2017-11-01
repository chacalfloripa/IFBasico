unit IFB_App;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, IFB_FuncoesINI;

type
  TIFB_App = class
  private
    FHomePath : string;
    FAppPath : string;
    FAppConfPath : string;
    FSiglaProjeto: string;
    FSiglaEmpresa: string;
    FIDSistema: Word;
    FNomeLongoSistema: string;
    FNomeSistema: string;
    FDescricaoSistema: string;
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
    { Private declarations }
  public
    property AppHome : string read getAppHome write setAppHome;
    property AppPath : string read getAppPath write setAppPath;
    property AppConfPath : string read getAppConfPath write setAppConfPath;
    property SiglaEmpresa : string read getSiglaEmpresa write FSiglaEmpresa;
    property SiglaProjeto : string read getSiglaProjeto write FSiglaProjeto;
    property IDSistema : Word read getIDSistema write FIDSistema;
    property NomeSistema : string read getNomeSistema write FNomeSistema;
    property NomeLongoSistema : string read getNomeLongoSistema write FNomeLongoSistema;
    property DescricaoSistema : string read getDescricaoSistema write FDescricaoSistema;


    { Public declarations }
  end;

implementation


{ TIFB_App }

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
      FHomePath := ExtractFilePath(GetCurrentDir);
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

function TIFB_App.getIDSistema: Word;
begin
  Result := FIDSistema;
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

procedure TIFB_App.setAppPath(const Value: string);
begin

end;

end.
