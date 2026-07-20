#  Salon Appointment Scheduler (freeCodeCamp Project)

Este proyecto es parte del programa de certificación **Relational Database** de [freeCodeCamp](https://www.freecodecamp.org/). Consiste en la automatización interactiva de una barbería/salón de belleza mediante un script Bash integrado con una base de datos relacional en PostgreSQL.

## 🚀 Características Clave

* **Diseño Relacional Robusto**: Esquema en PostgreSQL estructurado en 3 tablas (`customers, services, appointments`) aplicando claves primarias autoincrementables, claves foráneas para integridad referencial y restricciones de unicidad (`UNIQUE`) en teléfonos.

* **Menú Interactivo y Recursivo**: Interfaz por consola escrita en Bash que valida en tiempo real las entradas del usuario. Si selecciona una opción inexistente, el sistema reintenta la navegación fluidamente mediante llamadas recursivas.

* **Registro Automatizado de Clientes**: Lógica condicional que detecta si el teléfono ingresado pertenece a un cliente existente o si requiere registrarlo por primera vez antes de agendar.

* **Procesamiento de Datos Nivel Shell**: Uso de tubos (pipes), redefinición de separadores de campo (`IFS`) y consultas SQL en tiempo de ejecución utilizando el CLI de psql con banderas optimizadas (`-t --no-align`).

---

## 🛠️ Tecnologías Utilizadas

| **Tecnología** | **Descripción**
| --- | --- | 
| **PostgreSQL** | Motor de base de datos relacional para la persistencia. |
| **Bash Shell** | Entorno de comandos para la lógica e interfaz interactiva. |
| **SQL** | Consultas nativas de lectura (`SELECT`) e inserción (`INSERT`). |

---

## 📂 Estructura de la Base de Datos
```plaintext
salon (Database)
 ├── services      (service_id [PK], name)
 ├── customers     (customer_id [PK], phone [UNIQUE], name)
 └── appointments  (appointment_id [PK], customer_id [FK], service_id [FK], time)
```
---

## 💻 **Ejecución del Proyecto**

1. **Asegúrate de tener PostgreSQL ejecutándose y la base de datos `salon` creada:**
   ```bash
   psql -U freecodecamp -d salon < salon.sql
    ```
2. **Otorga permisos de ejecución al script:**
   ```bash
   chmod +x salon.sh
   ```

3. **Ejecuta el agendador:**
   ```bash
   ./salon.sh
   ```