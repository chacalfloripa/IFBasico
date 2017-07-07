unit IFB_Conn;

interface

uses
  System.SysUtils, System.Classes, IFB_App;

type
  TIFB_Conn = class
  private
    FConnName: string;
    procedure setConnName(const Value: string);
    function getDataBaseFileConf: string;
    { Private declarations }
  public
    constructor Create(const ConnName:  string);
    property ConnName : string read FConnName  write setConnName;
    property DataBaseFileConf : string read getDataBaseFileConf;
    { Public declarations }
  end;

implementation

{ TIFB_Conn }

constructor TIFB_Conn.Create(const ConnName: string);
begin
  Self.ConnName := ConnName;
end;

function TIFB_Conn.getDataBaseFileConf: string;
begin
  Result := FIFB_App.AppConfPath+PathDelim+'database.ini';
end;

procedure TIFB_Conn.setConnName(const Value: string);
begin
  FConnName := Value;
end;

end.
