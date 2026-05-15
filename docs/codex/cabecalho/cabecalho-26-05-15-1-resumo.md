# Resumo geral da tarefa

## Tarefa solicitada
- Gerar planejamento para tornar o cabeçalho editável e persistido em `SharedPreferences`, incluindo logo selecionável salvo como base64.
- Gerar planejamento para cadastro de clientes com `id`, `nome`, telefone mascarado, bloqueio de duplicidade e persistência SQLite.

## Arquivos de prompt criados
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_6.md`
- `docs/codex/cabecalho/cabecalho-26-05-15-1-resumo.md`

## Slices criados
1. `cabecalho-26-05-15-1-parte_1.md` - persistência do cabeçalho.
2. `cabecalho-26-05-15-1-parte_2.md` - estado do cabeçalho na ViewModel.
3. `cabecalho-26-05-15-1-parte_3.md` - editor visual do cabeçalho e logo.
4. `cabecalho-26-05-15-1-parte_4.md` - domínio e SQLite de clientes.
5. `cabecalho-26-05-15-1-parte_5.md` - cadastro, máscara e seleção de clientes.
6. `cabecalho-26-05-15-1-parte_6.md` - integração final e fechamento.

## Ordem correta de execução
1. Executar `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1.md`.
2. Conferir `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1-resumo.md`.
3. Executar `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2.md`.
4. Conferir `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2-resumo.md`.
5. Executar `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3.md`.
6. Conferir `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3-resumo.md`.
7. Executar `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4.md`.
8. Conferir `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4-resumo.md`.
9. Executar `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5.md`.
10. Conferir `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5-resumo.md`.
11. Executar `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_6.md`.
12. Conferir `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_6-resumo.md`.

## Validações esperadas
- `flutter analyze`
- Testes específicos de ViewModel, cabeçalho, SQLite, repository de clientes, painel de clientes e integração da `PedidoPage`.
- `flutter test` no fechamento.

## Contratos de tela criados, atualizados ou revisados
- Atualizado/revisado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato de Page/View/Tela foi criado, porque a implementação planejada permanece dentro da `PedidoPage`.

## Observações importantes para continuidade
- A implementação real deve permanecer em `lib/features/pedido_page/`.
- Não criar `ReciboPage`, rota própria ou feature paralela.
- O contrato legado `lib/features/recibo/presentation/pages/recibo_page-contrato.md` pode ser lido como referência histórica, mas a tela impactada é `PedidoPage`.
- A seleção de imagem pode exigir dependência adicional; se isso ocorrer, o slice deve justificar a escolha e manter compatibilidade Web/Desktop/Mobile.
- O logo deve ser salvo como base64 em `SharedPreferences` e o fallback visual atual deve continuar quando não houver imagem.
