# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 5/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

## Análise da tarefa
- `.codex/layout/layout-26-05-18-1-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Use `.codex/skills/argo-flutter-dev/SKILL.md`.
- Use `.codex/skills/argo-flutter-dev/references/tema.md`.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/layout/layout-26-05-18-1-parte_4-resumo.md`.
- Leia os resumos anteriores e preserve tema, shell, cabeçalho, ações e formulário já aplicados.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`.
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`.
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não criar contrato novo; os widgets alterados pertencem à `PedidoPage`.

## Regras
- Modernizar a tabela de produtos/serviços como grade operacional de caixa.
- Preservar `ListView.separated`, edição, remoção, adição e fluxo de teclado existente.
- Modernizar o resumo financeiro como painel denso de totais, sem recalcular regra no widget.
- Migrar ícones de adicionar/remover e qualquer outro ícone para `Icon` com `Icons.*`.
- Atualizar testes correspondentes.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não alterar modelos, ViewModel, validações financeiras, repository ou SQLite.
- Não criar nova tabela genérica fora da feature.

## Entregáveis
1. `ProdutosServicosTabela` modernizada e com ícones nativos.
2. `ResumoPedido` modernizado sem alterar regras financeiras.
3. Testes relacionados atualizados.
4. Contrato `pedido_page-contrato.md` atualizado.
5. Registrar no resumo do slice quais contratos de tela foram atualizados.
6. Rodar validações específicas conforme a skill aplicável.
7. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_5-resumo.md`.

# Descrição
- Este slice cuida da parte mais operacional do caixa: itens do pedido e totais. A mudança deve melhorar leitura, densidade e alinhamento sem mexer no domínio.

## Objetivo
- Ao final deste slice, produtos/serviços e resumo financeiro devem ter aparência consistente com um software de caixa empresarial e não devem usar `FaIcon`.
