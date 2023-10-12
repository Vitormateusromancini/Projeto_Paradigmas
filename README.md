# Projeto Paradigmas

O seguinte projeto é um trabalho da disciplina de paradgmas de programação na Universidade Federal de Santa Maria, o qual os discentes tinham que escolher um tema de projeto e uma linguagem de programação.	
A proposta de produção individual será de um Mini Banco de dados de Livros e Filmes que recomendará entre um filme ou um livro para o usuário e a linguagem utilizada será Haskell. A partir de agora será explicado o código realizado pelo aluno Vitor Mateus Romancini do Amaral. 
Link para o screencast: https://www.loom.com/share/a92da626c8934689b963d662b4101402?sid=562224d4-2048-4072-98e3-f7dc769570b8

```haskell
import System.Random
import Data.Char (toLower) 
```
O código começa com a importação de bibliotecas necessárias. A biblioteca System.Random em Haskell fornece funcionalidades para geração de números aleatório e  função utilizada nesta biblioteca é randomRIO, que é usada para gerar números inteiros aleatórios em um intervalo especificado. Neste código, a função randomRIO (0, length lista - 1) é usada para escolher aleatoriamente um índice em uma lista.

A biblioteca Data.Char em Haskell fornece funções para manipular caracteres e cadeias de caracteres. Neste código, a função toLower da biblioteca Data.Char é usada para converter caracteres em minúsculas antes de compará-los. Isso é feito para tornar a comparação de gêneros de filme/livro insensível a maiúsculas/minúsculas.

```haskell
type Title = String
type Genre = String
type Film = (Title, Genre)
type Book = (Title, Genre)

testFilmDatabase :: [Film]
testFilmDatabase =
    [ ("Casino Royale", "Action"),
      ("Cowboys & Aliens", "Action"),
      ("Catch Me If You Can", "Crime"),
      ("The Dark Knight", "Action"),
      ("Inception", "Sci-Fi"),
      ("The Shawshank Redemption", "Drama"),
      ("Pulp Fiction", "Crime"),
      ("Forrest Gump", "Drama"),.....]

testBookDatabase :: [Book]
testBookDatabase =
    [ ("Dom Casmurro", "Romance"),
      ("A Máquina do Tempo", "Ficção Científica"),
      ("A Metamorfose", "Ficção Científica"),
      ("Os Miseráveis", "Clássico"),
      ("O Pequeno Príncipe", "Fantasia"),
      ("O Alquimista", "Ficção Inspiracional"),
      ("Cem Anos de Solidão", "Realismo Mágico"),
      ("1984", "Distopia"),...]
```


```haskell
gerarRecomendacao :: String -> [Film] -> [Book] -> IO (String, String)
```
Ela recebe três argumentos: uma string que é a preferência do usuário, filmes (uma lista de filmes) e livros (uma lista de livros). A função retorna uma ação de IO que produz uma tupla de duas strings, representando a recomendação de filme e livro.

```haskell
    putStrLn "Você deseja uma recomendação de filme (F) ou livro (L)?"
```
 Esta linha exibe uma mensagem ao usuário perguntando se ele deseja uma recomendação de filme ou livro. A função putStrLn é usada para imprimir uma linha de texto no console.
```haskell
escolha <- getLine
```
Esta linha lê a entrada do usuário do console usando getLine e a armazena na variável escolha. O usuário deve inserir "F" para filme ou "L" para livro.


```haskell
case map toLower escolha of
        "f" -> gerarRecomendacaoFilme preferencia filmes
        "l" -> gerarRecomendacaoLivro preferencia livros
        _   -> return ("Escolha inválida.", "")
```
Esta é uma estrutura de seleção case. Ela verifica o valor da variável escolha após converter tudo para letras minúsculas (usando map toLower). Isso garante que a comparação não seja sensível a maiúsculas/minúsculas. Se o valor for "f", a função gerarRecomendacaoFilme é chamada, passando a preferência do usuário e a lista de filmes. Isso resulta na geração de uma recomendação de filme. Se o valor for "l", a função gerarRecomendacaoLivro é chamada, passando a preferência do usuário e a lista de livros. Isso resulta na geração de uma recomendação de livro. caso o valor não for nem "f" nem "l", a função return é usada para retornar uma tupla com uma mensagem de "Escolha inválida." para ambos os campos da recomendação.

```haskell
gerarRecomendacaoFilme :: String -> [Film] -> IO (String, String)
gerarRecomendacaoFilme preferencia filmes = do
    let filmesFiltrados = filter (\(_, genero) -> map toLower genero `contains` map toLower preferencia) filmes
    if null filmesFiltrados
        then return ("Não encontramos nenhuma recomendação de filme com base no gênero de sua preferência.", "")
        else do
            (titulo, genero) <- escolherAleatorio filmesFiltrados
            return (titulo, genero)
```
A função recebe dois argumentos: preferencia (a preferência do usuário) e filmes (uma lista de filmes). A função retorna uma ação de IO que produz uma tupla de duas strings, representando a recomendação de filme (título e gênero). 

A linha let filmesFiltrados filtra a lista de filmes com base na preferência do usuário utilizando a função filter para manter apenas os filmes cujo gênero (convertido para minúsculas) contenha a preferência (também convertida para minúsculas). Isso cria uma nova lista chamada filmesFiltrados.

Na estrutura condicional  verifica se a lista filmesFiltrados está vazia. Se estiver vazia, significa que não há filmes que correspondam à preferência do usuário. Nesse caso, a função return é usada para retornar uma mensagem de que nenhuma recomendação foi encontrada. Mas caso a lista não estiver vazia com o else do é usada para executar a seguinte ação abaixo:


```haskell
(titulo, genero) <- escolherAleatorio filmesFiltrados
            return (titulo, genero)
```

Esta linha chama a função escolherAleatorio para escolher aleatoriamente um filme da lista filmesFiltrados. Ela desestrutura a tupla retornada em (titulo, genero), onde titulo é o título do filme e genero é o gênero do filme escolhido aleatoriamente.

A função return é usada para retornar uma tupla contendo o título e o gênero do filme recomendado

```haskell
gerarRecomendacaoLivro :: String -> [Book] -> IO (String, String)
gerarRecomendacaoLivro preferencia livros = do
    let livrosFiltrados = filter (\(_, genero) -> map toLower genero `contains` map toLower preferencia) livros
    if null livrosFiltrados
        then return ("Não encontramos nenhuma recomendação de livro com base no gênero de sua preferência.", "")
        else do
            (titulo, genero) <- escolherAleatorio livrosFiltrados
            return (titulo, genero)
```
Esta função é parecida com a outra discutida anteriormente, a diferença é que ela gera uma recomendação de livro com base nos gêneros de preferência do usuário.

```haskell
escolherAleatorio :: [(String, String)] -> IO (String, String)
escolherAleatorio lista = do
    indice <- randomRIO (0, length lista - 1)
    return (fst (lista !! indice), snd (lista !! indice))
```
Nesta função recebe uma lista de tuplas contendo duas strings (títulos e gêneros de filmes) e retorna uma ação de IO que produz uma tupla de duas strings (um título e um gênero).
```haskell
indice <- randomRIO (0, length lista - 1): 
```
Esta linha gera um número inteiro aleatório entre 0 e o tamanho da lista menos 1. A função randomRIO é usada para isso e retorna um número aleatório encapsulado em uma ação de IO. O resultado desse número aleatório é armazenado na variável indice.

E no fim a linha return retorna uma tupla com os valores correspondentes ao índice aleatório gerado na lista de tuplas. A função fst extrai o primeiro elemento da tupla (o título) e snd extrai o segundo elemento (o gênero) do par selecionado aleatoriamente.
```haskell
contains :: Eq a => [a] -> [a] -> Bool
contains [] _ = True
contains _ [] = False
contains (x:xs) (y:ys)
    | x == y    = contains xs ys
    | otherwise = contains (x:xs) ys
```
A função genérica que pode trabalhar com listas de qualquer tipo a, desde que esse tipo seja comparável (ou seja, pertença à classe Eq). Ela recebe duas listas e retorna um valor booleano (True se a primeira lista contém a segunda, caso contrário False).


Contains [] _ = True: é a primeira cláusula da função e lida com o caso em que a primeira lista está vazia ([]). Nesse caso, a função retorna True independentemente do conteúdo da segunda lista, isso significa que uma lista vazia sempre "contém" outra lista (vazia ou não).

contains _ [] = False: Esta é a segunda cláusula da função e lida com o caso em que a segunda lista está vazia ([]). Nesse caso, a função retorna False, pois uma lista não pode conter outra lista se a segunda estiver vazia.
```haskell
contains (x:xs) (y:ys)
    | x == y    = contains xs ys
    | otherwise = contains (x:xs) ys
```
Na primeira linha do código é a terceira cláusula da função e lida com o caso em que ambas as listas têm pelo menos um elemento verificando se o primeiro elemento (x) da primeira lista é igual ao primeiro elemento (y) da segunda lista. Se forem iguais, a função continua verificando os elementos restantes das duas listas chamando recursivamente a função contains com as caudas das listas (ou seja, xs e ys).

E o otherwise = contains (x:xs) ys: tem como função analisar se os primeiros elementos das listas não forem iguais, esta cláusula é acionada (otherwise significa "caso contrário"). Nesse caso, a função continua verificando se a primeira lista ((x:xs)) contém a segunda lista (ys) ignorando o primeiro elemento da primeira lista (x) e mantendo a segunda lista inalterada.
```haskell
main :: IO ()
main = do
    putStrLn "Bem-vindo ao sistema de recomendação de filmes e livros!"
    putStrLn "Por favor, insira o gênero de filme ou livro que você deseja:"
    genero <- getLine
    (titulo, generoRecomendado) <- gerarRecomendacao genero testFilmDatabase testBookDatabase
    putStrLn "Recomendação:"
    putStrLn ("Título: " ++ titulo)
    putStrLn ("Gênero: " ++ generoRecomendado)
```

Por fim esta funçao é a função principal do código main :: IO () que está configurada para realizar ações de entrada e saída (IO). Os putStrLn  vão exibir as mensagensescritas neles, além de o genero <- getLine: que lê a entrada do usuário (o gênero desejado) do console e a armazena na variável genero.  O mesmo acontecendo com a função genero <- getLine: esta linha lê a entrada do usuário (o gênero desejado) do console e a armazena na variável genero.
O testBookDatabase retorna uma tupla contendo o título e o gênero da recomendação gerada com base na preferência do usuário.
Vale ressaltar para as duas últimas linhas que exibem o título de recomendação junto com o gênero da recomendação. 

Sobre o trabalho foi bem desafiador usar a linguagem haskell comparado a Prolog já que eu não tinha mexido ainda com a linguagem com relação escolher aleatoriamente uma string numa lista. O principal desafio em questão foi resolver um problema de importação de biblioteca que foi resolvida com auxílio da professora. 

Referências:

Biblioteca System.Random: https://hackage.haskell.org/package/random-1.2.1.1/docs/System-Random.html
Inf UFPR: https://www.inf.ufpr.br/andrey/ci062/ProgramacaoHaskell.pdf
DECOM - UFOP: http://www.decom.ufop.br/romildo/2018-1/bcc222/slides/progfunc.pdf
UFMG: https://homepages.dcc.ufmg.br/~camarao/fp/haskell.pdf
