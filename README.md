DevOps Lab

Lab personnel de montée en compétence DevOps autour de Docker, CI/CD avec GitHub Actions, Terraform et bases d’automatisation.

L’objectif est de comprendre la chaîne complète : partir d’une application simple, la conteneuriser, l’automatiser dans une pipeline CI, puis la gérer avec Terraform.

Stack utilisée

* Python
* Docker
* GitHub Actions
* Terraform
* Provider Docker pour Terraform
* Git / GitHub

Structure du projet

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
└── README.md

Application Python

L’application est un serveur HTTP simple écrit en Python.

Elle écoute sur le port 8000 et retourne :

Hello DevOps Lab

Fichier principal :

app/main.py

Docker

Docker est utilisé pour construire une image de l’application et la lancer dans un container.

Construire l’image :

docker build -t devops-lab-app ./app

Lancer le container en arrière-plan :

docker run -d -p 8000:8000 --name devops-lab-container devops-lab-app

Tester l’application :

curl http://localhost:8000

Voir les containers actifs :

docker ps

Voir tous les containers, y compris arrêtés :

docker ps -a

Afficher les logs :

docker logs devops-lab-container

Arrêter le container :

docker stop devops-lab-container

Supprimer le container arrêté :

docker rm devops-lab-container

Concepts retenus :

* Une image est un modèle prêt à lancer.
* Un container est une instance lancée d’une image.
* Un Dockerfile décrit comment construire l’image.
* L’option -d lance le container en arrière-plan.
* L’option -p 8000:8000 relie le port local au port du container.

CI/CD avec GitHub Actions

GitHub Actions est utilisé pour vérifier automatiquement le projet à chaque push sur main.

Workflow :

.github/workflows/docker.yml

La pipeline effectue les étapes suivantes :

1. Récupération du code avec actions/checkout
2. Vérification de la syntaxe Python
3. Construction de l’image Docker
4. Lancement du container
5. Test HTTP avec curl
6. Affichage des logs du container

Commandes principales exécutées par la pipeline :

python -m py_compile app/main.py
docker build -t devops-lab-app ./app
docker run -d -p 8000:8000 --name devops-lab-container devops-lab-app
curl -f http://localhost:8000
docker logs devops-lab-container

Objectif :

* vérifier que le code Python est valide ;
* vérifier que l’image Docker peut être construite ;
* vérifier que le container démarre correctement ;
* vérifier que l’application répond en HTTP ;
* obtenir une pipeline verte ou rouge automatiquement.

Terraform

Terraform est utilisé pour décrire et gérer une ressource Docker avec du code.

Fichier Terraform :

terraform-docker/main.tf

Commandes utilisées :

terraform init
terraform plan
terraform apply
terraform destroy

Rôle des commandes :

* terraform init initialise le projet et télécharge les providers.
* terraform plan affiche ce que Terraform va créer, modifier ou supprimer.
* terraform apply applique les changements.
* terraform destroy supprime les ressources créées par Terraform.

Dans ce lab, Terraform utilise le provider Docker pour lancer l’application conteneurisée.

Après terraform apply, l’application est accessible avec :

curl http://localhost:8000

Réponse attendue :

Hello DevOps Lab

Nettoyage propre :

terraform destroy

Point important :

Si Terraform crée une ressource, il faut la supprimer avec Terraform pour garder son état cohérent.

Fichiers Terraform à ne pas versionner

Les fichiers suivants ne doivent pas être commit :

.terraform/
terraform.tfstate
terraform.tfstate.backup

Ils sont ignorés avec .gitignore, car ils sont locaux, lourds ou peuvent contenir des informations sensibles.

Ce que ce lab démontre

Ce projet montre les bases suivantes :

* création d’une application HTTP simple ;
* conteneurisation avec Docker ;
* lancement et debug d’un container ;
* récupération des logs ;
* automatisation d’un build et d’un test avec GitHub Actions ;
* première approche d’Infrastructure as Code avec Terraform ;
* gestion propre des ressources créées par Terraform.

Prochaine étape

Les prochaines évolutions possibles :

* ajouter un badge GitHub Actions dans le README ;
* ajouter des tests Python ;
* pousser l’image vers une registry ;
* déployer l’application sur Kubernetes ;
* créer un chart Helm ;
* ajouter un playbook Ansible.
