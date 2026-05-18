---
name: argo-flutter-dev
description: Guia local para alterações Dart/Flutter no projeto Argo Portal Shellbox. Use quando Codex precisar implementar, revisar ou planejar mudanças em lib/, test/, telas, widgets, ViewModels, controllers, repositories, services, models, tema, estado reativo, performance ou validações Flutter.
---

# Argo Flutter Dev

## Fluxo de trabalho

1. Leia `.codex/rules/RULE.md`.
2. Identifique a feature correspondente antes de criar ou alterar arquivos.
3. Localize padrões existentes próximos da alteração e siga a mesma composição.
4. Se a tarefa tocar UI, tema, cores, tipografia, superfícies ou mensagens de erro, leia `references/tema.md`.
5. Implemente a menor mudança que resolva o pedido.
6. Ajuste ou adicione testes quando houver lógica, contrato público ou risco de regressão.
7. Valide conforme a seção "Validação".

## Decisões de arquitetura

- Mantenha a organização vertical por feature em `lib/features/`.
- Antes de criar ou alterar uma tela, identifique a feature correspondente.
- Login, logout, cadastro e recuperação de senha ficam em `lib/features/auth/`.
- Perfil do usuário fica em `lib/features/profile/`.
- Dashboard fica em `lib/features/dashboard/`.
- Evite criar pastas horizontais globais novas, como `lib/views/`, `lib/viewmodels/`, `lib/repositories/`, `lib/services/` ou `lib/models/`, exceto para manutenção localizada de estrutura já existente.
- Separe responsabilidades: Page renderiza, widget compõe, ViewModel coordena estado e fluxo, repository acessa dados, service concentra regra reutilizável.
- Não coloque regra de negócio no widget.
- Não coloque código visual na ViewModel.
- Não faça controller ou ViewModel depender de `BuildContext`.

Estrutura padrão de feature:

```txt
lib/features/nome_da_feature/
  presentation/
    pages/
    widgets/
    viewmodels/
  domain/
    models/
    repositories/
  data/
    repositories/
    datasources/
    dtos/
  services/
```

## Imports Dart

- Use import absoluto do pacote, como `import 'package:argo_portal_shellbox/app_routes.dart';`.
- Não use import abreviado ou relativo longo, como `import '../../../../app_routes.dart';`.
- Ao finalizar, verifique imports não utilizados.

## Estado reativo

- Prefira os utilitários reativos do projeto em `lib/observable/`.
- Use `obx.dart` para observação na UI.
- Use tipos de `rx.dart` para variáveis reativas.
- Atualize estado no controller ou ViewModel.
- Só use `setState` para estado local, temporário e sem valor para o restante da tela.

## Implementação Flutter

- Prefira `StatelessWidget`.
- Use `const` quando possível.
- Prefira composição a herança.
- Use listas com builder para coleções que podem crescer.
- Use um widget por responsabilidade.
- Quebre widgets grandes em widgets menores com responsabilidade clara.
- Evite arquivos acima de 500 linhas.
- Evite lógica pesada dentro de `build`.
- Evite múltiplos `Obx` aninhados quando uma observação mais externa resolver.

## Validação

- Para mudança pequena e localizada, rode `flutter analyze` somente quando a alteração incluir arquivos em `lib/`, `pubspec.yaml` ou `pubspec.lock`; rode testes específicos relacionados.
- Para mudança ampla, rode também `flutter test` quando viável.
- Verifique imports não utilizados e warnings.
- Garanta compatibilidade Web/Desktop/Mobile quando a mudança afetar comportamento ou UI compartilhada.
- Se uma validação falhar, corrija quando estiver no escopo; caso contrário, reporte o bloqueio com o comando e o erro essencial.
