#!/bin/bash

mv tmp/* ./
mv tmp/.* ./
rm -rf tmp
rm init.sh
git remote rename origin laravel
git switch -c main