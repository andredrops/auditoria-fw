unit uAuditoriaNarrativa;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  uAuditoriaIntf,
  System.Generics.Collections,
  uAuditoriaAlteracaoItem;

type
  TAuditoriaNarrativa = class
  private
    class function MontarEvento(const AContexto: IAuditoriaContexto;
                                const ADataHora: TDateTime): string;
  public
    class function BuildEvento(
      const AContexto: IAuditoriaContexto;
      const ADataHora: TDateTime
    ): string;

    class function BuildAlteracao(
  const AContexto: IAuditoriaContexto;
  const ADataHora: TDateTime;
  const AItens: TList<TAuditoriaAlteracaoItem>
): string;
  end;

implementation

uses
  System.DateUtils;

class function TAuditoriaNarrativa.BuildEvento(
  const AContexto: IAuditoriaContexto;
  const ADataHora: TDateTime
): string;
begin
  Result := '*** EVENTO SEM ALTERAÇÃO DE DADOS ***' + sLineBreak + sLineBreak +
            Self.MontarEvento(AContexto, ADataHora);

end;

class function TAuditoriaNarrativa.MontarEvento(const AContexto: IAuditoriaContexto; const ADataHora: TDateTime): string;
begin
  Result :=
    '• Módulo: ' + AContexto.GetModulo + sLineBreak +
    '• Tela: ' + AContexto.GetTela   + sLineBreak +
    '• Data/Hora: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', ADataHora) + sLineBreak +
    '• Ação: ' + AContexto.GetEvento + sLineBreak + #10#13 +
    '• Usuário: ' + IntToStr(AContexto.GetUsuarioId) +' - ' + AContexto.GetUsuarioNome + sLineBreak +
    '• Empregador: ' + IntToStr(AContexto.GetEmpregadorId) + ' - ' + AContexto.GetEmpregadorNome + sLineBreak +
    '• Profissional: ' + IntToStr(AContexto.GetProfissionalId)  + ' - ' + AContexto.GetProfissionalNome;

//    'Unidade:' + sLineBreak +
//    '- Nome: ' + AContexto.GetUnidadeNome + sLineBreak +
//    '- ID: '   + IntToStr(AContexto.GetUnidadeId) + sLineBreak + sLineBreak +


end;

class function TAuditoriaNarrativa.BuildAlteracao(
  const AContexto: IAuditoriaContexto;
  const ADataHora: TDateTime;
  const AItens: TList<TAuditoriaAlteracaoItem>
): string;
var
  Item: TAuditoriaAlteracaoItem;
begin
  Result := Self.MontarEvento(AContexto, ADataHora) + sLineBreak;

  if not Trim(AContexto.GetIdAfetado).IsEmpty then
    Result := Result +
      '• ID Afetado: ' + AContexto.GetIdAfetado   + sLineBreak + sLineBreak ;

  if (AItens = nil) or (AItens.Count = 0) then
    Exit;

  Result := Result + sLineBreak + sLineBreak +
      '*** CAMPOS ALTERADOS:' + sLineBreak + sLineBreak;

  for Item in AItens do
  begin
    Result := Result +
      '• ' + Item.Campo + sLineBreak +
      '  Antes: ' + VarToStr(Item.ValorAntes) + sLineBreak +
      '  Depois: ' + VarToStr(Item.ValorDepois) + sLineBreak + sLineBreak;
  end;

end;

end.

