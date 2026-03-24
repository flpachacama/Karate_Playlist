# Karate API Automation - Automation Exercise

Proyecto de automatizacion de pruebas API con Karate DSL + Java + Maven.

## Objetivo

Validar metodos HTTP sobre la API publica de Automation Exercise:

- GET
- POST
- PUT
- DELETE

Base API: `https://automationexercise.com`

## Tecnologias

- Java 17
- Maven
- Karate 1.5.0
- JUnit 5 (runner Karate)

## Estructura del proyecto

```text
src/
  test/
	java/
	  karate-config.js
	  com/softka/runner/ApiTestRunner.java
	resources/
	  data/
		account/
		  create-account-base.json
		  update-account-base.json
		schemas/
		  products-schema.json
	  features/
		common/
		  account-actions.feature
		products/
		  get-products.feature
		account/
		  post-create-account.feature
		  put-update-account.feature
		  delete-account.feature
	  utils/
		account-data.js
```

## Configuracion

`karate-config.js` incluye:

- manejo de ambiente por `karate.env` (`dev` y `qa`)
- `baseUrl` centralizada
- headers comunes (`Accept: application/json`)
- timeouts de conexion y lectura

Ejemplo de ambientes:

- `dev` -> `https://automationexercise.com`
- `qa` -> `https://automationexercise.com`

## Escenarios implementados

1. `features/products/get-products.feature`
   - GET `api/productsList`
   - valida status code
   - valida estructura JSON general
   - valida campos clave del primer producto

2. `features/account/post-create-account.feature`
   - POST `api/createAccount`
   - usa datos parametrizados desde JSON
   - valida `responseCode` y `message`
   - cleanup con delete para mantener idempotencia

3. `features/account/put-update-account.feature`
   - crea cuenta previa (reuso via `call`)
   - PUT `api/updateAccount`
   - valida status, estructura y mensaje
   - cleanup con delete

4. `features/account/delete-account.feature`
   - crea cuenta previa (reuso via `call`)
   - DELETE `api/deleteAccount`
   - valida status, estructura y mensaje

## Buenas practicas aplicadas

- features separadas por endpoint y responsabilidad
- acciones comunes extraidas en `features/common/account-actions.feature`
- datos de prueba externos en `data/account/*.json`
- parametrizacion dinamica de email en `utils/account-data.js`
- limpieza de datos para evitar colisiones entre ejecuciones

## Ejecucion de pruebas

Ejecutar toda la suite:

```cmd
mvn clean test
```

Ejecutar por ambiente QA:

```cmd
mvn clean test -Dkarate.env=qa
```

Ejecutar una feature especifica:

```cmd
mvn test -Dkarate.options="classpath:features/products/get-products.feature"
```

## Reportes

Al finalizar la ejecucion, Karate genera reportes HTML en:

- `target/karate-reports/`

JUnit/Surefire tambien deja reportes en:

- `target/surefire-reports/`

## Notas

- Los endpoints de cuenta trabajan con `form fields`, por eso los payloads JSON se cargan como mapa y se envian como formulario.
- El proyecto esta preparado para escalar con mas endpoints, tags y data-driven testing.