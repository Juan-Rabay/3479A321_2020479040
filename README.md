# Laboratorio 6 

**Matrícula:** 2020479040  
**Alumno:** Juan Rabay  

## 📖 Resumen de cambios

1. **Ciclo de vida completo** de `MyHomePage` con logs (usando `Logger`):
   - createState
   - initState
   - didChangeDependencies
   - build (incluye mounted)
   - reassemble(hot reload)
   - didUpdateWidget
   - deactivate
   - dispose

2. **Gestión de estado global** con **Provider** (ChangeNotifier):
    Variables: counter, username, allowReset
    Métodos: incrementCounter(), decrementCounter(), resetCounter(), setUsername(), toggleReset()

3. **UI Home**:
   - Card actualizado con nuevo texto:
    ¡Bienvenido, "texto!"
    Descripción del framework
    Icono SVG
    Contador Provider
    Botones **– / reset / +** (reset solo si `allowReset == true`, es decir, cuando el usuario lo permite)
    Único botón de navegación con **tap = push** / **long-press = pushReplacement**  

4. **Pantallas secundarias**:
    **AboutPage**  
    Edita **nombre de usuario** (TextField)  
    Activa/desactiva el reset (Switch)  
    Botón: **Tap = volver** / **Long-press = replace Home**  
    **ListContentPage**  
    Botón para ir a AboutPage  

5. **Navegación con condiciones**:
    **Contador par** va a **ListContentPage**  
    **Contador impar** va a **AboutPage**  
    Desde **ListContentPage** se puede ir a **AboutPage** y volver  

## Repositorio

[GitHub - 3479A321_2020479040](https://github.com/Juan-Rabay/3479A321_2020479040)

