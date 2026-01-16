# Modelo de Cooperação Baseado em indivíduos
Este repositório é um material suplementar do texto "Uma abordagem geométrica da estabilidade local em dinâmicas discretas com aplicação em um modelo de cooperação", aqui está o código referente às simulações computacionais do modelo apresentado, utilizado para gerar a figura 7, na qual estas simulações são justapostas às equações mestras. Esse código está dividido nas seguintes partes:
* Parâmetros
* Estruturação dos dados
* IBM
* Equações Mestras

Para a repetibilidade de aleatorizações inclua o comando set.seed(x) no começo do código, onde x é uma variável numérica.
## Parâmetros
Esta é a única parte do código que deve ser alterada para obter o mesmo sistema de referência. Nela estão os parâmetros utilizados no modelo.

**total_time** <- passos de tempo ou iterações 

**N** <- tamanho da população 

**C0** <- Densidade inicial de Cooperadores, os demais indivíduos serão Desertores na condição inicial

**repetitions** <- número de repetições da simulação desejadas

Adicionalmente a função **set.seed()** pode ser incluída caso deseje replicar alguma randomização específica

# Estruturação dos Dados
Nesta parte do código é gerado um dataframe de N linhas, chamado **individuals_data** que abrigará todas as informações referentes a cada indivíduo no sistema. Ao longo das iterações esses dados serão atualizados, conforme novos indivíduos aparecem e morrem, e esse dataframe alimentará o output da simulação que consiste nas observaçãoes feitas a cada passo de tempo.

#IBM
Essa parte do código consiste nas simulações do modelo em si, visualizações dessas simulações feitas no R base (funções **plot()** e **points()**) e salva o output gerado (**write.csv**) para que ele possa ser utilizado em outros códigos e não precise ser gerado mais de uma vez. 

#Equações Mestras
Como um adendo, essa parte do código itera as equações mestras sob os mesmos parâmetros e plota sua evolução junto ao gráfico das simulações, que permite a comparação do comportamento previsto pelas equações com as simulações computacionais.
  
