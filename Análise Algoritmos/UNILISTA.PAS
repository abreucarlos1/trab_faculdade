unit Listas;
{ Unidade que encapsula listas e suas fun‡äes }

{ Unidade elaborada por Carlos Abreu 126749 11o EN}
{
Bibliografia
  Pereira, Silvio do Lago - "Estruturas de Dados Fundamentais",
     SÆo Paulo: rica,1996, pag. 38
  Aho, Alfred V., Hopcroft, John E., Ullman, Jeffrey D. - "Data Structures
     and Algorithms", Massachussets: Addison-Wesley, pag. 37-43.
}

interface
         const MAX = 100;
         { Tamanho m ximo de items na lista }

         type Pos = integer;
              Elem = integer;

             List = record
              valor:array[1..MAX] of integer;
              ultimo:integer;
         end;
         {Cria o tipo lista, com items de tipo inteiro }

         function Final(var Lista:List):pos;
         { Retorna o ultimo indice disponivel}

         procedure Inicializa(var Lista:list);
         { Inicializa lista com valores nulos (0) }

         procedure Insere(Elemento:Elem;posicao:pos;var Lista:List);
         { Insere um elemento … lista, em determinada posi‡Æo }

         procedure Remove(posicao:pos;var Lista:List);
         { Remove um item de determinada posi‡Æo }

         function Busca(Elemento:elem;Lista:List):pos;
         { Retorna a posi‡Æo do elemento na lista }

implementation

function Final(var Lista:List):pos;
begin
     Final:=(Lista.ultimo+1);
end;

procedure inicializa(var Lista:list);
var
   p:pos;
begin
     for p:=1 to MAX do
         Lista.valor[p]:=0;
     lista.ultimo:=0;
end;

procedure Insere(Elemento:elem;posicao:pos;var Lista:List);
var
   p:pos;
begin
     if Lista.ultimo >= MAX then
        writeln('Lista Cheia.')
     else
         if (posicao > Lista.ultimo + 1) or (posicao < 1) then
            writeln('Posi‡Æo inexistente.')
         else
             begin
                  for p := Lista.ultimo downto p do
                      Lista.valor[p + 1] := Lista.valor[ p ];
                  Lista.ultimo := Lista.ultimo + 1;
                  Lista.valor[posicao] := Elemento;
             end;
end;

procedure Remove(Posicao:pos;var Lista:list);
var
   p:pos;
begin
     if ( posicao > Lista.ultimo) or ( posicao < 1 ) then
        writeln('Posi‡Æo inexistente.')
     else
         begin
              Lista.ultimo:=Lista.ultimo-1;
              for p:=posicao to Lista.ultimo do
                  Lista.valor[p]:=Lista.valor[p+1];
         end;
end;

function Busca(Elemento:elem;Lista:list):pos;
var
   p:pos;
begin
     for p:=1 to Lista.ultimo do
         if Lista.valor[p]=Elemento then
            Busca:=p;
     busca:=Lista.ultimo+1;
end;

end.