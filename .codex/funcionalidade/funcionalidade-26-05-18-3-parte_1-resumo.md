# Resumo do Slice 1/5 - Digitação monetária por centavos

## O que foi feito
- Criado `MonetarioInputFormatter` em `lib/features/pedido_page/presentation/input_formatters/`.
- Centralizada a conversão monetária para remover separadores digitados e interpretar os dígitos como centavos.
- Aplicado o formatter em:
  - `ReciboFormulario`, no campo `Valor de entrada`;
  - `ResumoPedido`, no campo `Valor Entrada`;
  - `ProdutosServicosTabela`, no campo `Valor unitário`.
- Removidas conversões monetárias duplicadas desses widgets.
- Ajustados testes para validar que digitar `235` exibe `2,35` e envia `235` centavos para a ViewModel/callback.
- Criado teste específico para o formatter monetário.

## Próximos pontos
- Slice 2/5: tratar a remoção automática do último item acidental antes de validar e salvar o recibo.
- Preservar a regra monetária centralizada nos próximos slices, sem recriar conversores locais.

## Impacto em UI
- Sim. Os campos monetários editáveis agora formatam a digitação em tempo real por centavos:
  - `2` vira `0,02`;
  - `23` vira `0,23`;
  - `235` vira `2,35`;
  - `2350` vira `23,50`.
- A unidade entregue ao domínio e à ViewModel continua sendo centavos inteiros.
- Não houve alteração visual de layout, tema, validação financeira, PDF, impressão, compartilhamento, clientes ou rolagem.

## Contrato
- Atualizado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Justificativa: o slice altera comportamento visível de digitação dos campos monetários da `PedidoPage`.

## Regras, skills e referências lidas
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1.md`

## Validações executadas
- `dart format lib/features/pedido_page/presentation/input_formatters/monetario_input_formatter.dart lib/features/pedido_page/presentation/widgets/recibo_formulario.dart lib/features/pedido_page/presentation/widgets/resumo_pedido.dart lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart test/features/pedido_page/presentation/input_formatters/monetario_input_formatter_test.dart test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/input_formatters/monetario_input_formatter_test.dart test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter analyze`

## Bloqueios
- Nenhum bloqueio encontrado.
