function calificacion = verificar_solucion(maquinas,tareas,mejor_solucion,r,b)
    %Genera una matriz con los valores de las tareas en lugares de 1
    mejor_solucion_modificada = remplazar_con_r(maquinas,tareas,mejor_solucion,r);
    calificacion = 0;
    %Recorre la matriz i(Filas [maquinas]) y j(Columnas[tareas])
    for i=1:maquinas
        if(sum(mejor_solucion_modificada(i,:))<=b(i))
            calificacion = calificacion+1;
        end
    end
end

