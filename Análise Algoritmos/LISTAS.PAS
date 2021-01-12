unit Listas;
{
        Unidade que encapsula listas Ordenadas e Encadeadas e suas funá‰es

                Unidade elaborada por Carlos Abreu 126749 11o EN

Bibliografia
  Pereira, Silvio do Lago - "Estruturas de Dados Fundamentais",
     S∆o Paulo: êrica,1996, pag. 38, 109-117.
  Aho, Alfred V., Hopcroft, John E., Ullman, Jeffrey D. - "Data Structures
     and Algorithms", Massachussets: Addison-Wesley, pag. 37-43.
}

interface
         const MAX = 10000;
         { Tamanho m†ximo de items na lista }

         type Pos = integer;
              Endereco = integer;
              Elem = integer;
         { Define os tipos utilizados }

             ListOrd = record
                valor:Elem;
                prox:Endereco;
                end;
         { Lista Ordenada }

            LE = ^no;
            no = record
               valor:elem;
               prox:LE;
            end;
         { Lista Encadeada }
var
   LO:array[1..MAX] of ListOrd;

{ Implementaá∆o da lista ordenada }

         procedure Aloca(var N:endereco);
         { Aloca uma Lista }

         procedure Libera(var N:endereco);


{ Implementaá∆o da Lista Encadeada }
         procedure Cria(var Lista:LE);
         { Cria uma lista vazia }

         function Nulo(Lista:LE):boolean;
         { Verifica se a Lista est† vazia }

         procedure Ins(var Lista:LE;Elemento:elem);
         { Insere um elemento Ö lista }

         function Rem(var Lista:LE;Elemento:Elem):boolean;
         { Remove um elemento da lista }

         function Encontra(Lista:LE;Elemento:elem):LE;
         { Pesquisa um elemento na Lista }

         procedure Mostra(Nome:char;Lista:LE);
         { Mostra os conteudos de uma lista }

         procedure Destroi(var Lista:LE);
         { Destroi uma lista}


implementation
var
   disp:endereco;

procedure IniciaMem;
var
   i:integer;
begin
     for i:=1 to Max do
         LO[i].prox:=i+1;
     disp:=1;
     LO[max].prox:=0;
end;

procedure Aloca(var N:Endereco);
begin
     if disp<>0 then
        begin
             N:=disp;
             Disp:=LO[disp].prox;
             LO[N].prox:=0;
        end
     else
         writeln('Erro de Alocaá∆o');
end;

procedure Libera(var N:Endereco);
begin
     LO[N].Prox:=disp;
     disp:=N;
     N:=0;
end;



procedure Cria(var Lista:LE);
begin
     Lista:=nil;
end;

function Nulo(Lista:LE):boolean;
begin
     Nulo:=(Lista=nil);
end;

procedure Ins(var Lista:LE;Elemento:elem);
var
   N,P:LE;
begin
     new(N);
     N^.valor:=Elemento;
     if nulo(Lista) or (Elemento<Lista^.valor) then
        begin
             N^.prox:=Lista;
             Lista:=N;
        end
     else
         begin
              P:=Lista;
              while (P^.prox<>nil) and (Elemento>P^.prox^.valor) do
                    P:=P^.prox;
              N^.prox:=P^.prox;
              P^.prox:=N;
         end;
end;

function Rem(var Lista:LE;Elemento:Elem):boolean;
var
   P,Q:LE;
begin
     if nulo(Lista) or (Elemento<Lista^.valor) then
        Rem:=false
     else
         if Elemento=Lista^.valor then
            begin
                 P:=Lista;
                 Lista:=Lista^.prox;
                 dispose(P);
                 Rem:=true;
            end
         else
             begin
                  P:=Lista;
                  while (P^.prox<>nil) and (Elemento>P^.prox^.valor) do
                        P:=P^.prox;
                  if (P^.prox<>nil) and (Elemento=P^.prox^.valor) then
                     begin
                          q:=P^.prox;
                          P^.prox:=Q^.prox;
                          dispose(q);
                          rem:=true;
                     end
                  else
                      rem:=false;
             end;
end;

function Encontra(Lista:LE;Elemento:elem):LE;
var
   P:LE;
begin
     P:=Lista;
     while (P<>nil) and (elemento>P^.valor) do
           P:=P^.prox;
     if (P<>nil) and (elemento=P^.valor) then
        Encontra:=P
     else
         Encontra:=nil;
end;

procedure Mostra(Nome:char;Lista:LE);
var
   P:LE;
begin
     P:=lista;
     write(nome,':[');
     while P<>nil do
           begin
                write(P^.valor,',');
                P:=P^.prox;
           end;
     writeln(']');
end;

procedure Destroi(var Lista:LE);
var
   P:LE;
begin
     while Lista<>nil do
           begin
                P:=Lista;
                Lista:=Lista^.prox;
                dispose(p);
           end;
end;

begin
     IniciaMem;


end.