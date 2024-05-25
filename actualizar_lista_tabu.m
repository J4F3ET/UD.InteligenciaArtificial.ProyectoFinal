function z = actualizar_lista_tabu(valor_mejor_movimiento, lista_tabu, es_tabu)
    if (es_tabu == 0) % Si no es tabú, entonces el movimiento no está registrado en la lista
        for i = 3:-1:2
            lista_tabu(:, :, i) = lista_tabu(:, :, i - 1);
        end
        % Se cambia la posición 1 por el valor del mejor movimiento
        lista_tabu(:, :, 1) = valor_mejor_movimiento;
    else % Si es tabú, el movimiento está registrado en la lista
        posicion = 1;

        % Encuentra la posición dentro de la lista tabú del valor_movimiento_mejor
        while (posicion <= 3) && ~isequal(lista_tabu(:, :, posicion), valor_mejor_movimiento)
            posicion = posicion + 1;
        end

        % Si el movimiento ya está registrado y está en la posición 1, no se mueve
        % Caso contrario, se mueven las posiciones
        if (posicion ~= 1)
            % Recorre la lista de 3 posiciones desde el 3 hasta el 2 corriendo
            % valores, posición 2 pasa a la 3 y posición 1 pasa a la 2
            for i = posicion:-1:2
                lista_tabu(:, :, i) = lista_tabu(:, :, i - 1);
            end
            lista_tabu(:, :, 1) = valor_mejor_movimiento;
        end
    end
    z = lista_tabu;
end
