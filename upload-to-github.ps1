# سكريبت بسيط لرفع أي مشروع إلى GitHub
# الاستخدام: .\upload-to-github.ps1

param(
    [string]$RepoName = "",
    [string]$Username = "ahmed-sayed37"
)

Write-Host "=== رفع المشروع إلى GitHub ===" -ForegroundColor Cyan
Write-Host ""

# الحصول على اسم المستودع
if ([string]::IsNullOrWhiteSpace($RepoName)) {
    $RepoName = Read-Host "أدخل اسم المستودع على GitHub"
}

if ([string]::IsNullOrWhiteSpace($RepoName)) {
    Write-Host "❌ يجب إدخال اسم المستودع!" -ForegroundColor Red
    exit 1
}

# التحقق من وجود Git
try {
    git --version | Out-Null
} catch {
    Write-Host "❌ Git غير مثبت! قم بتثبيته أولاً." -ForegroundColor Red
    exit 1
}

# تهيئة Git إذا لم يكن موجوداً
if (-not (Test-Path .git)) {
    Write-Host "تهيئة Git..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "Git موجود بالفعل ✓" -ForegroundColor Green
}

# إضافة الملفات
Write-Host "إضافة الملفات..." -ForegroundColor Yellow
git add .

# Commit
$commitMessage = Read-Host "أدخل رسالة Commit (أو اضغط Enter للافتراضي: 'Initial commit')"
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Initial commit"
}

Write-Host "عمل Commit..." -ForegroundColor Yellow
git commit -m $commitMessage

# ربط المشروع
Write-Host "ربط المشروع بـ GitHub..." -ForegroundColor Yellow
git remote remove origin 2>$null
$remoteUrl = "https://github.com/$Username/$RepoName.git"
git remote add origin $remoteUrl

# تغيير اسم الفرع
$currentBranch = git branch --show-current
if ([string]::IsNullOrWhiteSpace($currentBranch)) {
    $currentBranch = "master"
}
if ($currentBranch -ne "main") {
    Write-Host "تغيير اسم الفرع إلى main..." -ForegroundColor Yellow
    git branch -M main
    $currentBranch = "main"
}

# تعليمات
Write-Host ""
Write-Host "=== ⚠️ مهم: اقرأ هذا أولاً ===" -ForegroundColor Yellow
Write-Host "1. تأكد من إنشاء المستودع على GitHub:" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Cyan
Write-Host "   اسم المستودع: $RepoName" -ForegroundColor White
Write-Host "   ⚠️ لا تضع علامة على 'Add README' أو 'Add .gitignore'" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. إذا لم يكن لديك Personal Access Token:" -ForegroundColor White
Write-Host "   https://github.com/settings/tokens" -ForegroundColor Cyan
Write-Host "   أنشئ Token جديد مع صلاحيات 'repo'" -ForegroundColor White
Write-Host ""

# محاولة الرفع
$pushNow = Read-Host "هل أنشأت المستودع على GitHub وتريد الرفع الآن؟ (y/n)"
if ($pushNow -eq "y" -or $pushNow -eq "Y") {
    Write-Host ""
    Write-Host "جارٍ الرفع..." -ForegroundColor Yellow
    Write-Host "عند طلب المصادقة:" -ForegroundColor Cyan
    Write-Host "  Username: $Username" -ForegroundColor White
    Write-Host "  Password: Personal Access Token (وليس كلمة المرور!)" -ForegroundColor White
    Write-Host ""
    
    git push -u origin $currentBranch
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ تم الرفع بنجاح!" -ForegroundColor Green
        Write-Host "رابط المستودع: https://github.com/$Username/$RepoName" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "❌ فشل الرفع. تحقق من:" -ForegroundColor Red
        Write-Host "   - المستودع موجود على GitHub" -ForegroundColor Yellow
        Write-Host "   - لديك Personal Access Token" -ForegroundColor Yellow
        Write-Host "   - Token له صلاحيات 'repo'" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "يمكنك المحاولة مرة أخرى باستخدام:" -ForegroundColor White
        Write-Host "   git push -u origin $currentBranch" -ForegroundColor Cyan
    }
} else {
    Write-Host ""
    Write-Host "تم إعداد المشروع. يمكنك الرفع لاحقاً باستخدام:" -ForegroundColor Yellow
    Write-Host "   git push -u origin $currentBranch" -ForegroundColor Cyan
}

Write-Host ""

