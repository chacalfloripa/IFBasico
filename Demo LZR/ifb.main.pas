unit IFB.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, DBGrids, IFB_Conn, App, db, IBConnection, SQLDBLib, SQLDB,
  IFB_ConnSQLDB;

type

  { TIFB_Main }

  TIFB_Main = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    DBGrid2: TDBGrid;
    DsTabela: TDataSource;
    DBGrid1: TDBGrid;
    DsConsulta: TDataSource;
    dtExistFieldNomeCampo: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    edtExistFieldNomeTabela: TEdit;
    edtExistTabela: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblTesteData: TLabel;
    lblTesteDataHora: TLabel;
    lblTesteHora: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    FDataSetConsulta : TIFB_Query;
    FDataSetTabela : TIFB_Table;
    function testaConexao : Boolean;
  public

  end;

var
  IFB_Main: TIFB_Main;

implementation

{$R *.lfm}

{ TIFB_Main }

procedure TIFB_Main.Button1Click(Sender: TObject);
begin
  if Button1.Caption = 'Connect DB' then
    oApp.oConn.connect;
  //
  if Button1.Caption = 'Disconnect DB' then
    oApp.oConn.Disconnect;
  //
  if not oApp.oConn.connected then
    Button1.Caption := 'Connect DB';
  //
  if oApp.oConn.connected then
    Button1.Caption := 'Disconnect DB';
end;

procedure TIFB_Main.Button2Click(Sender: TObject);
begin
  lblTesteDataHora.Caption := FormatDateTime('dd/mm/yyyy dd:nn:ss ', oApp.oConn.getServeDateTime);
end;

procedure TIFB_Main.Button3Click(Sender: TObject);
begin
  lblTesteData.Caption := FormatDateTime('dd/mm/yyyy', oApp.oConn.getServeDate);
end;

procedure TIFB_Main.Button4Click(Sender: TObject);
begin
  lblTesteHora.Caption := FormatDateTime('dd:nn:ss ', oApp.oConn.getServeTime);
end;

procedure TIFB_Main.Button5Click(Sender: TObject);
begin
(*  if testaConexao then
  begin
    if Trim(edtExistTabela.Text) <> '' then
    begin
      if oApp.oConn.ExistTable(edtExistTabela.Text) then
        ShowMessage('Tabela existe.')
      else
        ShowMessage('Tabela não existe.');
    end
    else
    begin
      ShowMessage('Preencha o campo nome da tabela para realizar o teste.');
    end;
  end; *)
end;

procedure TIFB_Main.Button6Click(Sender: TObject);
begin

end;

procedure TIFB_Main.Button8Click(Sender: TObject);
begin

end;

procedure TIFB_Main.Button9Click(Sender: TObject);
begin

end;

function TIFB_Main.testaConexao: Boolean;
begin
  Result := True;
  if not oApp.oConn.connect then
  begin
    Result := False;
    ShowMessage('Não existe uma conexão ativa com o banco de dados.');
  end;
end;

procedure TIFB_Main.Button13Click(Sender: TObject);
begin
  FDataSetTabela := oApp.oConn.getDataSet(Edit3.Text);
  DsTabela.DataSet := FDataSetTabela;
  FDataSetTabela.Open;
end;

procedure TIFB_Main.Button11Click(Sender: TObject);
begin
(*  if testaConexao then
  begin
    if Trim(edtExistTabela.Text) <> '' then
    begin
      if not oApp.oConn.tableExist(edtExistTabela.Text) then
      begin
        if oApp.oConn.AddTable(edtExistTabela.Text) then
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
  end; *)
end;

procedure TIFB_Main.Button14Click(Sender: TObject);
begin
  FDataSetConsulta := oApp.oConn.getQuery(Memo1.Lines.Text);
  DsConsulta.DataSet := FDataSetConsulta;
  FDataSetConsulta.Open;
end;

end.

