# Resumo geral da tarefa

## Tarefa solicitada
- Analisar os dados necessários para o cabeçalho do app System Card - RS.
- Usar `lib/resources/cabecalho.png` como referência do cabeçalho.
- Usar `lib/resources/tema.jpeg` como referência do contexto da tela e dos campos do app.
- Seguir `AGENTS.md`.
- Criar slices pequenos para orientar a implementação futura.

## Arquivos de prompt criados
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5.md`
- `docs/codex/cabecalho/cabecalho-26-05-14-1-resumo.md`

## Lista de slices
1. `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md` - Estrutura base da tela.
2. `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2.md` - Dados do cabeçalho.
3. `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3.md` - Widget visual responsivo.
4. `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4.md` - Ações do cabeçalho.
5. `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5.md` - Fechamento responsivo e validação.

## Ordem correta de execução
1. Executar `cabecalho-26-05-14-1-parte_1.md`.
2. Conferir o resumo `cabecalho-26-05-14-1-parte_1-resumo.md`.
3. Executar `cabecalho-26-05-14-1-parte_2.md`.
4. Conferir o resumo `cabecalho-26-05-14-1-parte_2-resumo.md`.
5. Repetir o fluxo até o slice 5.
6. Não executar slices em paralelo.

## Validações esperadas
- `flutter analyze`
- `flutter test`
- Testes específicos de ViewModel do recibo, quando criados.
- Testes específicos do widget `CabecalhoApp`, quando criado.
- Verificação responsiva em larguras próximas de 390, 768, 1024 e 1366 pixels.

## Contratos de tela criados, atualizados ou revisados
- Criado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- O contrato deve ser lido antes de cada slice que altere a tela.
- O contrato deve ser atualizado quando o cabeçalho, seus dados, estados visuais ou ações mudarem.

## Observações importantes para continuidade
- O worktree atual não contém as features citadas em documentos antigos. A execução deve verificar os arquivos reais antes de importar dependências.
- `cabecalho.png` é referência visual. O cabeçalho final deve ser composto por widgets para manter responsividade e acessibilidade.
- Não há logo isolado no estado atual. A implementação deve tratar isso como pendência ou fallback, sem recortar imagem sem autorização explícita.
- As ações de PDF e impressão devem ser preparadas por callbacks, mas os fluxos reais ficam fora do escopo destes slices.
- O primeiro arquivo a executar é `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md`.
