# Mise en ligne de TechStore sur ton dépôt GitHub

Le dépôt existant peut rester `recipebook` : le projet Flutter à l'intérieur devient `TechStore`.

## 1. Remplacer les fichiers

### Méthode recommandée
Télécharge l'archive, décompresse-la, puis ouvre le dossier dans VS Code.

Dans un terminal à la racine du projet :

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Si tout est OK :

```bash
flutter build web --release
```

## 2. Pousser vers ton dépôt existant

Si tu veux remplacer le contenu actuel de `recipebook` :

```bash
git clone https://github.com/azizcheickshazili-rgb/recipebook.git
cd recipebook
```

Copie ensuite **tout le contenu de cette archive** dans ce dossier, en remplaçant les fichiers existants.

Puis :

```bash
git status
git add .
git commit -m "feat: transform RecipeBook into TechStore ecommerce"
git push origin main
```

Le dépôt restera public à la même adresse.

## 3. Si Git demande un mot de passe

GitHub n'utilise plus le mot de passe du compte pour l'authentification Git. Utilise une clé SSH ou un Personal Access Token (PAT).

### PAT Fine-grained — réglage minimal recommandé

Sur GitHub :
`Settings` → `Developer settings` → `Personal access tokens` → `Fine-grained tokens` → `Generate new token`.

**Repository access**
- Sélectionner : `Only select repositories`
- Cocher uniquement : `azizcheickshazili-rgb/recipebook`

**Repository permissions**
- `Contents` → **Read and write** ✅
- `Workflows` → **Read and write** ✅ uniquement parce que le projet contient `.github/workflows/flutter.yml`

Laisser tout le reste sur `No access` / non coché.

Pour un simple push de fichiers de code sans modification des workflows, `Contents: Read and write` est le minimum. Le workflow CI inclus dans ce projet justifie `Workflows: Read and write` si tu veux aussi envoyer/modifier ce fichier via GitHub.

**Expiration**
- 30 ou 90 jours est préférable pour un projet scolaire.
- Ne mets pas un token sans expiration si ce n'est pas nécessaire.

### Sécurité
- Ne m'envoie JAMAIS ton token.
- Ne mets JAMAIS le token dans `pubspec.yaml`, Dart, README ou `.env` versionné.
- Si le token est exposé, révoque-le immédiatement et crée-en un nouveau.

## 4. Déploiement Web

Après :

```bash
flutter build web --release
```

Le résultat est dans :

```text
build/web/
```

Tu peux publier cette build sur GitHub Pages ou un hébergeur statique.

## 5. Vérification finale avant soumission

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build web --release
```

Puis vérifie dans le navigateur :

- catalogue
- détail produit
- recherche
- filtre catégorie
- filtre marque
- tri
- ajout au panier
- augmentation/diminution
- suppression
- total
- favoris
- rechargement des favoris
- profil
- loading
- erreur / bouton Réessayer
- responsive mobile/tablette/desktop
- animation « Ajouté au panier »

## 6. Ce que le README doit montrer au reviewer

Le README fourni explique :
- l'architecture
- les providers
- le repository asynchrone
- la persistance
- les commandes de lancement
- les tests
- le build web

Après avoir lancé l'application, ajoute idéalement 4 à 6 captures d'écran dans `README.md`. Cela rend la soumission beaucoup plus crédible.


## APK Android

Le workflow génère le dossier `android/` automatiquement avec Flutter avant `flutter build apk --release`. L'APK est ensuite placé dans `artifacts/techstore-release.apk`, compressé et publié comme artifact GitHub Actions sous le nom `techstore-android-apk`.
