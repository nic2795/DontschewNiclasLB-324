# LB 324

## Lokal starten

```
pip install -r requirements.txt
flask run
```

Vorher eine `.env`-Datei im Format `PASSWORD="einSehrGeheimesPasswort"` anlegen.

## Aufgabe 2

`pre-commit` installieren und einrichten:

```
pip install pre-commit
pre-commit install
pre-commit install --hook-type pre-push
```


- `pre-commit install` aktiviert den `pre-commit`-Hook: bei jedem `git commit`
  wird der Code automatisch mit `black` formatiert.
- `pre-commit install --hook-type pre-push` aktiviert den `pre-push`-Hook: bei
  jedem `git push` werden die Tests (`pytest`) ausgeführt. Schlagen sie fehl,
  wird der `push` abgebrochen.

## Aufgabe 4

Die Tests laufen bei jedem `pull request` auf den `dev`-Ast automatisch über
die GitHub Action `.github/workflows/pr-tests.yml`.

## Aufgabe 5

Laufende Applikation: **https://dontschewniclaslb-324-g9bmfub8a4aebdhz.germanywestcentral-01.azurewebsites.net/**

### Passwort von der lokalen `.env` nach Azure übertragen

1. Azure Portal → die Web App öffnen.
2. Links im Menü **Einstellungen → Umgebungsvariablen** (bzw. *Configuration
   → Application settings*) wählen.
3. Eine neue Anwendungseinstellung hinzufügen:
   - Name: `PASSWORD`
   - Wert: `nic2795` (der eigene github-Benutzername, wie in der Prüfung
     verlangt)
4. Speichern — die Web App startet danach neu.

So liest `os.getenv("PASSWORD")` in `app.py` das Passwort direkt aus der
Azure-Konfiguration, ohne dass die `.env`-Datei mit ausgeliefert werden muss
(sie ist über `.gitignore` ohnehin vom Repository ausgeschlossen).

### Automatische Auslieferung

Bei jedem erfolgreichen `merge` in den `main`-Ast liefert die GitHub Action
`.github/workflows/deploy-azure.yml` die Applikation automatisch auf Azure
aus. Dafür wird das Azure *Publish Profile* als GitHub-Secret
`AZURE_WEBAPP_PUBLISH_PROFILE` benötigt (siehe Schritt-für-Schritt-Anleitung).
