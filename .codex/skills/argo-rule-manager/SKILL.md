---
name: argo-rule-manager
description: Governança para criar, alterar, revisar ou recusar regras persistentes e regras de carregamento dinâmico do projeto Argo Portal Shellbox. Use quando Codex precisar editar AGENTS.md, .codex/rules/RULE.md, .codex/skills/**/SKILL.md, referências de skills, ou decidir onde uma nova regra deve viver sem criar ambiguidade, duplicidade ou conflito.
---

# Argo Rule Manager

## Objetivo

Gerenciar mudanças nas regras do projeto com uma fonte de verdade clara. Nenhuma regra deve ser adicionada quando for ambígua, duplicada ou conflitante com instruções existentes.

## Fontes de regra

- `AGENTS.md`: regras persistentes carregadas em toda sessão. Manter pequeno; usar apenas para idioma, tom, regras críticas e gatilhos de carregamento sob demanda.
- `.codex/rules/RULE.md`: regras gerais do projeto carregadas antes de alterações de código, revisão técnica, geração de prompts ou orientação de agentes.
- `.codex/skills/*/SKILL.md`: fluxos de trabalho específicos de domínio ou tarefa.
- `.codex/skills/*/references/*.md`: detalhes extensos, exemplos ou políticas que só devem ser carregados quando necessários.

## Fluxo obrigatório

1. Leia `AGENTS.md` e `.codex/rules/RULE.md`.
2. Se a regra tocar Dart, Flutter, UI, arquitetura, estado, testes, performance, tema ou mensagens de erro, leia também `.codex/skills/argo-flutter-dev/SKILL.md` e, quando aplicável, `references/tema.md`.
3. Procure regras relacionadas antes de editar:
   - `rg -n "termo|sinonimo|conceito" AGENTS.md .codex`
   - Ajuste os termos para cobrir nomes técnicos, caminhos, responsabilidades e negações.
4. Classifique a regra pelo menor escopo suficiente:
   - regra sempre necessária: `AGENTS.md`;
   - regra geral do projeto: `.codex/rules/RULE.md`;
   - regra de fluxo ou domínio específico: skill existente;
   - detalhe longo de domínio: reference da skill existente.
5. Valide conflito, duplicidade e ambiguidade antes de alterar qualquer arquivo.
6. Faça a menor edição localizada possível, preferindo ajustar uma regra existente a criar uma regra paralela e evitando replicar a mesma regra em vários arquivos.
7. Após editar, revise o diff e valide que a nova redação tem escopo, obrigação e exceções claros.

## Critérios de rejeição

Não adicione a regra quando qualquer item abaixo for verdadeiro:

- contradiz uma regra existente sem autorização explícita para substituir a regra anterior;
- repete uma regra já existente sem acrescentar escopo, exceção ou precisão;
- usa termos vagos como "adequado", "moderno", "simples" ou "melhor" sem critério verificável;
- usa "sempre" ou "nunca" sem escopo e sem exceções quando existirem casos legítimos;
- mistura mais de uma decisão independente na mesma regra;
- define comportamento de Dart/Flutter, UI ou tema fora da skill ou referência responsável;
- exige ferramenta, serviço externo ou permissão que não está disponível no projeto;
- torna `AGENTS.md` maior com detalhe que pode ser carregado sob demanda.

Ao rejeitar, informe o motivo e cite a regra ou arquivo que causou a rejeição. Quando possível, proponha uma versão alternativa sem aplicá-la automaticamente.

## Resolução de conflitos

- Se uma regra nova conflitar com uma antiga, não edite. Explique o conflito e peça confirmação explícita para substituir, remover ou especializar a regra existente.
- Se duas regras parecem conflitantes apenas por falta de escopo, refine a regra existente para deixar claro onde cada uma se aplica.
- Se a regra pertence a uma skill existente, edite essa skill em vez de duplicar a orientação em `RULE.md`.
- Se a regra pertence a uma referência de tema, mantenha o detalhe em `references/tema.md` e deixe no nível superior apenas o gatilho de carregamento.

## Formato recomendado

Escreva regras como instruções objetivas, imperativas e verificáveis:

```md
- Para [escopo/cenário], [ação obrigatória/proibida], exceto quando [exceção objetiva].
```

Evite regras baseadas em preferência sem critério:

```md
- Faça telas melhores e modernas.
```

Prefira uma regra objetiva e imperativa:

```md
- Para telas com listas que podem crescer, use widgets com builder e evite montar todos os itens no build inicial.
```

## Validação final

- Rode `git diff --check` quando houver edição em arquivos de regras ou skills.
- Se editar ou criar uma skill, rode `quick_validate.py` para cada skill alterada.
- Rode `flutter analyze` somente quando a alteração incluir arquivos em `lib/`, `pubspec.yaml` ou `pubspec.lock`, se viável.
- Informe claramente validações executadas, bloqueios e regras recusadas.
