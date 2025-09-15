extends Node

## Define signals that can be globally connected/used below





## How to connect a signal to a function:
## 1. Define your signal in signalBus.gd (i.e. your_signal)
## 2. In _ready() of the script where the method is defined, include the following statement:
##  	SignalBus.your_signal.connect(_your_function_name)
## 3. Use the following statement wherever you want the signal to be emitted from
##		SignalBus.your_signal.emit()
