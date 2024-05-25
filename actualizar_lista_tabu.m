function z = actualizar_lista_tabu(valor_mejor_movimiento,lista_tabu,es_tabu)
    if (es_tabu==0)% Si es tabu entonces(el movimiento no esta registrado en lista)
        for i=3:-1:2
           lista_tabu(:,:,i)=lista_tabu(:,:,i-1);
        end
        % Se cambia la posicion 1 por el valor del mejor movimiento
        lista_tabu(:,:,1)=valor_mejor_movimiento;
    else %Si no es tabu(el movimiento esta registrado en lista)
        posicion=1;
        
        %Encuentra la posicion dentro de la lista tabu de
        %valor_movimiento_mejor
        while (posicion <= 3) && (lista_tabu(:,:,posicion)~=valor_mejor_movimiento)
            posicion=posicion+1;
        end
        
        %Si el movimiento ya esta registrado y justamente esta en la
        %posicion 1 no se mueve caso contrario si se mueven las posiciones
        if (posicion~=1)
            %Recorre la lista de 3 posiciones desde el 3 hasta el 2 corriendo
            %valores, posicion 2 pasa a la 3 y posicion 1 pasa a la 2
            for i=posicion:-1:2
                lista_tabu(:,:,i)=lista_tabu(:,:,i-1);
            end
            lista_tabu(:,:,1)=valor_mejor_movimiento;
        end
    end
    z=lista_tabu;
end