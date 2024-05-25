function aceptar_solucion = probabilidad(delta, temperatura)
    aceptar_solucion = rand < exp(delta / temperatura);
end
