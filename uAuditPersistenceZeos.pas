unit uAuditPersistenceZeos;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,
  ZConnection, ZDataset,
  uAuditoriaIntf, uAuditPersistenceIntf;

type
  TAuditPersistenceZeos = class(TInterfacedObject, IAuditPersistence)
  private
    FConn: TZConnection;
  public
    constructor Create(AConn: TZConnection);
    procedure Insert(const ATable: string; const AFields: TDictionary<string, Variant>);
  end;

implementation

constructor TAuditPersistenceZeos.Create(AConn: TZConnection);
begin
  inherited Create;
  FConn := AConn;
end;

procedure TAuditPersistenceZeos.Insert(const ATable: string; const AFields: TDictionary<string, Variant>);
var
  Q: TZQuery;
  K: string;
  SQLFields, SQLParams: string;
  First: Boolean;
begin
  if (FConn = nil) then
    raise Exception.Create('AuditPersistenceZeos: conexão nula.');

  Q := TZQuery.Create(nil);
  try
    Q.Connection := FConn;

    SQLFields := '';
    SQLParams := '';
    First := True;

    for K in AFields.Keys do
    begin
      if not First then
      begin
        SQLFields := SQLFields + ',';
        SQLParams := SQLParams + ',';
      end;

      SQLFields := SQLFields + K;
      SQLParams := SQLParams + ':' + K;
      First := False;
    end;

    Q.SQL.Text := Format('insert into %s (%s) values (%s)', [ATable, SQLFields, SQLParams]);

    for K in AFields.Keys do
      Q.ParamByName(K).Value := AFields[K];

    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

end.

