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

