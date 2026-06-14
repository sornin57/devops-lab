# DevOps Lab

Lab personnel de montée en compétence DevOps autour de Docker, CI/CD avec GitHub Actions et Terraform.

L’objectif est de comprendre une première chaîne DevOps complète : créer une application simple, la conteneuriser, la tester automatiquement dans une pipeline CI, puis la gérer avec Terraform.

## Stack utilisée

- Python
- Docker
- GitHub Actions
- Terraform
- Git / GitHub

## Structure du projet

```text
.
├── .github
│   └── workflows
│       └── docker.yml
├── app
│   ├── Dockerfile
│   └── main.py
├── docs
│   └── notes.md
├── terraform-docker
│   └── main.tf
├── .gitignore
└── README.md
```

## Application Python

L’application est un petit serveur HTTP écrit en Python.

Elle écoute sur le port `8000` et retourne :

```text
Hello DevOps Lab
```

Fichier principal :

```text
app/main.py
```

## Docker

Construire l’image :

```bash
docker build -t devops-lab-app ./app
```

Lancer le container en arrière-plan :

```bash
docker run -d -p 8000:8000 --name devops-lab-container devops-lab-app
```

Tester l’application :

```bash
curl http://localhost:8000
```

Voir les containers actifs :

```bash
docker ps
```

Voir tous les containers :

```bash
docker ps -a
```

Afficher les logs :

```bash
docker logs devops-lab-container
```

Arrêter le container :

```bash
docker stop devops-lab-container
```

Supprimer le container arrêté :

```bash
docker rm devops-lab-container
```

Concepts retenus :

- Une image est un modèle prêt à lancer.
- Un container est une instance lancée d’une image.
- Un Dockerfile décrit comment construire l’image.
- `-d` lance le container en arrière-plan.
- `-p 8000:8000` relie le port local au port du container.
- `docker logs` permet de consulter les logs.

## CI/CD avec GitHub Actions

GitHub Actions vérifie automatiquement le projet à chaque push sur la branche `main`.

Workflow :

```text
.github/workflows/docker.yml
```

La pipeline fait :

1. Récupération du code avec `actions/checkout`
2. Vérification de la syntaxe Python
3. Construction de l’image Docker
4. Lancement du container
5. Test HTTP avec `curl`
6. Affichage des logs du container

Commandes exécutées dans la pipeline :

```bash
python -m py_compile app/main.py
docker build -t devops-lab-app ./app
docker run -d -p 8000:8000 --name devops-lab-container devops-lab-app
curl -f http://localhost:8000
docker logs devops-lab-container
```

## Terraform

Terraform permet de décrire et gérer de l’infrastructure avec du code.

Fichier Terraform :

```text
terraform-docker/main.tf
```

Commandes utilisées :

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

Rôle des commandes :

- `terraform init` initialise le projet et télécharge les providers.
- `terraform plan` affiche ce que Terraform va créer, modifier ou supprimer.
- `terraform apply` applique les changements.
- `terraform destroy` supprime les ressources créées par Terraform.

Après `terraform apply`, l’application est accessible avec :

```bash
curl http://localhost:8000
```

Réponse attendue :

```text
Hello DevOps Lab
```

Nettoyage propre :

```bash
terraform destroy
```

## Fichiers Terraform à ne pas versionner

Les fichiers suivants ne doivent pas être commit :

```text
.terraform/
terraform.tfstate
terraform.tfstate.backup
```

Ils sont ignorés avec `.gitignore`, car ils sont locaux, lourds ou peuvent contenir des informations sensibles.

## Ce que ce lab démontre

- Création d’une application HTTP simple
- Conteneurisation avec Docker
- Lancement et debug d’un container
- Récupération des logs
- Automatisation d’un build et d’un test avec GitHub Actions
- Première approche d’Infrastructure as Code avec Terraform
- Gestion propre des ressources créées par Terraform

## Prochaines étapes

- Ajouter un badge GitHub Actions
- Ajouter des tests Python
- Pousser l’image Docker vers une registry
- Déployer l’application sur Kubernetes
- Créer un chart Helm
- Ajouter un playbook Ansible
