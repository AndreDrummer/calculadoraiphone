class Memory {
  String _value = '0';
  List<double> _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _operation;
  bool clearDisplay = false;
  String _lastCommand;

  static const operations = ['+', '-', 'x', '/', '%', '=', "+/-"];

  void applyCommand(String command) {
    if (_isReplacingCommand(command)) {
      _operation = command;
      print("Caraai");
      return;
    }

    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _isReplacingCommand(String command) {
    return operations.contains(command) &&
        operations.contains(_lastCommand) &&
        _lastCommand != '=' &&
        command != '=' &&
        _lastCommand != '+/-' &&
        command != '+/-';
  }

  void _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';
    bool isPlusMenus = newOperation == '+/-';

    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        if (isPlusMenus) {
          _bufferIndex = 0;
          _value = double.parse(_value) > 0
              ? _value = "-" + _value
              : _value = _value.split('-')[1];
          _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
        }
      }
    } else {
      if (!isPlusMenus) {
        _buffer[0] = _calculate();
        _buffer[1] = 0.0;
        _value = _buffer[0].toString();
        _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

        _operation = isEqualSign ? null : newOperation;
        _bufferIndex = isEqualSign ? 0 : 1;
      }
    }
    clearDisplay = true;
  }

  void _addDigit(String digit) {
    final bool isDot = digit == '.';
    final String emptyValue = isDot ? '0' : '';

    if (clearDisplay) {
      _value = emptyValue;
      clearDisplay = false;
    }

    if (isDot && _value == '0') {
      _value += digit.trim();
    } else if (_value == '0') {
      _value = digit.trim();
    } else {
      if (isDot && _value.contains('.')) {
        return;
      }
      _value += digit.trim();
    }

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
    print(_buffer);
  }

  void _allClear() {
    _value = '0';
    _bufferIndex = 0;
    _operation = null;
    _buffer.setAll(0, [0.0, 0.0]);
    clearDisplay = false;
  }

  double _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  String get value => _value.trim();
}
