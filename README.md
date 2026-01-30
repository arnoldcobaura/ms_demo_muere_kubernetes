# Tutorial Kubernetes con Kind + Podman

## Objetivo
Aprender cómo Kubernetes gestiona los pods y los reinicia cuando fallan, usando **Kind** (Kubernetes in Docker/Podman) y **Podman** como runtime de contenedores.  

Se demostrará con un contenedor que imprime mensajes, falla y Kubernetes lo reinicia automáticamente.

---

## Requisitos

- Podman instalado (`podman --version`)
- Kind instalado (`kind --version`)
- kubectl instalado (`kubectl version --client`)

> **Nota:** No se necesita Docker Desktop, solo Podman.

## 1️⃣ Crear el cluster de Kubernetes con Kind usando Podman

```bash
# Decirle a Kind que use Podman
export KIND_EXPERIMENTAL_PROVIDER=podman

# Crear el cluster
kind create cluster --name arnold-cluster

# Verificar cluster
kubectl cluster-info --context kind-arnold-cluster

```

## 2️⃣ Crear la imagen de Docker (ubicate en la carpeta )

```bash
# Construir la imagen
podman build -t demo-muere .
```

## 3️⃣ Cargar la imagen en el cluster Kind (ubicate en la carpeta )

```bash
# Cargar la imagen en el cluster Kind
kind load docker-image demo-muere --name arnold-cluster
```

## 4️⃣ Crear el Deployment

```bash
# Crear el Deployment
kubectl apply -f deployment.yaml --context kind-arnold-cluster
```

## 5️⃣ Verificar el Deployment

```bash
# Verificar el Deployment
kubectl get deployments --context kind-arnold-cluster
```

## 6️⃣ Ver los logs de los pods con timestamps

```bash
# Primero obtener el nombre del pod
kubectl get pods -n default --context kind-arnold-cluster

# Luego ver los logs
kubectl logs -f <nombre_del_pod> -n default --timestamps --context kind-arnold-cluster
```
---

##  Limpiar todo el entorno (opcional, para empezar de cero)

```bash
# Eliminar Deployment si existe
kubectl delete deployment demo-muere --context kind-arnold-cluster

# Eliminar cluster de Kind
kind delete cluster --name arnold-cluster

# Eliminar la imagen local de Podman
podman rmi demo-muere
```
