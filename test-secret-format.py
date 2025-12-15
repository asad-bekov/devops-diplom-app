#!/usr/bin/env python3
import json
import sys
import os

# Тестовый ключ из /tmp/final-key.json
try:
    with open('/tmp/final-key.json', 'r') as f:
        content = f.read()
    
    print("=== Анализ ключа из /tmp/final-key.json ===")
    print(f"Длина: {len(content)} символов")
    print(f"Первые 50 символов: {repr(content[:50])}")
    print(f"Последние 50 символов: {repr(content[-50:])}")
    
    # Проверяем как JSON
    parsed = json.loads(content)
    print("✅ Ключ является валидным JSON")
    print(f"Ключевые поля: {list(parsed.keys())}")
    
    # Проверяем наличие обязательных полей
    required_fields = ['id', 'service_account_id', 'private_key']
    for field in required_fields:
        if field in parsed:
            print(f"✅ Поле '{field}' присутствует")
        else:
            print(f"❌ Поле '{field}' отсутствует!")
    
except json.JSONDecodeError as e:
    print(f"❌ Ошибка парсинга JSON: {e}")
    print("Возможные причины:")
    print("1. Лишние символы в начале/конце")
    print("2. Отсутствие кавычек")
    print("3. Неправильные escape-последовательности")
except Exception as e:
    print(f"❌ Другая ошибка: {e}")
