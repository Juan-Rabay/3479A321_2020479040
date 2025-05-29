# Laboratorio 7 – Persistencia de datos en la aplicación  

**Matrícula:** 2020479040  
**Alumno:** Juan Rabay  

---

## Resumen de cambios

1. **Menú lateral** reutilizable (`AppDrawer`):  
    Opciones: Home, Preferencias, Actividades.

2. **Persistencia con SharedPreferences** (key–value):  

    En **PreferencesPage**:  
        boton de “Permitir reiniciar contador”  
        Al cambiarlo, se almacena en SharedPreferences.  

    En **HomePage**:  
        carga la preferencia  
        Botón de “Reiniciar” sólo aparece si está habilitado  
        Al volver de Preferences, recarga la preferencia automáticamente.

3. **Persistencia con SQLite**:  
   - **Entidad `Activity`** (`id`, `date`, `name`).  
 
    **ActivitiesPage**:  

        Lista de actividades.  
        “+” para insertar nueva actividad.  
        Botón de borrar junto a cada ítem.  

4. **Integración en HomePage**:  
    `Scaffold.drawer` con `AppDrawer`.  
    Card con contador, saludo, descripción y botones.  
    El reset ya no queda en Provider, sino en SharedPreferences.  
    Navegación a Preferences y Activities desde botones o menú lateral.  

## Repositorio

https://github.com/Juan-Rabay/3479A321_2020479040.git
