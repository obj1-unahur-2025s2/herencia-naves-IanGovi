class Nave {
  var velocidad = 0
  var direccionConRespectoAlSol = 0

  method acelerar(cuanto) {velocidad = (velocidad + cuanto).min(100000)}
  method desacelerar(cuanto) {velocidad = (velocidad - cuanto).max(0)}

  method irHaciaElSol() {direccionConRespectoAlSol = 10}
  method escaparDelSol() {direccionConRespectoAlSol = -10}
  method ponerseParaleloAlSol() {direccionConRespectoAlSol = 0}

  method acercarseUnPocoAlSol() {direccionConRespectoAlSol = (direccionConRespectoAlSol + 1).min(10)}
  method alejarseUnPocoDelSol() {direccionConRespectoAlSol = (direccionConRespectoAlSol - 1).max(-10)}

  method prepararViaje()

  method superAcelerar(cuanto) /*Extra*/ {
    if(!cuanto.between(0, 50000)) {
      self.error("El valor debe estar entre el 0 y el 50000")
      // throw new Exception(message = "El valor debe estar entre el 0 y el 50000") Es la que se usa en otros lenguajes
    }
    self.acelerar(cuanto * 2)
  }

  method velocidad() = velocidad
  method direccionConRespectoAlSol() = direccionConRespectoAlSol

}

class NaveBaliza inherits Nave {
  var color

  method cambiarColorDeBaliza(colorNuevo) {color = colorNuevo}
  method color() = color

  override method prepararViaje() {
    self.cambiarColorDeBaliza("Verde")
    self.ponerseParaleloAlSol()
  }
}

class NaveDePasajeros inherits Nave{
  var property cantidadDePasajeros
  var comida
  var bebida

  method comida() = comida
  method bebida() = bebida
  method cargarComida(cantidad) {comida = comida + cantidad}
  method descargarComida(cantidad) {comida = (comida - cantidad).max(0)}
  method cargarBebida(cantidad) {bebida = bebida + cantidad}
  method descargarBebida(cantidad) {bebida = (bebida - cantidad).max(0)}

  override method prepararViaje() {
    self.cargarComida(4 * cantidadDePasajeros)
    self.cargarBebida(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
  }
}

class NaveDeCombate inherits Nave {
  var estaInvisible = true
  var misilesDesplegados
  const property mensajesEmitidos = []

  method ponerseVisible() {estaInvisible = false}
  method ponerseInvisible() {estaInvisible = true}
  method estaVisible() = estaInvisible

  method desplegarMisiles() {misilesDesplegados = true}
  method replegarMisiles() {misilesDesplegados = false}
  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(mensaje) {mensajesEmitidos.add(mensaje)}
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method esEscueta() = !mensajesEmitidos.any({mensaje => mensaje.size() < 30}) // O !mensajesEmitidos.all({mensaje => mensaje.size() >= 30})
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje() {
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }
}

// Falta de combustible en adelante