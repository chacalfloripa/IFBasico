unit IFB_Conn;

interface

uses
  System.SysUtils, System.Classes;

type
  TIFB_Conn = class
  private
    FConnName: string;
    procedure setConnName(const Value: string);
    { Private declarations }
  public
    constructor Create(const ConnName:  string);
    property ConnName : string read FConnName  write setConnName;
    { Public declarations }
  end;

implementation

{ TIFB_Conn }

constructor TIFB_Conn.Create(const ConnName: string);
begin
  Self.ConnName := ConnName;
end;

procedure TIFB_Conn.setConnName(const Value: string);
begin
  FConnName := Value;
end;

end.
