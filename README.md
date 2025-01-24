# Pruebas de la API de Restful Booker

Este proyecto contiene pruebas automatizadas para la API **Restful Booker** utilizando **Karate Framework** y **Maven**. Las pruebas cubren todos los métodos de la API (GET, POST, PUT, PATCH, DELETE) y verifican su correcto funcionamiento.

## Descripción del Proyecto

Este repositorio contiene pruebas de API que cubren los siguientes aspectos de la API de **Restful Booker**:
- **Autenticación y obtención de token**.
- **Creación, actualización y eliminación de reservas**.
- **Generación de datos dinámicos utilizando Faker**.

## Configuración de las Variables del Sistema del Usuario

Para que la autenticación funcione correctamente, debes configurar las variables de entorno del usuario con las siguientes credenciales necesarias para la autenticación:

- **API_USER**: El nombre de usuario para la autenticación.
- **API_PASSWORD**: La contraseña asociada al usuario para la autenticación.

### **Cómo Configurar las Variables:**

#### **En Windows:**
1. Abre el **Panel de Control** y busca **"Variables de entorno"**.
2. En **Variables del usuario**, haz clic en **Nuevo**.
3. Crea las variables con los siguientes nombres y valores:
    - **API_USER**: [admin]
    - **API_PASSWORD**: [admin123]
4. Guarda y aplica los cambios.

Para verificar que las variables están configuradas correctamente, abre una terminal y ejecuta:
```bash
echo %API_USER%
echo %API_PASSWORD%
```
## Estructura del Proyecto

```bash
├── src
│   └── test
│       └── java
│           └── bookerApi
│               ├── auth
│               │   └── getToken.feature
│               ├── common
│               │   └── createNewBooking.feature
│               ├── delete
│               │   └── deleteBooking.feature
│               ├── get
│               │   ├── getAllBookings.feature
│               │   └── getBookingById.feature
│               ├── helpers
│               │   ├── dataGeneratorTemplate.feature
│               │   └── fakerDataGenerator.feature
│               ├── patch
│               │   └── patchBooking.feature
│               ├── post
│               │   └── postBooking.feature
│               ├── put
│               │   └── putBooking.feature
│               └── TestRunner.java
│               │
│               ├── karate-config.js
│               ├── logback-test.xml
│               └── TestRunner.java
├── pom.xml
├── .gitignore
└── README.md
````

