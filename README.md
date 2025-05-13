# 🧑‍💻 Convenciones de desarrollo
Esta guía define las normas para contribuir al proyecto y mantener un flujo de trabajo limpio y ordenado.

## 🌱 Flujo de trabajo (Git Flow)

1. **Crear una rama temporal por funcionalidad o fix**:
   - Basarse siempre en la rama `main`.
   - Usar la siguiente convención para el nombre de la rama:
     ```
     feat/nombre-de-la-funcionalidad
     fix/correccion-especifica
     chore/tarea-tecnica
     ```
   - Ejemplos:
     - `feat/login-usuario`
     - `fix/error-404-dashboard`
     - `chore/actualizar-dependencias`

2. **Commits con nomenclatura estándar**:
   Utilizar la siguiente estructura en los mensajes de commit:

   ```
   tipo: mensaje corto y descriptivo
   ```

   ### Tipos válidos:
   - `feat`: Nueva funcionalidad
   - `fix`: Corrección de bugs
   - `docs`: Cambios en la documentación
   - `style`: Formato, espacios, puntos y comas, etc. (sin cambios de lógica)
   - `refactor`: Refactorización del código (ni funcionalidades ni correcciones)
   - `test`: Agregar o corregir tests
   - `chore`: Tareas de mantenimiento del proyecto

   ### Ejemplos:
   ```
   feat: agregar pantalla de registro
   fix: corregir validación en formulario de login
   chore: actualizar paquetes npm
   ```

3. **Hacer Pull Request al terminar la funcionalidad**:
   - Asegúrate de que los cambios estén probados y listos.
   - Crear un Pull Request (PR) a la rama principal (`main` o `develop`).
   - Seleccionar la opción **"Squash and merge"** al aprobar el PR.
   - Borrar la rama temporal después de hacer el merge.

---

## ✅ Buenas prácticas

- Escribe commits pequeños y atómicos, con un solo propósito.
- Añade descripciones claras en los PRs: qué se hizo, por qué, y si hay algo que revisar con detalle.
- Ejecuta pruebas antes de hacer PR.
- No hagas merge directo a `main` sin PR.
