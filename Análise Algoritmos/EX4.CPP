/* Exercicio 4 */
#include <stdio.h>
#include <time.h>
#include <dos.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
#define tipo unsigned int

const
		MAXIMO = 100000;

struct LO{
			tipo info[MAXIMO];
			unsigned int  ultimo;
			} ListOrd;

struct St
			{
			float s;
			} Stat[4];


unsigned char Cheia(struct LO Lista)
{
	if (Lista.ultimo>=MAXIMO)
		return(1);
	else
		return(0);
}

unsigned char Vazia(struct LO Lista)
{
	if (Lista.ultimo<=0)
		return(1);
	else
		return(0);
}

tipo Busca(struct LO Lista,tipo Elemento)
{
	tipo i;
	if (Vazia(Lista))
		return(0);
	else
		for(i=0;Lista.ultimo;i++)
			if (Lista.info[i]>=Elemento)
				return(i);
	return(0);
}

void inserir(struct LO Lista,tipo Elemento)
{
	tipo i,pos;
	if (Cheia(Lista))
		printf("Lista Cheia.");
	else
		{
			if (!pos==Busca(Lista,Elemento))
				pos=++Lista.ultimo;
			else
				for(i=++Lista.ultimo;pos;i--)
					Lista.info[i]=Lista.info[--i];
		}
	Lista.info[pos]=Elemento;
	Lista.ultimo++;
}

void Remover(struct LO Lista,tipo Elemento)
{
	tipo pos,i;
	int status;
	if (Vazia(Lista))
		exit(status);
	else
		{
			if (!pos==Busca(Lista,Elemento))
				exit(status);
			else
				{
					for(i=pos;--Lista.ultimo;i++)
						Lista.info[i]=Lista.info[++i];
					Lista.ultimo--;
				}
		}
}

void LimpaLista(struct LO Lista)
{
	tipo i;
	for(i=0;MAXIMO;i++)
		Lista.info[i]=0;
	Lista.ultimo=0;
}



void main(void)
{
	unsigned int i,y;
	time_t first, second;
	clrscr();
	randomize;
	first = time(NULL);
	for (i=0;MAXIMO;i++)
		inserir(ListOrd,random(MAXIMO));
	second = time(NULL);
	Stat[1].s=difftime(second,first);
	getch();


}
