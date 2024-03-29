# ----------------
$PHP_VERSION="8.3.4"
$LARAVEL_VERSION="11"
# ----------------

$path = @('src/laravel/init.sh', 'src/laravel/vite.config.js_template', 'entrypoint.sh')
foreach($p in $path)
{
    $lfText = [System.IO.File]::ReadAllText($p).Replace("`r`n", "`n")
    [System.IO.File]::WriteAllText($p, $lfText)
}

echo "FROM php:$PHP_VERSION-apache" > src/dockerfile/Dockerfile
cat src/dockerfile/Dockerfile_template >> src/dockerfile/Dockerfile
rm src/dockerfile/Dockerfile_template
Set-ItemProperty db/my.cnf -Name IsReadOnly -Value $true
docker-compose up -d --build
docker-compose exec app git clone --shallow-exclude "v$LARAVEL_VERSION.0.0" -b "$LARAVEL_VERSION.x" https://github.com/laravel/laravel.git tmp
docker-compose exec app bash init.sh
Remove-Item init.ps1
Remove-Item .git -Recurse -Force
Move-Item .vscode src/laravel
Move-Item .env.laravel src/laravel/.env
Move-Item .env.testing.laravel src/laravel/.env.testing
Move-Item src/laravel/vite.config.js_template src/laravel/vite.config.js_template
echo "src/laravel" >> .gitignore
git init
git add .
git commit -m "first commit"
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan key:generate --env=testing