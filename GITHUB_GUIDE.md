# دليل سريع لرفع المشاريع على GitHub 🚀

## الطريقة السهلة (3 خطوات فقط!)

### الخطوة 1: تهيئة Git في المشروع
```powershell
cd مسار-المشروع
git init
```

### الخطوة 2: إضافة الملفات وعمل Commit
```powershell
git add .
git commit -m "Initial commit"
```

### الخطوة 3: ربط المشروع بـ GitHub ورفعه
```powershell
# إنشاء مستودع جديد على GitHub أولاً من: https://github.com/new
# ثم:
git remote add origin https://github.com/اسم-المستخدم/اسم-المستودع.git
git branch -M main
git push -u origin main
```

---

## شرح تفصيلي خطوة بخطوة

### 1️⃣ إنشاء مستودع جديد على GitHub

1. اذهب إلى: **https://github.com/new**
2. أدخل اسم المستودع (مثال: `my-project`)
3. **⚠️ مهم:** لا تضع علامة على "Add a README file" أو "Add .gitignore"
4. اضغط **"Create repository"**

### 2️⃣ فتح Terminal في مجلد المشروع

```powershell
# مثال:
cd E:\MyProjects\my-project
```

### 3️⃣ تهيئة Git (إذا لم يكن موجوداً)

```powershell
git init
```

### 4️⃣ إضافة جميع الملفات

```powershell
git add .
```

أو إضافة ملفات محددة:
```powershell
git add index.html
git add assets/
git add README.md
```

### 5️⃣ عمل Commit

```powershell
git commit -m "Initial commit: وصف المشروع"
```

### 6️⃣ ربط المشروع بالمستودع على GitHub

```powershell
git remote add origin https://github.com/اسم-المستخدم/اسم-المستودع.git
```

**مثال:**
```powershell
git remote add origin https://github.com/ahmed-sayed37/my-project.git
```

### 7️⃣ تغيير اسم الفرع إلى main (إن لزم)

```powershell
git branch -M main
```

### 8️⃣ رفع المشروع

```powershell
git push -u origin main
```

عند طلب المصادقة:
- **Username:** اسم المستخدم على GitHub
- **Password:** Personal Access Token (وليس كلمة المرور!)

---

## إنشاء Personal Access Token

إذا لم يكن لديك Token:

1. اذهب إلى: **https://github.com/settings/tokens**
2. اضغط **"Generate new token (classic)"**
3. اختر صلاحيات **`repo`** (كلها)
4. اضغط **"Generate token"**
5. **انسخ الـ Token فوراً** (لن تتمكن من رؤيته مرة أخرى!)

---

## طريقة أسهل: استخدام GitHub CLI

### تثبيت GitHub CLI:
```powershell
winget install GitHub.cli
```

### تسجيل الدخول:
```powershell
gh auth login
```

### رفع المشروع:
```powershell
git init
git add .
git commit -m "Initial commit"
gh repo create اسم-المستودع --public --source=. --remote=origin --push
```

---

## تحديث المشروع بعد التعديلات

بعد تعديل أي ملفات:

```powershell
git add .
git commit -m "وصف التغييرات"
git push
```

---

## نصائح مهمة ⚠️

### ❌ لا تفعل:
- لا تضع **Personal Access Tokens** في الملفات
- لا ترفع ملفات **`.env`** أو ملفات تحتوي على أسرار
- لا ترفع مجلدات **`node_modules`** (استخدم `.gitignore`)

### ✅ افعل:
- استخدم ملف **`.gitignore`** لتجاهل الملفات غير المرغوبة
- اكتب رسائل commit واضحة ووصفية
- ارفع التغييرات بانتظام

---

## مثال `.gitignore` مفيد

```gitignore
# Node modules
node_modules/

# Environment files
.env
.env.local

# IDE files
.vscode/
.idea/

# System files
.DS_Store
Thumbs.db
*.log

# Build outputs
dist/
build/
```

---

## حل المشاكل الشائعة

### المشكلة: "remote: Repository not found"
**الحل:** تأكد من:
- اسم المستخدم والمستودع صحيح
- لديك صلاحيات على المستودع
- المستودع موجود على GitHub

### المشكلة: "Authentication failed"
**الحل:** 
- استخدم Personal Access Token بدلاً من كلمة المرور
- تأكد من صلاحيات Token (يجب أن تحتوي على `repo`)

### المشكلة: "Push protection: secrets detected"
**الحل:**
- أزل أي Tokens أو أسرار من الملفات
- استخدم `git filter-branch` لإزالتها من التاريخ

---

## سكريبت PowerShell تلقائي

احفظ هذا السكريبت كملف `upload-to-github.ps1`:

```powershell
# سكريبت رفع المشروع إلى GitHub
param(
    [string]$RepoName = "",
    [string]$Username = "ahmed-sayed37"
)

if ([string]::IsNullOrWhiteSpace($RepoName)) {
    $RepoName = Read-Host "أدخل اسم المستودع"
}

Write-Host "تهيئة Git..." -ForegroundColor Yellow
if (-not (Test-Path .git)) {
    git init
}

Write-Host "إضافة الملفات..." -ForegroundColor Yellow
git add .

Write-Host "عمل Commit..." -ForegroundColor Yellow
$commitMessage = Read-Host "أدخل رسالة Commit (أو اضغط Enter للافتراضي)"
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Initial commit"
}
git commit -m $commitMessage

Write-Host "ربط المشروع بـ GitHub..." -ForegroundColor Yellow
git remote remove origin 2>$null
git remote add origin "https://github.com/$Username/$RepoName.git"
git branch -M main

Write-Host "رفع المشروع..." -ForegroundColor Yellow
Write-Host "تأكد من إنشاء المستودع على GitHub أولاً!" -ForegroundColor Cyan
git push -u origin main

Write-Host "تم بنجاح! ✓" -ForegroundColor Green
```

**الاستخدام:**
```powershell
.\upload-to-github.ps1 -RepoName "my-project"
```

---

## ملخص سريع (Copy & Paste)

```powershell
# 1. تهيئة
git init
git add .
git commit -m "Initial commit"

# 2. ربط (استبدل username و repo-name)
git remote add origin https://github.com/username/repo-name.git
git branch -M main

# 3. رفع
git push -u origin main
```

---

**تم! الآن يمكنك رفع أي مشروع بسهولة 🎉**

