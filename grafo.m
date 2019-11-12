[num,txt,raw] = xlsread("multi.xlsx");
numero_variable = size(num,2);
variables = string(zeros(1,numero_variable));
for variable=1:size(num,2)
   variables(1,variable) = raw(1,variable+1); 
end


for variable=1:size(num,2)
    numero_valor = 2;
    valor_inicio = 1;
    variables(numero_valor,variable) = num(valor_inicio,variable);
    for valor=1:size(num,1)
        numero = variables(1:end,variable);
        value = string(num(valor,variable));
        ze = zeros(size(numero,1),1);
        cont = contains(numero,value);
        if cont == ze 
                numero_valor = numero_valor + 1;
                variables(numero_valor,variable) = value;
        end
    end
end

present = ismissing(variables);
number = "";
n = 1;
for variable=1:size(variables,2)
   for valor=2:size(variables,1)
       if present(valor,variable) == 0
           name = variables(1,variable)+ "= "+ variables(valor,variable);
           number(n,1) = name ;
           n = n+1  ;
       end
   end
end

indicador = 1;
elemento = 2;
for columna=1:size(variables,2)
   for valor=2:size(variables,1)
       if present(valor,columna) == 0
           for animal=2:size(raw,1)
               if double(variables(valor,columna))==num(animal-1,columna)
                  number(indicador,elemento) = txt(animal,1);
                  elemento = elemento +1;
               end
           end
           elemento=2;
           indicador = indicador+1;
       end
   end
end

aristas = "";
numero_aristas = 1;
sum =0;
interseccion = 0;
inter = "";
for nodo=1:size(number,1)
    conjunto = number(nodo,2:end);
    interse = zeros(1,size(number,2)-1);
    uno = ones(1,size(number,2)-1);
   for other=1:size(number,1)
       otro_conjunto = number(other,2:end);
       intersecciones = intersect(conjunto,otro_conjunto);

       if size(intersecciones,2)>0 && nodo ~= other
               aristas(numero_aristas,1)=nodo;
               aristas(numero_aristas,2)=other;
               aristas(numero_aristas,3)=size(intersecciones,2);
               numero_aristas = numero_aristas+1;
       end
       sum = 0;
       interseccion = 0;
   end
end  

aristas = double(aristas);
G = graph(aristas(1:end,1), aristas(1:end,2),aristas(1:end,3));
G = simplify(G);
G.Nodes.Names = number(1:end,1);

frase =char("Ingrese numero de elementos: ");
nr =char("Ingrese elemento: ");
clase = "";
no=input(frase);
for num=1:no
    clase(num,1)=string(input(nr));
end

tiene = 0;
conjunto1 = zeros(size(num,1),1);
for elemento=1:size(number,1)
       conjunto = number(elemento,2:end);
       hay = contains(clase,conjunto);
       for ind=1:size(hay,1)
          if hay(ind,1)==1
               tiene = tiene +1;
          end
       end
       conjunto1(elemento,1) = tiene;
       tiene = 0;
end
tamano_interseccion = max(conjunto1);
numero_partida = find(conjunto1 == tamano_interseccion);
conjunto_partida = number(numero_partida,2:end);

salida = string(zeros(1,size(conjunto_partida,1)));

for valor=1:size(conjunto_partida,1)
    salida(1,valor) = number(numero_partida(valor),1);
end





var = char("Ingrese numero de variables: ");
rn =char("Ingrese variable: ");
clase1 = "";
varl=input(var);
for num=1:varl
    clase1(num,1)=string(input(nr));
end

subconjuntos = string(zeros(varl,size(number,2)-1));
numero_subconjunto = 0;
tiene = 0;
conjunto1 = zeros(size(num,2)-1,size(clase1,1));
for variable=1:size(number,1)
    for vr=1:size(clase1,1)
        if number(variable,1)==clase1(vr,1)
            numero_subconjunto = numero_subconjunto+1;
            subconjuntos(numero_subconjunto,1:end) = number(variable,2:end);
        end
    end
end

for tam=2:size(subconjuntos,1)
    intersection = intersect(subconjuntos(tam-1,1:end),subconjuntos(tam,1:end));
    disp(intersection)
end    




