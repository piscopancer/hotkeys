# Кастомные горячие клавиши на Windows с помощью AutoHotkey и PowerShell

![Список доступных горячих клавиш](https://i.imgur.com/qg0UC72.png)

## Как это работает

Нажатие на <kbd>Menu</kbd> открывает PowerShell, который читает ввод одного или нескольких символов и выполняет действие установленое в файле конфигурации, затем он моментально закрывается. Например:

- <kbd>Menu</kbd> => <kbd>D</kbd> открывает сайт [Google Docs](https://docs.google.com),
- <kbd>Menu</kbd> => <kbd>N</kbd> открывает папку по пути `C:\dev\next`.

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

Чтобы получить список всех горячих клавиш, нужно нажать <kbd>Spacebar</kbd>.

## Как заставить это работать

1. Для начала стоит проверить разрешение на запуск скриптов PowerShell. Откройте консоль PowerShell и выполните следующую команду:

   ```ps
   PS C:\Users\Igor> Get-ExecutionPolicy
   Restricted
   ```

   Чтобы PowerShell разрешал запускать этот "вредоносный" скрипт, нужно изменить **ExecutionPolicy** на `Unrestricted` с помощью команды:

   ```ps
   PS C:\Users\Igor> Set-ExecutionPolicy Unrestricted
   ```

   Далее, на всякий случай, используя первую команду, нужно перепроверить, обновилась ли политика. Если обновилась, то отлично.

2. Теперь нужно скачать и разархивировать [сборку](https://github.com/piscopancer/hotkeys/releases/download/release/hotkeys-v1.0.0.rar) в любую удобную папку. Антивирус может ругаться, потому что программа изменяет файлы реестра для автозагрузки.

3. Наконец нужно 1 раз запустить `hk.exe`. На экране ничего не произойдет, у программы нет интерфейса, кроме как самой консоли. После первого ручного запуска программа сама добавит себя в автозагрузку и будет включаться при запуске системы.
4. Теперь все должно работать 🎉. Стоит также перезапустить устройство, чтобы проверить, работает ли автозагрузка.
