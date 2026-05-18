# Resumo geral da tarefa

## Tarefa solicitada
- Planejar melhorias funcionais no recibo da feature `pedido_page`:
  - digitação monetária por centavos;
  - remoção do último item acidental vazio ao salvar;
  - autocomplete de cliente no formulário;
  - ações de imprimir e compartilhar dentro da prévia do PDF;
  - remoção de compartilhar da linha de ações rápidas;
  - correção de `Scrollbar` sem `ScrollPosition`.

## Arquivos de prompt criados
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-resumo.md`

## Lista de slices
- Slice 1/5: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1.md`
- Slice 2/5: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2.md`
- Slice 3/5: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3.md`
- Slice 4/5: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4.md`
- Slice 5/5: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5.md`

## Ordem correta de execução
1. Executar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1.md`.
2. Criar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1-resumo.md`.
3. Executar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2.md`.
4. Criar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2-resumo.md`.
5. Executar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3.md`.
6. Criar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3-resumo.md`.
7. Executar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4.md`.
8. Criar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4-resumo.md`.
9. Executar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5.md`.
10. Criar `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5-resumo.md`.

## Validações esperadas
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

## Contratos de tela criados, atualizados ou revisados
- Revisado e atualizado pelo planejamento:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum contrato novo foi criado, porque a tarefa não cria nova Page/View/Tela.
- Cada slice com alteração real em UI ou comportamento público da tela deve atualizar novamente o contrato.

## Regras e skills aplicáveis registradas nos prompts
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`

## Observações importantes para continuidade
- A feature correspondente é `pedido_page`.
- O primeiro arquivo a executar é `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1.md`.
- Não executar slices em paralelo.
- Não remover serviços ou dialogs legados sem confirmação explícita.
- O worktree já continha alterações antes deste planejamento; preserve tudo que não fizer parte do slice em execução.
