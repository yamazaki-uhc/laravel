New-Item db/data -ItemType Directory
New-Item src/laravel -ItemType Directory
Set-ItemProperty db/my.cnf -Name IsReadOnly -Value $true
docker-compose up -d --build
docker-compose exec app git clone --depth 1 https://github.com/laravel/laravel.git .
docker-compose exec app rm -rf .git
docker-compose exec app rm -rf .github
docker-compose exec app composer install
docker-compose exec app chmod -R 777 storage
Remove-Item init.ps1
Remove-Item .git -Recurse -Force
git init
git add .
git commit -m "first commit"