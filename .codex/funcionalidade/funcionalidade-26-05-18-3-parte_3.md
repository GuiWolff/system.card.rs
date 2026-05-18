# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 3/5 derivado de `.codex/funcionalidade/funcionalidade-26-05-18-3.md`.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2-resumo.md`
- Se o resumo anterior existir e estiver válido, não refaça os slices anteriores.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart`, para formatação de telefone nas sugestões.
- `lib/features/pedido_page/domain/models/cliente.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Leia e atualize `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Este slice impacta UI porque muda a interação do campo `Cliente`.
- Nenhum contrato novo deve ser criado.

## Regras
- O campo de cliente deve pesquisar enquanto o usuário digita.
- A UI deve exibir sugestões estilo combobox/autocomplete próximas ao campo.
- O texto de cada opção deve seguir:
  - `Nome`;
  - `Nome - Telefone`, quando houver telefone;
  - `Nome - E-mail`, quando não houver telefone e houver e-mail;
  - `Nome - Telefone - E-mail`, quando ambos existirem.
- Ao selecionar um cliente, reaproveitar `PedidoPageViewModel.selecionarCliente(cliente)` para preencher nome, telefone e e-mail selecionado.
- Ao digitar texto livre, preservar `PedidoPageViewModel.atualizarCliente`.
- Não remover nem enfraquecer o painel `ClientesPainel`.
- A ViewModel não deve depender de `BuildContext`.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não introduza pacote novo de autocomplete; use widgets Flutter existentes ou composição local simples.

## Entregáveis
1. Campo de cliente com sugestões filtradas.
2. Integração com pesquisa e seleção de clientes existentes.
3. Testes cobrindo digitação, exibição de sugestões e seleção.
4. Atualização de `pedido_page-contrato.md`.
5. Resumo em `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3-resumo.md`.

# Descrição
- Adicionar busca de clientes em tempo de digitação no formulário do recibo.

## Objetivo
- O usuário deve conseguir localizar e selecionar um cliente cadastrado sem abrir o painel de clientes, mantendo o painel como fluxo complementar de cadastro/gestão.
