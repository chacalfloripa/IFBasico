program AppFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  fm_main in 'fm_main.pas' {frm_main},
  IFB_ConnFD in '..\Database\IFB_ConnFD.pas',
  IFB_ConnFIBPlus in '..\Database\IFB_ConnFIBPlus.pas',
  IFB_ConnORMBr in '..\Database\IFB_ConnORMBr.pas',
  IFB_ModelSituacao in '..\Generico\IFB_ModelSituacao.pas',
  ormbr.driver.connection in '..\..\ormbr\Source\Drivers\ormbr.driver.connection.pas',
  ormbr.factory.connection in '..\..\ormbr\Source\Drivers\ormbr.factory.connection.pas',
  ormbr.factory.interfaces in '..\..\ormbr\Source\Drivers\ormbr.factory.interfaces.pas',
  ormbr.driver.firedac in '..\..\ormbr\Source\Drivers\ormbr.driver.firedac.pas',
  ormbr.driver.firedac.transaction in '..\..\ormbr\Source\Drivers\ormbr.driver.firedac.transaction.pas',
  ormbr.factory.firedac in '..\..\ormbr\Source\Drivers\ormbr.factory.firedac.pas',
  ormbr.database.abstract in '..\..\ormbr\Source\Metadata\ormbr.database.abstract.pas',
  ormbr.database.factory in '..\..\ormbr\Source\Metadata\ormbr.database.factory.pas',
  ormbr.ddl.commands in '..\..\ormbr\Source\Metadata\ormbr.ddl.commands.pas',
  ormbr.ddl.generator.firebird in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.firebird.pas',
  ormbr.ddl.generator.interbase in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.interbase.pas',
  ormbr.ddl.generator.mssql in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.mssql.pas',
  ormbr.ddl.generator.mysql in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.mysql.pas',
  ormbr.ddl.generator in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.pas',
  ormbr.ddl.generator.postgresql in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.postgresql.pas',
  ormbr.ddl.generator.sqlite in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.sqlite.pas',
  ormbr.ddl.interfaces in '..\..\ormbr\Source\Metadata\ormbr.ddl.interfaces.pas',
  ormbr.ddl.register in '..\..\ormbr\Source\Metadata\ormbr.ddl.register.pas',
  ormbr.metadata.db.factory in '..\..\ormbr\Source\Metadata\ormbr.metadata.db.factory.pas',
  ormbr.metadata.extract in '..\..\ormbr\Source\Metadata\ormbr.metadata.extract.pas',
  ormbr.metadata.firebird in '..\..\ormbr\Source\Metadata\ormbr.metadata.firebird.pas',
  ormbr.metadata.interbase in '..\..\ormbr\Source\Metadata\ormbr.metadata.interbase.pas',
  ormbr.metadata.interfaces in '..\..\ormbr\Source\Metadata\ormbr.metadata.interfaces.pas',
  ormbr.metadata.mssql in '..\..\ormbr\Source\Metadata\ormbr.metadata.mssql.pas',
  ormbr.metadata.mysql in '..\..\ormbr\Source\Metadata\ormbr.metadata.mysql.pas',
  ormbr.metadata.postgresql in '..\..\ormbr\Source\Metadata\ormbr.metadata.postgresql.pas',
  ormbr.metadata.register in '..\..\ormbr\Source\Metadata\ormbr.metadata.register.pas',
  ormbr.metadata.sqlite in '..\..\ormbr\Source\Metadata\ormbr.metadata.sqlite.pas',
  ormbr.driver.dbexpress in '..\..\ormbr\Source\Drivers\ormbr.driver.dbexpress.pas',
  ormbr.driver.dbexpress.transaction in '..\..\ormbr\Source\Drivers\ormbr.driver.dbexpress.transaction.pas',
  ormbr.factory.dbexpress in '..\..\ormbr\Source\Drivers\ormbr.factory.dbexpress.pas',
  ormbr.ddl.generator.absolutedb in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.absolutedb.pas',
  ormbr.ddl.generator.oracle in '..\..\ormbr\Source\Metadata\ormbr.ddl.generator.oracle.pas',
  ormbr.metadata.oracle in '..\..\ormbr\Source\Metadata\ormbr.metadata.oracle.pas',
  ormbr.modeldb.compare in '..\..\ormbr\Source\Metadata\ormbr.modeldb.compare.pas',
  ormbr.database.compare in '..\..\ormbr\Source\Metadata\ormbr.database.compare.pas',
  ormbr.database.interfaces in '..\..\ormbr\Source\Metadata\ormbr.database.interfaces.pas',
  ormbr.types.database in '..\..\ormbr\Source\Core\ormbr.types.database.pas',
  ormbr.utils in '..\..\ormbr\Source\Core\ormbr.utils.pas',
  ormbr.database.mapping in '..\..\ormbr\Source\Metadata\ormbr.database.mapping.pas',
  ormbr.types.mapping in '..\..\ormbr\Source\Core\ormbr.types.mapping.pas',
  ormbr.mapping.rttiutils in '..\..\ormbr\Source\Core\ormbr.mapping.rttiutils.pas',
  ormbr.mapping.attributes in '..\..\ormbr\Source\Core\ormbr.mapping.attributes.pas',
  ormbr.mapping.exceptions in '..\..\ormbr\Source\Core\ormbr.mapping.exceptions.pas',
  ormbr.mapping.explorer in '..\..\ormbr\Source\Core\ormbr.mapping.explorer.pas',
  ormbr.mapping.explorerstrategy in '..\..\ormbr\Source\Core\ormbr.mapping.explorerstrategy.pas',
  ormbr.mapping.classes in '..\..\ormbr\Source\Core\ormbr.mapping.classes.pas',
  ormbr.mapping.popular in '..\..\ormbr\Source\Core\ormbr.mapping.popular.pas',
  ormbr.mapping.register in '..\..\ormbr\Source\Core\ormbr.mapping.register.pas',
  ormbr.rtti.helper in '..\..\ormbr\Source\Core\ormbr.rtti.helper.pas',
  ormbr.types.nullable in '..\..\ormbr\Source\Core\ormbr.types.nullable.pas',
  ormbr.mapping.repository in '..\..\ormbr\Source\Core\ormbr.mapping.repository.pas',
  ormbr.metadata.classe.factory in '..\..\ormbr\Source\Metadata\ormbr.metadata.classe.factory.pas',
  ormbr.metadata.model in '..\..\ormbr\Source\Metadata\ormbr.metadata.model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
