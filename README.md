# DevOps Lab

Objectif : pratiquer les bases DevOps autour de Linux, Git, Docker, CI/CD, Terraform, Kubernetes, Helm et Ansible.

## Progression

- Linux : bases en cours
- Git : bases en cours
- Docker : en cours
- CI/CD : à venir
- Terraform : à venir
- Kubernetes : à venir
- Helm : à venir
- Ansible : à venir

## Docker

Cette première étape consiste à créer une petite application HTTP en Python, puis à la lancer dans un container Docker.

### Commandes utilisées

Construire l'image :

```bash
cd app
docker build -t devops-lab-app .
docker run -p 8000:8000 devops-lab-app
docker run -d -p 8000:8000 --name devops-lab-container devops-lab-app
contenairs actif docker ps
logs : docker logs devops-lab-container
docker stop devops-lab-container
docker rm devops-lab-container

## CI/CD avec GitHub Actions

Ce projet utilise GitHub Actions pour vérifier automatiquement que l'application peut être construite et lancée dans un container Docker.

Le workflow se trouve ici :

```text
.github/workflows/docker.yml

docker build -t devops-lab-app ./app
docker run -d -p 8000:8000 --name devops-lab-container devops-lab-app
curl -f http://localhost:8000
docker logs devops-lab-container


