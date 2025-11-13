#!/bin/bash

# Test rápido para examen
# Uso: chmod +x run_exam.sh && ./run_exam.sh

echo "🎓 COMPILANDO TEST DE EXAMEN..."

gcc -o exam_test exam_test.c 2>/dev/null

if [ $? -ne 0 ]; then
    echo "❌ Error de compilación"
    exit 1
fi

echo "✅ Compilación OK"
echo ""

./exam_test

rm -f exam_test temp.txt

echo "✅ Test completado!"