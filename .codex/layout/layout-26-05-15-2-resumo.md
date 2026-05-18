# Resumo geral da tarefa

## Tarefa solicitada
- Gerar planejamento para ajustes de layout na `PedidoPage`, incluindo cabeçalho, recibo, tabela de produtos/serviços, editor de cabeçalho e cadastro de e-mail para clientes/usuários com participação no compartilhamento por e-mail.

## Arquivos de prompt criados
- `docs/codex/layout/layout-26-05-15-2-analise.md`
- `docs/codex/layout/layout-26-05-15-2.md`
- `docs/codex/layout/layout-26-05-15-2-parte_1.md`
- `docs/codex/layout/layout-26-05-15-2-parte_2.md`
- `docs/codex/layout/layout-26-05-15-2-parte_3.md`
- `docs/codex/layout/layout-26-05-15-2-parte_4.md`
- `docs/codex/layout/layout-26-05-15-2-resumo.md`

## Lista de slices
1. `docs/codex/layout/layout-26-05-15-2-parte_1.md` - cabeçalho, edição e ícones.
2. `docs/codex/layout/layout-26-05-15-2-parte_2.md` - layout do recibo e alinhamento da tabela.
3. `docs/codex/layout/layout-26-05-15-2-parte_3.md` - e-mail no domínio e SQLite.
4. `docs/codex/layout/layout-26-05-15-2-parte_4.md` - e-mail na UI e compartilhamento.

## Ordem correta de execução
1. Executar `docs/codex/layout/layout-26-05-15-2-parte_1.md`.
2. Conferir `docs/codex/layout/layout-26-05-15-2-parte_1-resumo.md`.
3. Executar `docs/codex/layout/layout-26-05-15-2-parte_2.md`.
4. Conferir `docs/codex/layout/layout-26-05-15-2-parte_2-resumo.md`.
5. Executar `docs/codex/layout/layout-26-05-15-2-parte_3.md`.
6. Conferir `docs/codex/layout/layout-26-05-15-2-parte_3-resumo.md`.
7. Executar `docs/codex/layout/layout-26-05-15-2-parte_4.md`.
8. Conferir `docs/codex/layout/layout-26-05-15-2-parte_4-resumo.md`.

## Validações esperadas
- `flutter analyze` em cada slice que alterar Dart/Flutter.
- Testes específicos indicados em cada slice.
- Testes responsivos em larguras próximas de 390, 720, 920, 1024 e 1366 pixels nos slices de UI.
- `flutter test` no fechamento do slice 4.

## Contratos de tela criados, atualizados ou revisados
- Contrato revisado como insumo de planejamento:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato legado revisado apenas como referência:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Nenhum contrato novo deve ser criado.
- O contrato `pedido_page-contrato.md` deve ser atualizado pelos slices que alterarem UI. Este gerador não modificou fisicamente o contrato porque ele já estava alterado no worktree antes deste planejamento.

## Observações importantes para continuidade
- O primeiro arquivo a executar é `docs/codex/layout/layout-26-05-15-2-parte_1.md`.
- Não executar slices em paralelo.
- Não criar nova Page, rota ou feature paralela.
- Preservar as alterações já existentes no worktree.
- A remoção dos botões do cabeçalho deve ser visual/comportamental, evitando remoção desnecessária de APIs públicas ou legado.
- A correção da tabela deve usar uma fonte única de larguras/espaçamentos entre cabeçalho e linhas.
- O e-mail do cliente deve ser opcional.
- O compartilhamento por e-mail deve respeitar as limitações reais da plataforma e do `share_plus`; não registrar promessa de destinatário obrigatório com anexo quando a API não garantir isso.
