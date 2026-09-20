# LB 324 - Tagebbbuch

## App lokal starten

Zuerst die Abhängigkeiten installieren:

```
pip install -r requirements.txt
```

Damit die App läuft, braucht es noch eine `.env`-Datei im Projektordner mit
folgendem Inhalt:

```
PASSWORD="einSehrGeheimesPasswort"
```

(du kannst hier ein beliebiges eigenes Passwort einsetzen)

Danach kann die App gestartet werden mit:

```
flask run
```

## Aufgabe 2 - pre-commit

Ich habe `pre-commit` so eingerichtet, dass zwei Dinge automatisch passieren:

- Bei jedem `commit` wird der Code mit `black` formatiert.
- Bei jedem `push` laufen die Tests (`pytest`). Wenn ein Test fehlschlägt,
  wird der Push abgebrochen.

Damit das bei dir auch funktioniert, muss `pre-commit` einmalig installiert
und aktiviert werden:

```
pip install pre-commit
pre-commit install
pre-commit install --hook-type pre-push
```

Der zweite Befehl ist nötig, weil `pre-commit install` allein nur den
`commit`-Hook aktiviert - für den `push`-Hook braucht es den Zusatz
`--hook-type pre-push`.

## Aufgabe 4 - Tests bei Pull Requests

Sobald ein Pull Request auf den `dev`-Ast erstellt wird, laufen automatisch
die Tests über GitHub Actions (`.github/workflows/pr-tests.yml`). So sieht
man vor dem Merge, ob etwas kaputt ist.

## Aufgabe 5 - Deployment nach Azure

Die App läuft hier:

**https://dontschewniclaslb-324-g9bmfub8a4aebdhz.germanywestcentral-01.azurewebsites.net/**

### Passwort nach Azure übertragen

Das Passwort steht bei mir lokal in der `.env`-Datei, die aber nicht mit ins
Repository kommt (steht in der `.gitignore`). Damit die App auf Azure trotzdem
weiss, welches Passwort gilt, habe ich es direkt in Azure als
Umgebungsvariable hinterlegt:

1. Im Azure Portal die Web App öffnen.
2. Links im Menü zu "Umgebungsvariablen" gehen.
3. Eine neue Variable hinzufügen:
   - Name: `PASSWORD`
   - Wert: `nic2795` (mein GitHub-Benutzername, wie in der Prüfung verlangt)
4. Speichern - die Web App startet danach automatisch neu.

`app.py` liest das Passwort über `os.getenv("PASSWORD")` - dadurch macht es
keinen Unterschied, ob die Variable aus der lokalen `.env` oder aus der
Azure-Konfiguration kommt.

### Automatisches Deployment

Jedes Mal, wenn etwas in den `main`-Ast gemerged wird, liefert die GitHub
Action `.github/workflows/deploy-azure.yml` die App automatisch auf Azure
aus. Damit das funktioniert, musste ich einmalig das Azure Publish Profile
herunterladen und als GitHub-Secret mit dem Namen
`AZURE_WEBAPP_PUBLISH_PROFILE` im Repository hinterlegen.
