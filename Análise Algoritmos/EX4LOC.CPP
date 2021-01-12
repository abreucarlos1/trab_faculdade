void Create(struct LE *Lista)
{
	Lista=NULL;
}

unsigned char Null(struct LE *Lista)
{
	return(Lista==NULL);
}

void Insert(struct LE *Lista,tipo Elemento)
{
	struct LE *N,*P;
	N=(struct LE *) calloc (1,sizeof(struct LE *));
	N->info=Elemento;
	if ((Null(Lista)) || (Elemento<Lista->info))
		{
			N->prox=Lista;
			Lista=N;
		}
	else
		{
			P=Lista;
			while ((P->prox!=NULL) && (Elemento>P->prox->info))
				P=P->prox;
			N->prox=P->prox;
			P->prox=N;
		}
}

unsigned char Del(struct LE *Lista,tipo Elemento)
{
	struct LE *P,*Q;
	if ((Null(Lista)) || (Elemento<Lista->info))
		return(0);
	else
		if (Elemento==Lista->info)
			{
				P=Lista;
				Lista=Lista->prox;
				free(P);
				return(1);
			}
		else
			{
				P=Lista;
				while ((P->prox!=NULL) && (Elemento>P->prox->info))
					P=P->prox;
				if ((P->prox!=NULL) && (Elemento==P->prox->info))
					{
						Q=P->prox;
						P->prox=Q->prox;
						free(Q);
						return(1);
					}
			}
	return(0);
}