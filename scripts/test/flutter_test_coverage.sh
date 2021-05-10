# Запуск анализа покрытия кодовой базы тестами

sh ./scripts/test/flutter_import_all_files.sh

fvm flutter test --coverage

sh ./scripts/test/lcov_clear_untestable_files.sh
# При необходимости установить утилиту lcov
# brew install lcov
genhtml --prefix $(cd "$(dirname "$1")"; pwd -P)/$(basename "$1") -O coverage coverage/lcov.info

