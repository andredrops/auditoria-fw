unit uAuditPersistenceIntf;

interface

uses
  System.Generics.Collections;

type

  TTipoAuditoria = (taGeral, taSuporte);

  IAuditPersistence = interface
    ['{ACF344CD-EF0B-4306-B1DB-466B51F1E47D}']
    procedure Insert(const ATable: string; const AFields: TDictionary<string, Variant>);
  end;


implementation

end.

