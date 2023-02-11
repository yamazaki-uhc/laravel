# ----------------
$PHP_VERSION="8.2.2"
$LARAVEL_VERSION="10"
# ----------------

echo "PHP_VERSION=$PHP_VERSION" > .env
New-Item db/data -ItemType Directory
New-Item src/laravel -ItemType Directory
Set-ItemProperty db/my.cnf -Name IsReadOnly -Value $true
docker-compose up -d --build
docker-compose exec app git clone --depth 1 -b "$LARAVEL_VERSION.x" https://github.com/laravel/laravel.git .
docker-compose exec app rm -rf .git
docker-compose exec app rm -rf .github
docker-compose exec app composer install
docker-compose exec app chmod -R 777 storage
docker-compose exec app composer require --dev barryvdh/laravel-debugbar
Remove-Item init.ps1
Remove-Item .env
Remove-Item .git -Recurse -Force
git init
git add .
git commit -m "first commit"