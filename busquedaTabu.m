clear;
%Importa los datos C,X,b,r
load("data.mat")
numero_iteraciones=input('Digite numero de iteraciones: ');
%Conocer el numero de Maquinas(filas) y el numero de Tareas(columnas)
[maquinas, tareas] = size(C);
x_actual=X;
nivel_aspiracion=funcion_objetivo(C,x_actual,r,b);
mejor_solucion=x_actual;
%Una lista de misma cantidad de vecinos(5)
lista_tabu=zeros(maquinas,tareas,5);
%Nivel de calidad de la solucion (1 a 5)
calificacion = verificar_solucion(maquinas,tareas,mejor_solucion,r,b);
%Remplaza los valores 1 de la matriz x_actual por los valores en r en su
%mismo indice
solucion = remplazar_con_r(maquinas,tareas,x_actual,r);
for i=1:numero_iteraciones
    %Genera un array de combinaciones(vecinos)
    vecindario = generar_vecindario(x_actual,maquinas,tareas,C,r,b);
    
    %Retorna el indice y costo del mejor vecino
    [mejor_vecino_indice,mejor_vecino_costo]=mayor(vecindario,maquinas,C,r,b);
    
    %Retorna el mejor vecino(combinacion) del vecindario
    candidato = vecindario(:,:,mejor_vecino_indice);

    %Verifica si la combinacion ya esta registrada en la lista tabu
    es_tabu=verifica_es_tabu(candidato,lista_tabu);

    %Si no esta registrado actualizado x_actual
    if(es_tabu==0)
        x_actual=candidato;
    end
    
    %Si el candidato tiene mejor nivel de aspiracion
    if(funcion_objetivo(C,candidato,r,b)>nivel_aspiracion)
        nivel_aspiracion = funcion_objetivo(C,candidato,r,b);
        mejor_solucion=candidato;
        lista_tabu=actualizar_lista_tabu(candidato,lista_tabu,es_tabu);
    end

    %LISTAS DE REGISTROS

    lista_soluciones(i:numero_iteraciones)=funcion_objetivo(C,x_actual,r,b);
    lista_nivel_aspiraciones(i:numero_iteraciones)=nivel_aspiracion;
    nueva_calificacion =  verificar_solucion(maquinas,tareas,x_actual,r,b);
    lista_test(i:numero_iteraciones) = nueva_calificacion;

    %Guarda la mejor solucion de las iteraciones
    if(nueva_calificacion > calificacion)
        solucion = remplazar_con_r(maquinas,tareas,x_actual,r);
    end

    calificacion = nueva_calificacion;
end
disp("Nivel de aspiracion"+nivel_aspiracion);
figure;
plot (1:numero_iteraciones,lista_soluciones,1:numero_iteraciones,lista_nivel_aspiraciones);
grid on
figure
bar(lista_test)
grid on
disp("Solucion(X)")
disp(solucion)
disp("Comparacion de b con la suma de la solucion")
disp("b---solucion")
for i=1:maquinas
    disp([b(i),sum(solucion(i,:))])
end

