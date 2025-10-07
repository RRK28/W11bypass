# w11REREK.PS1

Script PowerShell qui crée/met à jour `HKLM:\SYSTEM\Setup\LabConfig` pour bypasser les contrôles TPM, Secure Boot et RAM lors d'une installation de Windows 11. Exécuter **en administrateur**. Action ponctuelle — ne s'installe pas au démarrage.

## Contenu
- `w11REREK.PS1` — script principal

## Usage
1. Télécharger ou cloner le dépôt.
2. Ouvrir PowerShell en tant qu'administrateur.
3. Lancer :
```powershell
.\w11REREK.PS1
