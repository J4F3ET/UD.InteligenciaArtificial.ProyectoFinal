function z = verifica_es_tabu(valor_mejor_movimiento,lista_tabu)
    z=0;
    for i=1:3
        if valor_mejor_movimiento==lista_tabu(:,:,i)
            z=1;
        end
    end
end