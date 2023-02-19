#!/bin/bash

mv tmp/* ./
mv tmp/.* ./
rm -rf tmp
git remote rename origin laravel
git switch -c main
composer install
find storage -type d -print | xargs chmod 777
composer require --dev barryvdh/laravel-debugbar barryvdh/laravel-ide-helper
npm i
rm init.sh