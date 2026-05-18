# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 5/5 derivado de `.codex/funcionalidade/funcionalidade-26-05-18-3.md`.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4-resumo.md`
- Se o resumo anterior existir e estiver válido, não refaça os slices anteriores.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`, se necessário para validar a composição final.
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`, se necessário para validação final.
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`, se necessário para validação final.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Leia e atualize `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Este slice impacta comportamento de rolagem da `PedidoPage`.
- Nenhum contrato novo deve ser criado.

## Regras
- O `Scrollbar` e o `SingleChildScrollView` devem compartilhar o mesmo `ScrollController`.
- Se `PedidoPageLayout` virar `StatefulWidget`, descarte o controller em `dispose()`.
- Defina `primary: false` no `SingleChildScrollView` quando usar controller explícito.
- Preserve `SafeArea`, padding responsivo, largura máxima, resumo lateral e ordem visual atual.
- Adicionar teste que monte a tela e execute rolagem sem lançar exceção.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não faça commit automaticamente.
- Não alterar layout visual além do necessário para corrigir a rolagem.

## Entregáveis
1. Correção do `Scrollbar` com `ScrollController` explícito.
2. Teste de montagem/rolagem sem exceção.
3. Validação final ampla dos arquivos impactados.
4. Atualização de `pedido_page-contrato.md`.
5. Resumo em `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5-resumo.md`.

# Descrição
- Corrigir a exceção `The Scrollbar's ScrollController has no ScrollPosition attached`.

## Objetivo
- A `PedidoPage` deve rolar de forma estável em Web/Desktop/Mobile sem erro de `Scrollbar`.
