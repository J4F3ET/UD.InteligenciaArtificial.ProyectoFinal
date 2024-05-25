function vecindario = generar_vecindario(x_actual,maquinas,tareas,C,r,b)

    %Genera una matriz de 3 dimenciones que se manipulara como un array de
    %matrices vecindarios sea una matriz de '0' [maquinas x tareas x maquinas]
    vecindario = zeros(maquinas,tareas,maquinas);

    j=1;
    %Estara en bucle mientras que j sea menor o igual a 5
    while j<=maquinas%Filas 5
        for k=1:tareas%Columnas 15
            %Genera el indice aleatorio(Maquina que ejecutara la tarea K)
            m=randi(maquinas);
            %Vuelve toda la columna(Tarea) en '0'
            vecindario(:,k,j) = 0;
            %Agrega un '1' en el indice K(Maquina que se encargara de la tarea)
            vecindario(m,k,j) = 1;
        end

        %Verifica la calidad del la combinacion generada

        %Si la calificacion no es mayor o igual a # no se tomara la
        %combinacion
        if(verificar_solucion(maquinas,tareas,vecindario(:,:,j),r,b) >= 4 )%%&& funcion_objetivo(C,x_actual,r,b)<=funcion_objetivo(C,vecindario(:,:,j),r,b))
            j=j+1;
        end
    end
end

