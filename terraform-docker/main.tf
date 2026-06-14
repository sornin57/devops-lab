terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "app" {
  name = "devops-lab-app:latest"
}

resource "docker_container" "app" {
  name  = "terraform-devops-lab-app"
  image = docker_image.app.image_id

  ports {
    internal = 8000
    external = 8000
  }
}
