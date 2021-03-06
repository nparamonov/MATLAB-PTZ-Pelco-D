# MATLAB PTZ Pelco D
 Набор скриптов MATLAB, реализующих управление PTZ устройствами с протоколом Pelco D

## Использование
Для использования необходимо соединить соответствующие выходы с камеры или опорно-поворотного устройства (ОПУ), например RS485 с ПК через преобразователь интерфейсов (USB - RS485).

В диспетчере устройств можно узнать номер COM порта и прописать его в конфигурации скрипта. Также указать другие параметры, соответствующие конкретному устройству (обычно задаются переключателями на самом ОПУ).

На данный момент все представленные файлы самодостаточны, повторяющиеся части не вынесены в отдельные функции, в силу того что это лишь заготовки для реальных моделей. Каждый файл может быть запущен и проверен при верной конфигурации.

## Список файлов:
- **SetPanTiltPosition.m**: Выставление координат в градусах;
- **ReadCOMport.m**: Чтение команд от устройства через COM порт.

## Данные скрипты были проверены с использованием:
- MATLAB версии: R2016a 64-bit;
- Поворотник: Axis YP3040;
- Интерфейс: RS485;
- Преобразователь интерфейсов USB-SERIAL CH340.
