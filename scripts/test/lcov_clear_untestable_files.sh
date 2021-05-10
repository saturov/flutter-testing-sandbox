# Удаление из lcov.info файлов, которые не должны покрываться Unit-тестами
cd coverage
lcov --remove lcov.info 'lib/res/*' -o lcov.info
