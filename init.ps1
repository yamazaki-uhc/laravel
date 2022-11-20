New-Item mysql/data -ItemType Directory
New-Item laravel/html -ItemType Directory
Set-ItemProperty mysql/my.cnf -Name IsReadOnly -Value $true
docker-compose up -d --build
docker-compose exec laravel git clone --depth 1 https://github.com/laravel/laravel.git .
docker-compose exec laravel rm -rf .git
docker-compose exec laravel rm -rf .github
docker-compose exec laravel composer install
docker-compose exec laravel chmod -R 777 storage
Remove-Item init.ps1
Remove-Item .git -Recurse -Force
git init
git add .
git commit -m "first commit"