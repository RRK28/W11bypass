# =====================================================================
# Bypass-Win11-Checks_REREK_once.ps1
# Auteur : REREK (https://bessahlirezki.com)
# - Crée/MAJ les clés de registre LabConfig (Bypass TPM, SecureBoot, RAM)
# =====================================================================

# ------------------------
# Fonctions utilitaires
# ------------------------
function Show-RerekBanner {
    $banner = @"
RRRR   EEEEE  RRRR   EEEEE  K   K
R   R  E      R   R  E      K  K 
RRRR   EEEE   RRRR   EEEE   KKK  
R  R   E      R  R   E      K  K 
R   R  EEEEE  R   R  EEEEE  K   K
"@
    Write-Host ""
    Write-Host $banner -ForegroundColor Cyan
    Write-Host "🔧 Script de préparation Windows 11 (bypass des vérifications) — REREK" -ForegroundColor Gray
    Write-Host ""
    Start-Sleep -Seconds 2   # <-- n'affiche que 2 secondes
    Clear-Host
}

function Assert-Admin {
    if (-not ([Security.Principal.WindowsPrincipal]
        [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "❌ Ce script doit être exécuté en tant qu'Administrateur." -ForegroundColor Red
        exit 1
    }
}

# ------------------------
# Affiche la bannière 2s
# ------------------------
Show-RerekBanner

# ------------------------
# Vérification d'élévation
# ------------------------
Assert-Admin

# -----------------------------------
# Clés de registre LabConfig (HKLM)
# -----------------------------------
Write-Host " je prends des selfie avec Skye mon fils ( 🧩 Création/MAJ de HKLM:\SYSTEM\Setup\LabConfig ... )" -ForegroundColor Cyan
try {
    New-Item -Path "HKLM:\SYSTEM\Setup\LabConfig" -Force | Out-Null

    New-ItemProperty -Path "HKLM:\SYSTEM\Setup\LabConfig" -Name "BypassTPMCheck"        -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path "HKLM:\SYSTEM\Setup\LabConfig" -Name "BypassSecureBootCheck"  -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path "HKLM:\SYSTEM\Setup\LabConfig" -Name "BypassRAMCheck"         -Value 1 -PropertyType DWord -Force | Out-Null

    Write-Host "✅ Bypass appliqué : TPM, SecureBoot et RAM." -ForegroundColor Green
}
catch {
    Write-Host "⚠️ Erreur lors de la modification du registre : $($_.Exception.Message)" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "➡️ Vous pouvez maintenant lancer l'installation de Windows 11 si nécessaire." -ForegroundColor Gray
