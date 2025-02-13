# Fonction pour générer une chaîne de caractères aléatoire de longueur donnée
$randomNumber = Get-Random -Minimum 1 -Maximum 120

# Télécharger le contenu de la page
$pageContent = Invoke-WebRequest -Uri "http://www.listedemots.fr/liste-de-mots-de-9-lettres?page=$randomNumber"

# Extraire les mots de 9 lettres
$words = Select-String -InputObject $pageContent.Content -Pattern "\b\w{9}\b" -AllMatches | ForEach-Object { $_.Matches.Value }

# Stocker les mots dans une variable
$wordList = $words

# Fonction pour ouvrir une page de recherche Bing pour un mot donné
function OuvrirPageBing($mot) {
    $url = "https://www.bing.com/search?q=$mot&qs=n&form=QBRE&sp=-1&ghc=1&lq=0&pq=motor&sc=11-5&sk=&ghsh=0&ghacc=0&ghpl="
    $edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    $process = Start-Process -FilePath $edgePath -ArgumentList $url -PassThru
    
    # Attendre 8 secondes
    Start-Sleep -Seconds 8
    
    # Fermer le processus
     get-process -Name msedge | stop-process -force
}

# Génération de 30 mots aléatoires et ouverture des pages Bing (3pts par page/mot)
for ($i = 1; $i -le 30; $i++) {
    $motAleatoire = $wordList | Get-Random
    Write-Host "Mot aléatoire $i : $motAleatoire"
    OuvrirPageBing $motAleatoire
}
