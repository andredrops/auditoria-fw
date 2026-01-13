unit uAuditPersistenceFireDAC;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  uAuditoriaIntf, uAuditPersistenceIntf;

type
  TAuditPersistenceFireDAC = class(TInterfacedObject, IAuditPersistence)
  private
    FConn: TFDConnection;
  public
    constructor Create(AConn: TFDConnection);
    procedure Insert(const ATable: string; const AFields: TDictionary<string, Variant>);
  end;

implementation

constructor TAuditPersistenceFireDAC.Create(AConn: TFDConnection);
begin
  inherited Create;
  FConn := AConn;
end;

procedure TAuditPersistenceFireDAC.Insert(const ATable: string; const AFields: TDictionary<string, Variant>);
var
  Q: TFDQuery;
  K: string;
  SQLFields, SQLParams: string;
  First: Boolean;
begin
  if (FConn = nil) then
    raise Exception.Create('AuditPersistenceFireDAC: conexão nula.');

  Q := TFDQuery.Create(nil);
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

