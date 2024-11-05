# Deploy to Amazon ECS with GitHub Actions and Terraform

Este repositorio contiene un flujo de trabajo de GitHub Actions para desplegar automáticamente una aplicación en Amazon Elastic Container Service (ECS) utilizando Docker y Terraform. Al hacer push en la rama `main`, el flujo de trabajo realiza los siguientes pasos:

1. **Construye y envía una imagen de Docker a Amazon Elastic Container Registry (ECR)**.
2. **Inicia Terraform** para desplegar la infraestructura en AWS.
3. **Aplica los cambios de Terraform** para gestionar los recursos necesarios en ECS.

## Arquitectura del Proyecto

![Arquitectura del despliegue en AWS ECS](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*xabx1cj-C-nVcg8Sbo1Rfw.png)

Este diagrama muestra el flujo general de despliegue en ECS. La imagen destaca la conexión entre GitHub Actions, Docker, Terraform y AWS para el despliegue de la aplicación.

## Configuración

### Prerrequisitos

Para que este flujo de trabajo funcione correctamente, debes:

1. Tener configurado un repositorio en Amazon ECR.
2. Contar con un conjunto de credenciales de AWS (clave de acceso y clave secreta) con los permisos necesarios.
3. Configurar un bucket de S3 y un estado de bloqueo en DynamoDB para almacenar el estado de Terraform, si estás trabajando en un entorno compartido.

### Variables de GitHub Secrets

Debes configurar los siguientes `Secrets` en tu repositorio de GitHub:

- `AWS_ACCESS_KEY_ID`: Tu ID de clave de acceso de AWS.
- `AWS_SECRET_ACCESS_KEY`: Tu clave secreta de AWS.
- `AWS_DEFAULT_REGION`: La región de AWS donde se desplegará la aplicación (por ejemplo, `us-east-2`).

### Variables de Entorno

Dentro del flujo de trabajo, se definen las siguientes variables de entorno:

- `ECR_REGISTRY`: El URI del registro de Amazon ECR.
- `ECR_REPOSITORY`: El nombre del repositorio de ECR donde se almacenará la imagen de Docker.
- `IMAGE_TAG`: La etiqueta de la imagen de Docker (en este caso, `latest`).

## Flujo de Trabajo: `Deploy to ECS`

Este flujo de trabajo se activa automáticamente al realizar un push a la rama `main`.

### Pasos del Flujo de Trabajo

1. **Checkout del Código**: Clona el repositorio en la máquina virtual de GitHub Actions.
2. **Configuración de Docker Buildx**: Configura el entorno de Docker para crear imágenes multiplataforma.
3. **Configuración de Credenciales de AWS**: Configura las credenciales para autenticarse en AWS.
4. **Inicio de Sesión en Amazon ECR**: Inicia sesión en ECR para permitir la subida de imágenes.
5. **Construcción, Etiquetado y Subida de la Imagen de Docker**: Construye la imagen de Docker y la envía al repositorio de ECR.
6. **Descarga de Terraform**: Configura Terraform con la versión especificada.
7. **Inicialización de Terraform**: Ejecuta `terraform init` en el directorio `./terraform`.
8. **Aplicación de Terraform**: Aplica los cambios necesarios en AWS para desplegar la aplicación.

### Flujo de Trabajo Opcional: `Terraform Destroy`

Este flujo de trabajo opcional, actualmente comentado, permite destruir la infraestructura en AWS al ejecutarlo en la rama configurada.

1. **Inicialización de Terraform**: Ejecuta `terraform init` en el directorio `./terraform`.
2. **Destrucción de Recursos con Terraform**: Ejecuta `terraform destroy -auto-approve` para eliminar todos los recursos creados.

Para activar este flujo de trabajo, descomenta el código de la sección `Terraform Destroy` y realiza un push en la rama principal.

## Estructura del Proyecto

```plaintext
.
├── .github
│   └── workflows
│       └── deploy.yml       # Configuración del flujo de trabajo de despliegue
├── terraform                # Archivos de configuración de Terraform para la infraestructura
├── docs
│   └── arquitectura.png     # Imagen de la arquitectura del proyecto
├── Dockerfile               # Archivo Docker para la construcción de la imagen
└── README.md                # Documentación del proyecto
