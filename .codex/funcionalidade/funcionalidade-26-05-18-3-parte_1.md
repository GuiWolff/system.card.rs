# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/5 derivado de `.codex/funcionalidade/funcionalidade-26-05-18-3.md`.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Este é o primeiro slice; não há resumo anterior.

## Arquivos
- `lib/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart`, apenas como referência de padrão.
- Possível novo arquivo em `lib/features/pedido_page/presentation/input_formatters/`, preferencialmente para um formatter monetário reutilizável.
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- Possível novo teste em `test/features/pedido_page/presentation/input_formatters/`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Leia e atualize `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Este slice impacta UI porque muda a digitação e exibição dos campos monetários.
- Nenhum contrato novo deve ser criado.

## Regras
- Centralize a regra monetária para evitar conversões diferentes entre formulário, resumo e tabela.
- A unidade entregue ao domínio e à ViewModel continua sendo centavos inteiros.
- Digitação esperada:
  - `2` -> `0,02`;
  - `23` -> `0,23`;
  - `235` -> `2,35`;
  - `2350` -> `23,50`.
- Remover separadores digitados pelo usuário antes de recalcular o valor.
- Preservar foco e sincronização dos `TextEditingController` existentes.
- Não alterar regras de validação financeira neste slice.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não introduza pacote novo para formatter monetário.

## Entregáveis
1. Formatter/helper monetário reutilizável.
2. Campos monetários de `ReciboFormulario`, `ResumoPedido` e `ProdutosServicosTabela` usando a mesma regra.
3. Testes cobrindo a digitação por centavos.
4. Atualização de `pedido_page-contrato.md`.
5. Resumo em `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1-resumo.md`.

# Descrição
- Implementar a digitação monetária por centavos nos campos de reais usados no recibo.

## Objetivo
- Ao digitar `235` em qualquer input monetário relevante, a UI deve mostrar `2,35` e a ViewModel deve receber `235` centavos.
