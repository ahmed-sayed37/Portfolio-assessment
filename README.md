# Task Portfolio Project

مشروع Portfolio تم إنشاؤه لـ DEPI

## ربط المشروع بـ GitHub

### الطريقة السريعة (موصى بها)

1. شغّل السكريبت:
   ```powershell
   .\connect-github.ps1
   ```

2. اتبع التعليمات على الشاشة

### الطريقة اليدوية

#### 1. إنشاء مستودع على GitHub

- اذهب إلى [https://github.com/new](https://github.com/new)
- اختر اسم للمستودع (مثال: `Task-Portfolio`)
- **لا** تقم بتهيئة المستودع (لا تضيف README أو .gitignore)
- اضغط "Create repository"

#### 2. ربط المشروع المحلي بـ GitHub

```powershell
# إضافة المستودع البعيد (استبدل username و repo-name)
git remote add origin https://github.com/username/repo-name.git

# تغيير اسم الفرع إلى main (إذا كان master)
git branch -M main

# رفع المشروع
git push -u origin main
```

#### 3. المصادقة مع GitHub

**الطريقة الأولى: Personal Access Token (موصى به)**

1. اذهب إلى [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. اضغط "Generate new token (classic)"
3. اختر صلاحيات `repo`
4. انسخ الـ Token
5. عند الرفع، استخدم:
   - Username: اسم المستخدم على GitHub
   - Password: الـ Token (وليس كلمة المرور)

**الطريقة الثانية: GitHub CLI**

```powershell
# تثبيت GitHub CLI (إذا لم يكن مثبتاً)
winget install GitHub.cli

# تسجيل الدخول
gh auth login

# الرفع
git push -u origin main
```

**الطريقة الثالثة: SSH**

```powershell
# إنشاء مفتاح SSH (إذا لم يكن موجوداً)
ssh-keygen -t ed25519 -C "your_email@example.com"

# إضافة المفتاح إلى GitHub
# انسخ محتوى ~/.ssh/id_ed25519.pub
# ثم اذهب إلى: https://github.com/settings/keys

# تغيير رابط المستودع إلى SSH
git remote set-url origin git@github.com:username/repo-name.git

# الرفع
git push -u origin main
```

## هيكل المشروع

```
Task-Portfolio/
├── assets/
│   ├── css/
│   │   └── style.css
│   ├── images/
│   │   └── 74757.jpg
│   └── JS/
│       └── script.js
├── index.html
├── deploy.ps1
├── connect-github.ps1
└── README.md
```

## الميزات

- تصميم Portfolio احترافي
- متجاوب مع جميع الأجهزة
- استخدام Bootstrap 5
- أقسام: Home, About, Projects, Skills, Contact

## التطوير

تم إنشاء المشروع باستخدام:
- HTML5
- CSS3
- JavaScript
- Bootstrap 5.3.2
- Bootstrap Icons

---

تم الإنشاء بواسطة Ahmed Sayed

