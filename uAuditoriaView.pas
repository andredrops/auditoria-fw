unit uAuditoriaView;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  System.Hash,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,

  uAuditoriaAlteracaoItem,
  uAuditoriaIntf;

type

  TAuditoriaView = class(TInterfacedObject, IAuditoriaView)
  private
    class var FInstance: IAuditoriaView;

    FAntes: TDictionary<string, Variant>;
    FDepois: TDictionary<string, Variant>;
    FAlteracoes: TList<TAuditoriaAlteracaoItem>;
    FBlackList: TList<TComponent>;

    procedure CapturarComponentes(AControl: TWinControl; ADestino: TDictionary<string, Variant>);
    function NormalizarValor(const V: Variant): string;
    function ObterDescricao(AComp: TComponent): string;
    function IgnorarComponente(AComp: TComponent): Boolean;
    function HashImagem(AGraphic: TGraphic): string;

  public
    class function GetInstance(): IAuditoriaView;

    constructor Create;
    destructor Destroy; override;

    function AddToBlacklist(AComponent: TComponent): IAuditoriaView;

    procedure CapturarEstadoInicial(AForm: TCustomForm);
    function GerarAuditoria(AForm: TCustomForm): IAuditoriaView;

    function GetAlteracoes: TList<TAuditoriaAlteracaoItem>;
    function AsTextoAntes: string;
    function AsTextoDepois: string;
    function AsTextoCompleto: string;

    procedure Clear;
  end;

implementation

{ TAuditoriaView }

constructor TAuditoriaView.Create;
begin
  inherited Create;
  FAntes := TDictionary<string, Variant>.Create;
  FDepois := TDictionary<string, Variant>.Create;
  FAlteracoes := TList<TAuditoriaAlteracaoItem>.Create;
  FBlackList := TList<TComponent>.Create;
end;

destructor TAuditoriaView.Destroy;
begin
  Clear;
  FAntes.Free;
  FDepois.Free;
  FAlteracoes.Free;
  FBlackList.Free;
  inherited;
end;

procedure TAuditoriaView.Clear;
begin
  FAntes.Clear;
  FDepois.Clear;
  FAlteracoes.Clear;
end;

function TAuditoriaView.AddToBlacklist(AComponent: TComponent): IAuditoriaView;
begin
  if (AComponent <> nil) and not FBlackList.Contains(AComponent) then
    FBlackList.Add(AComponent);
  Result := Self;
end;

procedure TAuditoriaView.CapturarEstadoInicial(AForm: TCustomForm);
begin
  FAntes.Clear;
  CapturarComponentes(AForm, FAntes);
end;

function TAuditoriaView.GerarAuditoria(AForm: TCustomForm): IAuditoriaView;
var
  K: string;
  Item: TAuditoriaAlteracaoItem;
begin
  FDepois.Clear;
  FAlteracoes.Clear;

  CapturarComponentes(AForm, FDepois);

  for K in FDepois.Keys do
  begin
    if not FAntes.ContainsKey(K) then
      Continue;

    if NormalizarValor(FAntes[K]) <> NormalizarValor(FDepois[K]) then
    begin
      Item.Campo := K;
      Item.ValorAntes := FAntes[K];
      Item.ValorDepois := FDepois[K];
      FAlteracoes.Add(Item);
    end;
  end;

  Result := Self;
end;

function TAuditoriaView.GetAlteracoes: TList<TAuditoriaAlteracaoItem>;
begin
  Result := FAlteracoes;
end;

class function TAuditoriaView.GetInstance: IAuditoriaView;
begin
  if not Assigned(FInstance) then
    FInstance := TAuditoriaView.Create;

  Result := FInstance;
end;

function TAuditoriaView.AsTextoAntes: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to FAlteracoes.Count - 1 do
    Result := Result +
      FAlteracoes[I].Campo + ': ' +
      VarToStr(FAlteracoes[I].ValorAntes) + sLineBreak;
end;

function TAuditoriaView.AsTextoDepois: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to FAlteracoes.Count - 1 do
    Result := Result +
      FAlteracoes[I].Campo + ': ' +
      VarToStr(FAlteracoes[I].ValorDepois) + sLineBreak;
end;

function TAuditoriaView.AsTextoCompleto: string;
var
  I: Integer;
  Antes: string;
begin
  Result := '';

  for I := 0 to FAlteracoes.Count - 1 do
  begin
    Antes := '<Vazio>';
    if not Trim(VarToStr(FAlteracoes[I].ValorAntes)).IsEmpty then
      Antes := VarToStr(FAlteracoes[I].ValorAntes);

    Result := Result +
      FAlteracoes[I].Campo + ': ' +
      Antes + ' -> ' +
      VarToStr(FAlteracoes[I].ValorDepois) + sLineBreak;
  end;
end;

//procedure TAuditoriaView.CapturarComponentes(
//  AControl: TWinControl;
//  ADestino: TDictionary<string, Variant>
//);
//var
//  I: Integer;
//  C: TComponent;
//  Desc: string;
//begin
//  for I := 0 to AControl.ComponentCount - 1 do
//  begin
//    C := AControl.Components[I];
//
//    if IgnorarComponente(C) then
//      Continue;
//
//    Desc := ObterDescricao(C);
//    if Desc = '' then
//      Continue;
//
//    if C is TCustomEdit then
//      ADestino.AddOrSetValue(Desc, TCustomEdit(C).Text)
//    else if C is TCheckBox then
//      ADestino.AddOrSetValue(Desc, TCheckBox(C).Checked)
//    else if C is TRadioButton then
//      ADestino.AddOrSetValue(Desc, TRadioButton(C).Checked)
//    else if C is TComboBox then
//      ADestino.AddOrSetValue(Desc, TComboBox(C).Text)
//    else if C is TDateTimePicker then
//      ADestino.AddOrSetValue(Desc, TDateTimePicker(C).Date)
//    else if C is TImage then
//      ADestino.AddOrSetValue(Desc, HashImagem(TImage(C).Picture.Graphic));
//
//    if C is TWinControl then
//      CapturarComponentes(TWinControl(C), ADestino);
//  end;
//end;

procedure TAuditoriaView.CapturarComponentes(
  AControl: TWinControl;
  ADestino: TDictionary<string, Variant>
);
var
  I: Integer;
  C: TControl;
  Desc: string;
begin
  for I := 0 to AControl.ControlCount - 1 do
  begin
    C := AControl.Controls[I];

    // se você ainda quiser ignorar containers, faça isso com cuidado:
    // ex: ignorar somente certos nomes/classes, mas NÃO Panel/PageControl/TabSheet
    if IgnorarComponente(C) then
      Continue;

    Desc := ObterDescricao(C);
    if (Desc = '') and (not( C is TImage)) then
      Continue;

    if C is TCustomEdit then
      ADestino.AddOrSetValue(Desc, TCustomEdit(C).Text)
    else if C is TCheckBox then
      ADestino.AddOrSetValue(Desc, TCheckBox(C).Checked)
    else if C is TRadioButton then
      ADestino.AddOrSetValue(Desc, TRadioButton(C).Checked)
    else if C is TComboBox then
      ADestino.AddOrSetValue(Desc, TComboBox(C).Text)
    else if C is TDateTimePicker then
      ADestino.AddOrSetValue(Desc, TDateTimePicker(C).Date)
    else if C is TImage then
      ADestino.AddOrSetValue(Desc, HashImagem(TImage(C).Picture.Graphic));

    if C is TWinControl then
      CapturarComponentes(TWinControl(C), ADestino);
  end;
end;


function TAuditoriaView.IgnorarComponente(AComp: TComponent): Boolean;
begin
  Result :=
    (AComp = nil) or
    FBlackList.Contains(AComp) or
    (AComp is TButton) or
    (AComp is TLabel);
//    (AComp is TPanel) or
//    (AComp is TGroupBox) or
//    (AComp is TPageControl) or
//    (AComp is TTabSheet);
end;

function TAuditoriaView.ObterDescricao(AComp: TComponent): string;
begin
  Result := '';

  if (AComp is TWinControl) or
     (AComp is TImage) then
  begin
    if Trim(TWinControl(AComp).Hint) <> '' then
      Result := Trim(TWinControl(AComp).Hint)
    else
      Result := AComp.Name;
  end;
end;

function TAuditoriaView.NormalizarValor(const V: Variant): string;
begin
  if VarIsNull(V) then
    Exit('');
  Result := Trim(VarToStr(V));
end;

function TAuditoriaView.HashImagem(AGraphic: TGraphic): string;
var
  MS: TMemoryStream;
begin
  if (AGraphic = nil) or AGraphic.Empty then
    Exit('SEM_IMAGEM');

  MS := TMemoryStream.Create;
  try
    AGraphic.SaveToStream(MS);
    MS.Position := 0;

    Result := THashMD5.GetHashString(MS);
  finally
    MS.Free;
  end;
end;

end.

