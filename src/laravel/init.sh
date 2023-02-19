#!/bin/bash

mv tmp/* ./
mv tmp/.* ./
rm -rf tmp
git remote rename origin laravel
git switch -c main
composer install
chmod 777 storage/logs
composer require --dev barryvdh/laravel-debugbar barryvdh/laravel-ide-helper
npm i
rm init.sh