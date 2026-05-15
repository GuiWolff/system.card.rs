# Resumo geral da tarefa

## Tarefa solicitada
- Gerar planejamento para aplicar nos componentes do projeto um estilo inspirado nas imagens da pasta `lib/resources/*`.
- Usar as cores da identidade visual encontrada nos recursos e modernizar o layout.

## Arquivos de prompt criados
- `docs/codex/layout/layout-26-05-15-1-analise.md`
- `docs/codex/layout/layout-26-05-15-1.md`
- `docs/codex/layout/layout-26-05-15-1-parte_1.md`
- `docs/codex/layout/layout-26-05-15-1-parte_2.md`
- `docs/codex/layout/layout-26-05-15-1-parte_3.md`
- `docs/codex/layout/layout-26-05-15-1-parte_4.md`
- `docs/codex/layout/layout-26-05-15-1-parte_5.md`
- `docs/codex/layout/layout-26-05-15-1-resumo.md`

## Lista de slices
1. `docs/codex/layout/layout-26-05-15-1-parte_1.md` - tema e base visual.
2. `docs/codex/layout/layout-26-05-15-1-parte_2.md` - estrutura da `PedidoPage`.
3. `docs/codex/layout/layout-26-05-15-1-parte_3.md` - cabeçalho e ações.
4. `docs/codex/layout/layout-26-05-15-1-parte_4.md` - recibo editável e painéis.
5. `docs/codex/layout/layout-26-05-15-1-parte_5.md` - resumo, visualização, dialogs e fechamento.

## Ordem correta de execução
1. Executar `docs/codex/layout/layout-26-05-15-1-parte_1.md`.
2. Conferir `docs/codex/layout/layout-26-05-15-1-parte_1-resumo.md`.
3. Executar `docs/codex/layout/layout-26-05-15-1-parte_2.md`.
4. Conferir `docs/codex/layout/layout-26-05-15-1-parte_2-resumo.md`.
5. Executar `docs/codex/layout/layout-26-05-15-1-parte_3.md`.
6. Conferir `docs/codex/layout/layout-26-05-15-1-parte_3-resumo.md`.
7. Executar `docs/codex/layout/layout-26-05-15-1-parte_4.md`.
8. Conferir `docs/codex/layout/layout-26-05-15-1-parte_4-resumo.md`.
9. Executar `docs/codex/layout/layout-26-05-15-1-parte_5.md`.
10. Conferir `docs/codex/layout/layout-26-05-15-1-parte_5-resumo.md`.

## Validações esperadas
- `flutter analyze` em cada slice que alterar Dart/Flutter.
- Testes específicos indicados em cada slice.
- Testes responsivos em larguras próximas de 390, 768, 1024 e 1366 pixels.
- `flutter test` no fechamento, caso o impacto acumulado seja amplo.

## Contratos de tela criados, atualizados ou revisados
- Contrato a ler e atualizar durante a execução:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato legado apenas como referência:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Nenhum contrato novo deve ser criado porque a tela impactada continua sendo `PedidoPage`.
- Este gerador não alterou o contrato existente para preservar alterações já presentes no worktree; os slices exigem atualização incremental do contrato quando forem executados.

## Observações importantes para continuidade
- O primeiro arquivo a executar é `docs/codex/layout/layout-26-05-15-1-parte_1.md`.
- Não executar slices em paralelo.
- Não criar `ReciboPage`, nova rota ou feature paralela.
- As imagens de `lib/resources` são referências visuais, não assets finais obrigatórios dentro da UI.
- A paleta deve ficar centralizada no tema.
- Preservar estado reativo existente com `Rx`/`Obx`.
- Não mover regra de negócio para widgets.
- O worktree já possuía alterações antes deste planejamento; preserve-as.

## Execução concluída
- Os 5 slices foram executados em ordem crescente:
  1. `docs/codex/layout/layout-26-05-15-1-parte_1.md`
  2. `docs/codex/layout/layout-26-05-15-1-parte_2.md`
  3. `docs/codex/layout/layout-26-05-15-1-parte_3.md`
  4. `docs/codex/layout/layout-26-05-15-1-parte_4.md`
  5. `docs/codex/layout/layout-26-05-15-1-parte_5.md`
- Resumos gerados:
  - `docs/codex/layout/layout-26-05-15-1-parte_1-resumo.md`
  - `docs/codex/layout/layout-26-05-15-1-parte_2-resumo.md`
  - `docs/codex/layout/layout-26-05-15-1-parte_3-resumo.md`
  - `docs/codex/layout/layout-26-05-15-1-parte_4-resumo.md`
  - `docs/codex/layout/layout-26-05-15-1-parte_5-resumo.md`
- Contrato revisado em todos os slices com impacto de UI:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Validação final executada:
  - `flutter analyze`
  - testes específicos por slice
  - `flutter test`
- Resultado final: a `PedidoPage` mantém os fluxos funcionais existentes e passa a usar uma identidade visual consistente com a System Card - RS em tema, cabeçalho, estrutura, recibo editável, resumo, visualização e dialogs.
