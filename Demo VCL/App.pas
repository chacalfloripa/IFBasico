unit App;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, IFB_ConnFIBPlus,
  IFB_App, un_IFBBuildDataBase;

type
  TApp = class(TIFB_App)
  private
    { Private declarations }
  public
    oConn : TIFB_ConnFIBPlus;
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
  oConn := TIFB_ConnFIBPlus.Create('CONN_01');
end;

procedure TApp.start;
var
  oBuild : TIFB_BuildDataBase;
begin
  oConn.connect;
  obuild := TIFB_BuildDataBase.Create;
  oBuild.Build;
  oBuild.Free;
end;

procedure TApp.stop;
begin

end;

initialization
  oApp := TApp.create;

finalization
  FreeAndNil(oApp);

end.
