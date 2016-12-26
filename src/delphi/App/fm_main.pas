unit fm_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dm_connect, Vcl.StdCtrls, Vcl.ComCtrls,
  un_DBFuncoesFD, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PageControl2: TPageControl;
    Panel1: TPanel;
    Button1: TButton;
    TabSheet2: TTabSheet;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    lblTesteHora: TLabel;
    lblTesteData: TLabel;
    lblTesteDataHora: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    dtm_connect : Tdtm_connect;
    FFuncoesFD : TDBFuncoesFD;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with dtm_connect do
  begin
    if connect then
    begin
      FFuncoesFD.Driver := 'FD';
      FFuncoesFD.FCon := dtm_connect.FDCon_01;
      ShowMessage('Sucesso');
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  lblTesteDataHora.Caption := FormatDateTime('dd/mm/yyyy dd:nn:ss ', FFuncoesFD.getDateTimeServer);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  lblTesteData.Caption := FormatDateTime('dd/mm/yyyy', FFuncoesFD.getDateServer);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  lblTesteHora.Caption := FormatDateTime('dd:nn:ss ', FFuncoesFD.getTimeServer);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  dtm_connect := Tdtm_connect.Create(nil);
  FFuncoesFD := TDBFuncoesFD.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FFuncoesFD.Free;
  dtm_connect.Free;
end;

end.
