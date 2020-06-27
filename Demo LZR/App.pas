unit App;

interface

uses
  SysUtils, Classes, IFB_App, un_IFBBuildDataBase, IFB_ConnZeos;

type
  TApp = class(TIFB_App)
  private
    { Private declarations }
  public
    oConn : TIFB_ConnZeos;
    constructor Create;
    procedure start;
    procedure stop;
    { Public declarations }
  end;

var
  oApp : TApp;

implementation

{ TApp }

constructor TApp.create;
begin
  oConn := TIFB_ConnZeos.Create('CONN_01');
end;

procedure TApp.start;
var
  oBuild : TIFB_BuildDataBase;
begin
//  oConn.connect;
  obuild := TIFB_BuildDataBase.Create;
  oBuild.Build;
  oBuild.Free;
end;

procedure TApp.stop;
begin

end;

end.
