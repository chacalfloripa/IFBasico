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
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    Button6: TButton;
    edtExistFieldNomeTabela: TEdit;
    dtExistFieldNomeCampo: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button7: TButton;
    Edit1: TEdit;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button5: TButton;
    edtExistTabela: TEdit;
    Button8: TButton;
    Button9: TButton;
    Edit2: TEdit;
    Label5: TLabel;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    function testaConexao : Boolean;
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

procedure TForm1.Button11Click(Sender: TObject);
begin
  if testaConexao then
  begin
    if Trim(edtExistTabela.Text) <> '' then
    begin
      if not FFuncoesFD.ExistTable(edtExistTabela.Text) then
      begin
        if FFuncoesFD.AddTable(edtExistTabela.Text) then
          ShowMessage('Tabela criada com sucesso.')
        else
          ShowMessage('Ocorreu algum erro durante a criação da tabela.');
      end
      else
        ShowMessage('Tabela já existe.');
    end
    else
    begin
      ShowMessage('Preencha o campo nome da tabela para realizar o teste.');
    end;
  end;
end;

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

procedure TForm1.Button5Click(Sender: TObject);
begin
  if testaConexao then
  begin
    if Trim(edtExistTabela.Text) <> '' then
    begin
      if FFuncoesFD.ExistTable(edtExistTabela.Text) then
        ShowMessage('Tabela existe.')
      else
        ShowMessage('Tabela não existe.');
    end
    else
    begin
      ShowMessage('Preencha o campo nome da tabela para realizar o teste.');
    end;
  end;
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

function TForm1.testaConexao: Boolean;
begin
  Result := True;
  if not dtm_connect.FDCon_01.Connected then
  begin
    Result := False;
    ShowMessage('Não existe uma conexão ativa com o banco de dados.');
  end;
end;

end.
