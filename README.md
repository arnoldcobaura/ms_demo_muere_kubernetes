# Tutorial Kubernetes con Kind + Podman

## Objetivo
Aprender cómo Kubernetes gestiona los pods y los reinicia cuando fallan, usando **Kind** (Kubernetes in Docker/Podman) y **Podman** como runtime de contenedores.  

Se demostrará con un contenedor que imprime mensajes, falla y Kubernetes lo reinicia automáticamente.

---

## Requisitos

- Podman instalado    (`podman --version`)
- Kind instalado      (`kind --version`)
- kubectl instalado   (`kubectl version --client`)

> **Nota:** No se necesita Docker Desktop, solo Podman.

## 1️⃣ Crear el cluster de Kubernetes con Kind usando Podman

### Decirle a Kind que use Podman
```bash
export KIND_EXPERIMENTAL_PROVIDER=podman
```

### Crear el cluster
```bash
kind create cluster --name arnold-cluster
```

### Verificar cluster
```bash
kubectl cluster-info --context kind-arnold-cluster
```

## 2️⃣ Crear la imagen de Docker (ubicate en la carpeta )

### Construir la imagen
```bash
podman build -t demo-muere .
```

## 3️⃣ Cargar la imagen en el cluster Kind (ubicate en la carpeta )

### Cargar la imagen en el cluster Kind
```bash
kind load docker-image demo-muere --name arnold-cluster
```

## 4️⃣ Crear el Deployment

### Crear el Deployment
```bash
kubectl apply -f deployment.yaml --context kind-arnold-cluster
```

## 5️⃣ Verificar el Deployment

### Verificar el Deployment
```bash
kubectl get deployments --context kind-arnold-cluster
```

## 6️⃣ Ver los logs de los pods con timestamps

### Primero obtener el nombre del pod
```bash
kubectl get pods -n default --context kind-arnold-cluster
```

### Ver el estado del pod
```bash
kubectl get pods -w --context kind-arnold-cluster
```

### Luego ver los logs
```bash
kubectl logs -f <nombre_del_pod> -n default --timestamps --context kind-arnold-cluster
```
---

##  Limpiar todo el entorno (opcional, para empezar de cero)

### Eliminar Deployment si existe
```bash
kubectl delete deployment demo-muere --context kind-arnold-cluster
```

### Eliminar cluster de Kind
```bash
kind delete cluster --name arnold-cluster
```

### Eliminar la imagen local de Podman
```bash
podman rmi demo-muere
```
