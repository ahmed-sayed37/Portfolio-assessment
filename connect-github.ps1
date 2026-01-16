# Script to connect this project to GitHub
# Usage: .\connect-github.ps1

Write-Host "=== ربط المشروع بـ GitHub ===" -ForegroundColor Cyan
Write-Host ""

# Check if git is initialized
if (-not (Test-Path .git)) {
    Write-Host "تهيئة Git..." -ForegroundColor Yellow
    git init
}

# Get repository name from user
$repoName = Read-Host "أدخل اسم المستودع على GitHub (مثال: Task-Portfolio)"
if ([string]::IsNullOrWhiteSpace($repoName)) {
    $repoName = "Task-Portfolio"
    Write-Host "استخدام الاسم الافتراضي: $repoName" -ForegroundColor Yellow
}

# Get GitHub username
$username = Read-Host "أدخل اسم المستخدم على GitHub (مثال: ahmed-sayed37)"
if ([string]::IsNullOrWhiteSpace($username)) {
    $username = "ahmed-sayed37"
    Write-Host "استخدام الاسم الافتراضي: $username" -ForegroundColor Yellow
}

# Check current branch
$currentBranch = git branch --show-current
if ([string]::IsNullOrWhiteSpace($currentBranch)) {
    $currentBranch = "master"
}

# Rename branch to main if needed
if ($currentBranch -eq "master") {
    Write-Host "تغيير اسم الفرع إلى main..." -ForegroundColor Yellow
    git branch -M main
    $currentBranch = "main"
}

# Remove existing origin if any
git remote remove origin 2>$null

# Add remote
$remoteUrl = "https://github.com/$username/$repoName.git"
Write-Host "إضافة المستودع البعيد: $remoteUrl" -ForegroundColor Yellow
git remote add origin $remoteUrl

Write-Host ""
Write-Host "=== الخطوات التالية ===" -ForegroundColor Green
Write-Host "1. اذهب إلى https://github.com/new وأنشئ مستودع جديد باسم: $repoName" -ForegroundColor White
Write-Host "2. لا تقم بتهيئة المستودع (لا تضيف README أو .gitignore)" -ForegroundColor White
Write-Host "3. بعد إنشاء المستودع، اختر طريقة الرفع:" -ForegroundColor White
Write-Host ""
Write-Host "   أ) باستخدام Personal Access Token (موصى به):" -ForegroundColor Cyan
Write-Host "      - اذهب إلى: https://github.com/settings/tokens" -ForegroundColor White
Write-Host "      - أنشئ token جديد مع صلاحيات repo" -ForegroundColor White
Write-Host "      - ثم شغّل: git push -u origin $currentBranch" -ForegroundColor White
Write-Host "      - أدخل اسم المستخدم و Token ككلمة مرور" -ForegroundColor White
Write-Host ""
Write-Host "   ب) باستخدام GitHub CLI:" -ForegroundColor Cyan
Write-Host "      - شغّل: gh auth login" -ForegroundColor White
Write-Host "      - ثم: git push -u origin $currentBranch" -ForegroundColor White
Write-Host ""
Write-Host "   ج) باستخدام SSH:" -ForegroundColor Cyan
Write-Host "      - شغّل: git remote set-url origin git@github.com:$username/$repoName.git" -ForegroundColor White
Write-Host "      - ثم: git push -u origin $currentBranch" -ForegroundColor White
Write-Host ""

# Ask if user wants to push now
$pushNow = Read-Host "هل تريد الرفع الآن؟ (y/n)"
if ($pushNow -eq "y" -or $pushNow -eq "Y") {
    Write-Host "جارٍ الرفع إلى GitHub..." -ForegroundColor Yellow
    git push -u origin $currentBranch
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "تم الرفع بنجاح! ✓" -ForegroundColor Green
        Write-Host "رابط المستودع: https://github.com/$username/$repoName" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "فشل الرفع. تأكد من:" -ForegroundColor Red
        Write-Host "- إنشاء المستودع على GitHub أولاً" -ForegroundColor Yellow
        Write-Host "- إعداد المصادقة (Token أو SSH)" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "تم إعداد المستودع البعيد. يمكنك الرفع لاحقاً باستخدام:" -ForegroundColor Yellow
    Write-Host "git push -u origin $currentBranch" -ForegroundColor White
}

