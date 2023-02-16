# ----------------
$PHP_VERSION="8.2.2"
$LARAVEL_VERSION="10"
# ----------------

$path = @('src/laravel/init.sh', 'src/laravel/vite.config.js_template')
foreach($p in $path)
{
    $lfText = [System.IO.File]::ReadAllText($p).Replace("`r`n", "`n")
    [System.IO.File]::WriteAllText($p, $lfText)
}

echo "FROM php:$PHP_VERSION-apache" > src/dockerfile/Dockerfile
cat src/dockerfile/Dockerfile_template >> src/dockerfile/Dockerfile
rm src/dockerfile/Dockerfile_template
New-Item db/data -ItemType Directory
Set-ItemProperty db/my.cnf -Name IsReadOnly -Value $true
docker-compose up -d --build
docker-compose exec app git clone --depth 1 -b "$LARAVEL_VERSION.x" https://github.com/laravel/laravel.git tmp
docker-compose exec app bash init.sh
docker-compose exec app composer install
docker-compose exec app chmod -R 777 storage
docker-compose exec app composer require --dev barryvdh/laravel-debugbar barryvdh/laravel-ide-helper
docker-compose exec app npm i
Remove-Item init.ps1
Remove-Item .git -Recurse -Force
Move-Item .vscode src/laravel
Move-Item src/laravel/vite.config.js src/laravel/vite.config.js_bk
Move-Item src/laravel/vite.config.js_template src/laravel/vite.config.js
echo "src/laravel" >> .gitignore
git init
git add .
git commit -m "first commit"