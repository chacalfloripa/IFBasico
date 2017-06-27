unit IFB_ModelSituacao;

interface

uses
  Classes,
  DB,
  SysUtils,
  Generics.Collections,
  /// orm
  ormbr.mapping.attributes,
  ormbr.types.mapping,
  ormbr.types.lazy,
  ormbr.mapping.register;

type
  [Entity]
  [Table('GEN_SITUACAO','')]
  [PrimaryKey('ID', AutoInc, NoSort, True, 'Chave primária')]
  [Sequence('GEN_SITUACAO')]
  [OrderBy('NM_SITUACAO DESC')]
  TIFB_ModelSituacao = class
  private
    { Private declarations }
    Fid: Integer;
    FNmSituacao: String;
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('ID', ftInteger)]
    [Dictionary('ID','Chave primária da tabela.','0','','',taCenter)]
    property master_id: Integer Index 0 read Fid write Fid;

    [Column('NM_SITUACAO', ftString, 60)]
    [Dictionary('NM_SITUACAO','Nome da situação','','','',taLeftJustify)]
    property description: String Index 1 read FNmSituacao write FNmSituacao;
  end;

implementation

{ TIFB_ModelSituacao }

initialization
  TRegisterClass.RegisterEntity(TIFB_ModelSituacao);

end.
