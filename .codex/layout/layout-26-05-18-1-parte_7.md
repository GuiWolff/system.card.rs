# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 7/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

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
- Slice anterior: `.codex/layout/layout-26-05-18-1-parte_6-resumo.md`.
- Leia todos os resumos anteriores antes de fazer auditoria final.

## Arquivos
- `lib/features/pedido_page/presentation/`.
- `test/features/pedido_page/presentation/`.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- `pubspec.yaml`, apenas para verificar dependências e não para remover sem necessidade.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não criar contrato novo; o fechamento documenta a `PedidoPage`.

## Regras
- Fazer auditoria final de ícones:
  - `FaIcon` e `FontAwesomeIcons` só podem aparecer para WhatsApp e Instagram.
  - Demais ícones visíveis devem estar em `Icon`/`Icons.*`.
- Corrigir imports não utilizados.
- Revisar textos, overflow, densidade e responsividade.
- Confirmar que não houve alteração indevida de comportamento.
- Atualizar ou consolidar testes sem mascarar falhas reais.
- Registrar no contrato o estado final da modernização e pendências reais.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture novas funcionalidades neste fechamento.
- Não execute automaticamente outro slice.
- Não faça commit automaticamente.
- Não remover dependências, assets ou código legado sem justificativa segura e localizada.
- Não alterar regra de negócio para passar teste visual.

## Entregáveis
1. Auditoria de ícones concluída.
2. Imports e testes de UI ajustados.
3. Responsividade revisada para desktop, largura estreita e mobile.
4. Contrato `pedido_page-contrato.md` atualizado com o estado final.
5. Registrar no resumo do slice quais contratos de tela foram atualizados.
6. Rodar validações finais.
7. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_7-resumo.md`.

# Descrição
- Este slice é o fechamento técnico. Ele não deve criar uma nova direção visual; deve confirmar que todos os slices anteriores chegaram ao contrato pedido.

## Objetivo
- Ao final deste slice, o app deve estar modernizado, validado e com a regra de ícones cumprida em código, testes e contrato.
