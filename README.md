# auditoria-fw

# 🛡️ Auditoria Framework (Delphi)

Framework interno para auditoria de sistemas Delphi, focado em **simplicidade, desacoplamento e reutilização**.

Ele separa claramente:
- **Contexto** (quem / onde)
- **Evento** (o que aconteceu)
- **Alteração** (o que mudou)
- **View** (coleta de dados da tela)
- **Persistência** (onde salvar)

Ideal para projetos Desktop VCL e facilmente extensível para outros cenários.

---

## ✨ Características

- Auditoria de **eventos** (ações pontuais)
- Auditoria de **alterações** (antes / depois)
- Contexto compartilhável
- Persistência desacoplada (Zeos / FireDAC)
- Uso simples nos Forms
- Código limpo e didático
- Licença MIT

---

## 🧩 Componentes

### 🔹 Contexto (`IAuditoriaContexto`)
Define **quem executou a ação** e **em qual ambiente**.

Exemplos:
- Usuário
- Unidade
- Empregador
- Profissional
- Módulo
- Tela
- Origem
- Ambiente / Suporte

O mesmo contexto pode ser reutilizado em **Evento** e **Alteração**.

---

### 🔹 Evento (`IAuditoriaEvento`)
Registra ações que **não alteram dados**.

Exemplos:
- Salvar
- Imprimir
- Exportar
- Excluir
- Login / Logout

Grava:
- contexto
- operação
- descrição do evento

---

### 🔹 Alteração (`TAuditoriaAlteracao`)
Registra **mudanças reais de dados**.

- Trabalha com valores **antes / depois**
- Só persiste se houver alteração
- Utiliza a `AuditoriaView`
- Grava na tabela de auditoria geral

---

### 🔹 View (`IAuditoriaView`)
Responsável por varrer os componentes do Form.

- Captura estado inicial
- Compara estado final
- Lista alterações
- Gera texto de auditoria

Não conhece banco de dados.

---

### 🔹 Persistência (`IAuditPersistence`)
Camada desacoplada para gravação dos dados.

Implementações:
- Zeos
- FireDAC

Permite troca de tecnologia sem impacto nos Forms.

---

### 🔹 Factory (`TAuditoriaFactory`)
Ponto único de criação dos objetos de auditoria.

Evita:
- excesso de `uses`
- múltiplos `Create`
- configuração inconsistente

---

## 🚀 Uso Básico

### Declaração no Form

---

### 🔹 Declaração das variaveis

```pascal
private 
  FAuditoriaContexto: IAuditoriaContexto;
  FAuditoriaEvento: IAuditoriaEvento;
  FAuditoriaView: IAuditoriaView;
  FAuditoriaAlteracao: TAuditoriaAlteracao;
```

---

### 🔹 Aplicação nos eventos
> FormCreate
```pascal
procedure TfTeste.FormCreate(Sender: TObject);
begin
  FAuditoriaContexto := TAuditoriaFactory.CriarContexto
    .SetModulo('Cadastro')
    .SetTela('Funcionário')
    .SetOrigem('Desktop')
    .SetUsuarioId(10)
    .SetUsuarioNome('Professor');

  FAuditoriaView := TAuditoriaFactory.CriarView;

  FAuditoriaEvento := TAuditoriaFactory.CriarEvento(
    ZConnection1,
    FAuditoriaContexto
  );

  FAuditoriaAlteracao := TAuditoriaFactory.CriarAlteracao(
    ZConnection1,
    FAuditoriaContexto,
    FAuditoriaView
  );
end;
```

> FormShow
```pascal
procedure TfTeste.FormShow(Sender: TObject);
begin
  FAuditoriaView.CapturarEstadoInicial(Self);
end;
```

> Botão Salvar
```pascal
procedure TfTeste.btnSalvarClick(Sender: TObject);
begin
  GravarDadosNoBanco;

  FAuditoriaView.GerarAuditoria(Self);
  FAuditoriaAlteracao.Persistir;
  
  FAuditoriaEvento
    .SetOperacao('SALVAR')
    .SetDescricao('Salvou cadastro de funcionário')
    .Gerar;
end;
```
---

### 🔹 Estrutura de Pastas
```pascal
Auditoria/
  uIAuditoria.pas
  uIAuditPersistence.pas
  uAuditPersistenceZeos.pas
  uAuditPersistenceFireDAC.pas

  uAuditoriaContexto.pas
  uAuditoriaView.pas
  uAuditoriaEvento.pas
  uAuditoriaAlteracao.pas
  uAuditoriaFactory.pas
```
---

### 🧠 Boas Práticas

> Use Evento para ações sem alteração de dados
> Use Alteração apenas após salvar os dados
> Capture o estado inicial no OnShow
> Use AddToBlacklist para ignorar campos irrelevantes
> Compartilhe o mesmo Contexto sempre que possível


