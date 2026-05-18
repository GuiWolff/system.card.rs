# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 4/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

## Análise da tarefa
- `.codex/layout/layout-26-05-18-1-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Use `.codex/skills/argo-flutter-dev/SKILL.md`.
- Use `.codex/skills/argo-flutter-dev/references/tema.md`.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/layout/layout-26-05-18-1-parte_3-resumo.md`.
- Leia os resumos anteriores e preserve tema, shell e cabeçalho já aplicados.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`.
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`.
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não criar contrato novo; os widgets alterados pertencem à `PedidoPage`.

## Regras
- Modernizar a área de ações do recibo como barra de comandos operacional.
- Modernizar o formulário para leitura rápida e preenchimento repetitivo.
- Preservar callbacks, estados de carregamento, modo somente leitura, mensagens e bloqueios existentes.
- Migrar todos os ícones destes arquivos para `Icon` com `Icons.*`, pois nenhum deles representa WhatsApp ou Instagram.
- Atualizar testes que validam `FaIcon` nesses widgets.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não alterar cálculos, persistência, geração de PDF, impressão, compartilhamento ou histórico.
- Não alterar a API pública de `ReciboPedido` e `ReciboFormulario` sem necessidade real.

## Entregáveis
1. `ReciboPedido` com ações modernizadas e ícones nativos.
2. `ReciboFormulario` com campos modernizados e ícones nativos.
3. Testes relacionados atualizados.
4. Contrato `pedido_page-contrato.md` atualizado.
5. Registrar no resumo do slice quais contratos de tela foram atualizados.
6. Rodar validações específicas conforme a skill aplicável.
7. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_4-resumo.md`.

# Descrição
- Este slice foca na área onde o operador cria e manipula o recibo. A prioridade é eficiência visual, clareza de estado e preservação do fluxo existente.

## Objetivo
- Ao final deste slice, ações e formulário do recibo devem parecer parte de um caixa empresarial moderno e não devem usar `FaIcon`.
