# RULE - Regras obrigatórias do projeto

Use este arquivo antes de alterar código, revisar implementação, gerar prompts de tarefa ou orientar outro agente neste repositório.

## Código e segurança

- Nunca reescreva arquivos inteiros sem necessidade.
- Preserve padrões já existentes no projeto.
- Não altere APIs públicas sem necessidade.
- Não remova código legado sem confirmação explícita.
- Prefira mudanças pequenas e localizadas.
- Evite criar arquivos desnecessários.
- Preserve alterações existentes no worktree.
- Não execute operação destrutiva como `git reset --hard` ou `git checkout --` sem autorização explícita.
- Não faça commit automaticamente.

## Validação final

Antes de finalizar alterações:

- Rode as validações exigidas pela skill aplicável ao escopo da alteração.
- Informe claramente quando alguma validação não puder ser executada.
