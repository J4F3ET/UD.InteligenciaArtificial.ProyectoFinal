function mejor_solucion_modificada = remplazar_con_r(maquinas,tareas,mejor_solucion,r)
    %Genera una matriz de maquinas(filas) X tareas(columnas) y la rellena
    %de 0
    mejor_solucion_modificada = zeros(maquinas,tareas);
    %Recorrer la matriz cambiando los '1' por el valor correspondiente en r
    for i=1:maquinas
        for j=1:tareas
            if(mejor_solucion(i,j)==1)
               mejor_solucion_modificada(i,j) = r(i,j);
            end
        end
    end
end

