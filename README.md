# Кастомные горячие клавиши на Windows с помощью AutoHotkey и PowerShell

![Окно для ввода горячей клавиши](https://i.imgur.com/Y3Ag5wb.png)

## Как это работает

Нажатие на <kbd>Menu</kbd> открывает PowerShell, который читает ввод горячей клавиши и выполняет действие установленое для нее в файле конфигурации, затем окно моментально закрывается. Например:

- <kbd>Menu</kbd> => <kbd>m</kbd> открывает сайт [МКРС](https://mkrs-beta.vercel.app),
- <kbd>Menu</kbd> => <kbd>n</kbd> открывает папку по пути `C:\dev\next`.

### Карта (файл конфигурации `JSON`)

Настроить нужные ссылки и пути можно в файле конфигурации под названием `map.json`:

```json
{
  "urls": {
    "y": "https://youtube.com",
    "g": "https://github.com",
    "d": "https://docs.google.com"
  },
  "directories": {
    "w": "C:\\dev\\web"
  }
}
```

### Помощь

Чтобы получить список всех горячих клавиш, нужно нажать <kbd>Spacebar</kbd>:

![Список доступных горячих клавиш](https://i.imgur.com/96dvg1H.png)

## Как заставить это работать

1. Нужно установить репозиторий со всеми скриптами.
2. Обязательно проверить разрешение на запуск скриптов PowerShell. Это можно сделать с помощью следующей команды:

   ```ps
   PS C:\Users\Igor> Get-ExecutionPolicy
   Restricted
   ```

   Чтобы PowerShell разрешал запускать этот "вредоносный" скрипт, нужно изменить **ExecutionPolicy** на `Unrestricted` с помощью команды:

   ```ps
   PS C:\Users\Igor> Set-ExecutionPolicy Unrestricted
   ```

   Далее, на всякий случай, используя первую команду, нужно перепроверить, обновилась ли политика. Если обновилась, то отлично.

3. Также нужна программа [AutoHotkey](https://www.autohotkey.com), она предлагает свой собственный **язык программирования** (файлы `*.ahk`) для назначения действий на клавиши, например исполнение программ, открытие папок, сайтов и прочие всевозможные действия.
4. Чтобы не запускать этот скрипт руками при каждом включении, рекоммендуется (обязательно) создать ярлык файла из репозитория под названием `hotkeys.ahk`, затем добавить его в **папку автозапуска** (<kbd>Win</kbd> + <kbd>r</kbd> => `shell:startup`), оставив ярлык в этой папке. Так **AutoHotkey** будет автоматически выполнять скрипт при запуске системы.
5. Теперь все должно работать. 🎉
