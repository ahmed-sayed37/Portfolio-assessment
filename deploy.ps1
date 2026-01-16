# Navigate to project directory
$projectPath = "E:\For-DPEI\Task-Portfolio"
Set-Location $projectPath

# Initialize git if not exists
if (-not (Test-Path .git)) {
    git init
}

# Add files
git add index.html
git add assets/
git add .gitignore
git add Readme.txt

# Commit
git commit -m "Initial commit: Portfolio website"

# Add remote
git remote remove origin 2>$null
git remote add origin https://github.com/ahmed-sayed37/Portfolio-assessment.git

# Set branch to main
git branch -M main

# Push to GitHub
# Note: You'll need to authenticate when pushing
# Use Personal Access Token or GitHub CLI
git push -u origin main

Write-Host "Done! Project uploaded to GitHub successfully!"
