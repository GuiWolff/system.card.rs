# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/3 derivado de `docs/codex/usabilidade/usabilidade-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/usabilidade/usabilidade-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice; não há resumo anterior.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Leia o contrato antes de alterar UI.
- Este slice deve revisar e atualizar o contrato porque altera comportamento de foco e chaves dos campos da `PedidoPage`.

## Regras
- Corrigir a perda de foco sem mover estado de teclado para a ViewModel.
- Usar chaves estáveis para campos editáveis; não incluir texto digitado, valor formatado, quantidade ou centavos na chave do campo.
- Quando for necessário refletir valor externo no campo, usar `TextEditingController` local e sincronizar em `didUpdateWidget` com cuidado.
- Não sobrescrever o texto enquanto o usuário estiver digitando no mesmo campo, salvo quando o recibo externo mudar por ação explícita como carregar histórico, duplicar ou novo recibo.
- Preservar formatadores, callbacks existentes e cálculo reativo do resumo.
- Atualizar testes para localizar campos por chaves estáveis ou por semântica/label.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente Enter para adicionar item neste slice.
- Não implemente bloqueio de edição do histórico neste slice.
- Não faça commit.

## Entregáveis
1. Campos de `ReciboFormulario` mantendo foco durante digitação.
2. Campos de `ProdutosServicosTabela` mantendo foco durante digitação.
3. Campo editável de `ResumoPedido` mantendo foco durante digitação.
4. Testes atualizados para chaves estáveis e foco preservado.
5. Atualizar `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1-resumo.md`.

# Descrição
- O problema atual nasce de `TextFormField` com `initialValue` e `ValueKey` dependente do valor. Cada dígito atualiza a ViewModel, o `Obx` reconstrói a tela e o campo é remontado com outra chave, perdendo foco.
- Substitua esse padrão por campos com identidade estável e controle local de texto quando necessário.

## Objetivo
- Ao final deste slice, digitar em campos de recibo, itens e resumo deve manter o foco sem exigir novo clique do mouse a cada caractere.
