# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/5 derivado de `docs/codex/cabecalho/cabecalho-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2-resumo.md`
- Antes de iniciar, leia os resumos dos slices anteriores e preserve o estado já produzido.

## Arquivos
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/cabecalho_app.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/models/cabecalho_empresa.dart`
- `test/features/recibo/presentation/widgets/cabecalho_app_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `recibo_page-contrato.md` com o comportamento visual e responsivo do cabeçalho.

## Regras
- Criar `CabecalhoApp` como widget de apresentação.
- O widget deve receber os dados necessários por parâmetro ou por objeto de dados, sem buscar dependências globais diretamente.
- Usar `cabecalho.png` e `tema.jpeg` apenas como referência visual.
- Não renderizar o cabeçalho completo como uma imagem única.
- Se não houver logo isolado, usar fallback claro e documentar a pendência no resumo do slice.
- Implementar layout responsivo:
  - desktop: identidade, contatos e ações em linha;
  - tablet: permitir quebra controlada;
  - mobile: empilhar seções sem overflow.
- Usar ícones Material existentes para contatos e ações quando possível.
- Evitar textos que estourem o container, especialmente endereço e botões.
- Usar cores semânticas do `ThemeData` existente. Só usar cores específicas da marca quando não houver equivalente claro no tema, mantendo constantes privadas localizadas.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente PDF ou impressão real.
- Não altere regras de dados criadas no slice anterior sem necessidade.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. `CabecalhoApp` criado e integrado à `ReciboPage`.
2. Layout responsivo cobrindo desktop, tablet e mobile.
3. Testes de widget verificando textos principais e ausência de overflow em larguras representativas.
4. Atualização de `recibo_page-contrato.md`.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3-resumo.md`.

# Descrição
- Construir a aparência do cabeçalho da System Card - RS de forma composta, acessível e responsiva.

## Objetivo
- Ao final deste slice, a `ReciboPage` deve exibir o cabeçalho visualmente próximo das referências e funcional em múltiplas larguras.
