# Robot Framework + Appium — carrinho Android

[English version](README.en.md)

Cinco cenários executados com UiAutomator2 no APK oficial [My Demo App 2.3.0](https://github.com/saucelabs/my-demo-app-android/releases/tag/2.3.0), da Sauce Labs. Organização igual à dos meus projetos Robot: `Clients` seleciona os testes, `TestCases` compõe os fluxos, `Pages` concentra os locators e `Resources` abre e fecha a sessão.

## Cenários

- Aumentar e diminuir a quantidade, conferindo quantidade, itens e total.
- Remover o último produto e impedir checkout com carrinho vazio.
- Voltar do background sem perder o estado do carrinho.
- Bloquear a inclusão com quantidade zero e reabilitar com quantidade positiva.
- Encerrar o processo e confirmar o carrinho vazio na nova sessão.

O último comportamento é um limite do app: o carrinho fica no singleton em memória. Retomar do background não é o mesmo que reiniciar o processo. O teste não atribui persistência que o aplicativo não implementa. Referência: `SingletonClass` no [código da versão](https://github.com/saucelabs/my-demo-app-android/tree/3e514167ec715abf6ab93e148ef6f97b86752c05).

## Execução

Python 3.13, Node 24, Java 21, Android SDK e um emulador Android 34. Execute a partir da raiz do repo:

```bash
cp .env.example .env
python -m venv .venv
python -m pip install -r requirements.txt
npm ci
npx appium driver list --installed
```

O UiAutomator2 é instalado pelo `npm ci` a partir do lockfile. A listagem acima confirma o driver; não é preciso instalá-lo novamente.

Ative a `.venv` antes de instalar Python: `.venv\Scripts\activate` no Windows ou `source .venv/bin/activate` no Linux. No PowerShell use `Copy-Item .env.example .env`. Baixe o APK da release oficial para o `APP_PATH` definido no `.env` e ajuste `ANDROID_DEVICE` ao resultado de `adb devices`.

Em um terminal, `npm run appium`. Em outro:

```bash
python run_tests.py --outputdir results --xunit junit.xml src/Appium/Clients
```

O Appium escuta somente em localhost. Cada teste abre uma sessão com limpeza dos dados da aplicação. Não há senhas privadas nem serviços pagos.

## Resultados e triagem

[Actions](https://github.com/brunobaccari/robot-appium-android-cart/actions) executa os fluxos no emulador. O summary detalha os cinco casos; `android-results` contém JUnit, log/report HTML do Robot, screenshots disponíveis e log do servidor. Relatórios ficam ignorados no Git e retidos por 14 dias.

Falha de quantidade/total, estado incorreto, caso ignorado ou JUnit ausente bloqueia a run. Não há repetição automática até passar. Confira screenshot e keyword original antes de alterar um locator ou expectativa. `--dryrun` verifica somente a estrutura, não o aplicativo.

Escopo: Android, um dispositivo virtual e o APK oficial indicado. Sem iOS, dispositivo físico, pagamento real ou promessa de cobertura completa. Dependências transitivas das ferramentas podem ter avisos de auditoria; o servidor local não deve ser exposto à rede.
