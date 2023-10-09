# Projeto Paradigmas

O seguinte projeto é um trabalho da disciplina de paradgmas de programação na Universidade Federal de Santa Maria, o qual os discentes tinham que escolher um tema de projeto e uma linguagem de programação.	
A proposta de produção individual será de um Mini Banco de dados de Livros e Filmes que recomendará entre um filme e um livro para o usuário e a linguagem utilizada será Haskell. A partir de agora será explicado o código realizado pelo aluno Vitor Mateus Romancini do Amara. 

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
Esta é uma estrutura de seleção case. Ela verifica o valor da variável escolha após converter tudo para letras minúsculas (usando map toLower). Isso garante que a comparação não seja sensível a maiúsculas/minúsculas e caso o valor não for nem "f" nem "l", a função return é usada para retornar uma tupla com uma mensagem de "Escolha inválida." para ambos os campos da recomendação.
