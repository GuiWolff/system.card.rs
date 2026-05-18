# Resumo geral da tarefa

## Tarefa solicitada
- Modernizar o app todo para uma aparência de software de caixa empresarial, com visual atualizado para 2026 em estilo Microsoft.
- Manter `FaIcon` apenas para WhatsApp e Instagram.
- Usar ícones nativos do Flutter para todos os demais ícones.
- Criar slices pequenos para reduzir risco de estouro de contexto.

## Arquivos de prompt criados
- `.codex/layout/layout-26-05-18-1-analise.md`.
- `.codex/layout/layout-26-05-18-1.md`.
- `.codex/layout/layout-26-05-18-1-parte_1.md`.
- `.codex/layout/layout-26-05-18-1-parte_2.md`.
- `.codex/layout/layout-26-05-18-1-parte_3.md`.
- `.codex/layout/layout-26-05-18-1-parte_4.md`.
- `.codex/layout/layout-26-05-18-1-parte_5.md`.
- `.codex/layout/layout-26-05-18-1-parte_6.md`.
- `.codex/layout/layout-26-05-18-1-parte_7.md`.
- `.codex/layout/layout-26-05-18-1-resumo.md`.

## Slices
- Slice 1/7: Tema e tokens visuais.
- Slice 2/7: Shell da `PedidoPage`.
- Slice 3/7: Cabeçalho e editor.
- Slice 4/7: Ações e formulário do recibo.
- Slice 5/7: Produtos, serviços e resumo.
- Slice 6/7: Visualização e painéis auxiliares.
- Slice 7/7: Auditoria final e validação ampla.

## Ordem correta de execução
1. `.codex/layout/layout-26-05-18-1-parte_1.md`.
2. `.codex/layout/layout-26-05-18-1-parte_2.md`.
3. `.codex/layout/layout-26-05-18-1-parte_3.md`.
4. `.codex/layout/layout-26-05-18-1-parte_4.md`.
5. `.codex/layout/layout-26-05-18-1-parte_5.md`.
6. `.codex/layout/layout-26-05-18-1-parte_6.md`.
7. `.codex/layout/layout-26-05-18-1-parte_7.md`.

## Validações esperadas
- Validações por slice:
  - `flutter analyze`.
  - Testes específicos listados em cada slice.
- Validação final:
  - `flutter test`.
  - `rg -n "FontAwesomeIcons|FaIcon|font_awesome_flutter" lib/features/pedido_page/presentation test/features/pedido_page/presentation`.
- A varredura final deve confirmar que `FaIcon` e `FontAwesomeIcons` remanescentes estão ligados somente a WhatsApp e Instagram.

## Contratos de tela
- Contrato revisado por este gerador:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Contrato que deve ser atualizado em todos os slices com impacto de UI:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Nenhum contrato novo foi criado, porque a tela real impactada continua sendo `PedidoPage`.
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md` permanece como referência histórica e não foi alterado.

## Regras e skills registradas nos prompts
- `AGENTS.md`.
- `.codex/rules/RULE.md`.
- `.codex/skills/argo-flutter-dev/SKILL.md`.
- `.codex/skills/argo-flutter-dev/references/tema.md`.
- `.codex/skills/argo-rule-manager/SKILL.md`, apenas como governança consultada para geração de prompts persistentes.

## Observações importantes para continuidade
- O app real está concentrado na feature `pedido_page`.
- Não criar nova `Page`, rota ou feature paralela para este escopo.
- Não alterar regras de negócio, ViewModel, services, repositories, DTOs ou SQLite em slices visuais sem necessidade concreta.
- Não remover `font_awesome_flutter`, porque WhatsApp e Instagram ainda podem usar `FaIcon`.
- Não remover assets SVG legados sem confirmação explícita.
- O primeiro arquivo a executar é `.codex/layout/layout-26-05-18-1-parte_1.md`.
