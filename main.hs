import System.Random
import Data.Char (toLower)

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
      ("Forrest Gump", "Drama"),
      ("Fight Club", "Drama"),
      ("The Godfather", "Crime"),
      ("The Matrix", "Sci-Fi"),
      ("The Silence of the Lambs", "Thriller"),
      ("Gladiator", "Action"),
      ("Se7en", "Crime"),
      ("Memento", "Mystery"),
      ("The Departed", "Crime"),
      ("The Lord of the Rings: The Return of the King", "Fantasy"),
      ("The Prestige", "Mystery"),
      ("The Social Network", "Drama"),
      ("The Revenant", "Adventure"),
      ("Inglourious Basterds", "War"),
      ("Django Unchained", "Western"),
      ("Goodfellas", "Crime"),
      ("American Beauty", "Drama"),
      ("The Green Mile", "Drama"),
      ("American History X", "Drama"),
      ("Saving Private Ryan", "War"),
      ("Schindler's List", "Biography"),
      ("The Godfather: Part II", "Crime"),
      ("The Lord of the Rings: The Fellowship of the Ring", "Fantasy"),
      ("The Lord of the Rings: The Two Towers", "Fantasy")
      ("The Grand Budapest Hotel", "Comedy"),
      ("Avatar", "Sci-Fi"),
      ("Jurassic Park", "Adventure"),
      ("The Avengers", "Action"),
      ("Forrest Gump", "Drama"),
      ("The Pursuit of Happyness", "Drama"),
      ("The Martian", "Sci-Fi"),
      ("Interstellar", "Sci-Fi"),
      ("A Beautiful Mind", "Drama"),
      ("The Shawshank Redemption", "Drama"),
      ("The Wolf of Wall Street", "Crime"),
      ("Eternal Sunshine of the Spotless Mind", "Romance"),
      ("The Lion King", "Animation"),
      ("Finding Nemo", "Animation"),
      ("Schindler's List", "Biography"),
      ("The Great Gatsby", "Drama"),
      ("No Country for Old Men", "Crime"),
      ("Spirited Away", "Animation"),
      ("Avatar", "Sci-Fi"),
      ("The Matrix Reloaded", "Sci-Fi"),
      ("The Matrix Revolutions", "Sci-Fi"),
      ("Inglourious Basterds", "War"),
      ("The Hateful Eight", "Western"),
      ("The Dark Knight Rises", "Action"),
      ("The Hobbit: An Unexpected Journey", "Fantasy"),
      ("The Hobbit: The Desolation of Smaug", "Fantasy"),
      ("The Hobbit: The Battle of the Five Armies", "Fantasy"),
      ("The Avengers: Age of Ultron", "Action"),
      ("The Avengers: Infinity War", "Action"),
      ("The Avengers: Endgame", "Action"),
      ("Forrest Gump", "Drama"),
      ("The Social Network", "Drama"),
      ("A Beautiful Mind", "Drama"),
      ("The Green Mile", "Drama"),
      ("Schindler's List", "Biography"),
      ("The Godfather: Part II", "Crime"),
      ("The Lord of the Rings: The Fellowship of the Ring", "Fantasy"),
      ("The Lord of the Rings: The Two Towers", "Fantasy"),
      ("The Lord of the Rings: The Return of the King", "Fantasy")]


testBookDatabase :: [Book]
testBookDatabase =
    [ ("Dom Casmurro", "Romance"),
      ("A Máquina do Tempo", "Ficção Científica"),
      ("A Metamorfose", "Ficção Científica"),
      ("Os Miseráveis", "Clássico"),
      ("O Pequeno Príncipe", "Fantasia"),
      ("O Alquimista", "Ficção Inspiracional"),
      ("Cem Anos de Solidão", "Realismo Mágico"),
      ("1984", "Distopia"),
      ("Crime e Castigo", "Romance"),
      ("A Guerra dos Tronos", "Fantasia"),
      ("Harry Potter e a Pedra Filosofal", "Fantasia"),
      ("O Código Da Vinci", "Mistério"),
      ("A Sangue Frio", "Não-Ficção"),
      ("O Apanhador no Campo de Centeio", "Ficção"),
      ("O Nome do Vento", "Fantasia"),
      ("Moby Dick", "Aventura"),
      ("A Revolução dos Bichos", "Fábula"),
      ("O Senhor das Moscas", "Ficção Distópica"),
      ("Ulisses", "Clássico"),
      ("O Coração das Trevas", "Ficção"),
      ("Em Busca do Tempo Perdido", "Romance"),
      ("A Divina Comédia", "Poesia Épica"),
      ("A Iliada", "Poesia Épica"),
      ("A Odisséia", "Poesia Épica"),
      ("As Crônicas de Nárnia", "Fantasia"),
      ("O Senhor dos Anéis: As Duas Torres", "Fantasia"),
      ("O Labirinto dos Espíritos", "Mistério"),
      ("A Sombra do Vento", "Mistério"),
      ("Sapiens: Uma Breve História da Humanidade", "Não-Ficção"),
      ("A Revolta de Atlas", "Ficção"),
      ("A Estrada", "Ficção Distópica"),
      ("O Médico", "Histórico"),
      ("O Rouxinol", "Ficção Histórica"),
      ("As Cinzas de Angela", "Biografia"),
      ("O Sol é para Todos", "Ficção Histórica"),
      ("O Diário de Anne Frank", "Diário"),
      ("O Poder do Hábito", "Autoajuda"),
      ("Mentes Brilhantes, Mentes Treinadas", "Psicologia"),
      ("A Arte da Guerra", "Filosofia"),
      ("O Livro de Ouro da Mitologia", "Mitologia"),
      ("O Homem em Busca de Sentido", "Psicologia"),
      ("Pai Rico, Pai Pobre", "Finanças Pessoais"),
      ("A Cabana", "Ficção Inspiracional"),
      ("Comer, Rezar, Amar", "Biografia"),
      ("O Grande Gatsby", "Clássico"),
    ]


-- Função para gerar uma recomendação com base nos gêneros de preferência do usuário
gerarRecomendacao :: String -> [Film] -> [Book] -> IO (String, String)
gerarRecomendacao preferencia filmes livros = do
    putStrLn "Você deseja uma recomendação de filme (F) ou livro (L)?"
    escolha <- getLine
    case map toLower escolha of
        "f" -> gerarRecomendacaoFilme preferencia filmes
        "l" -> gerarRecomendacaoLivro preferencia livros
        _   -> return ("Escolha inválida.", "")

-- Função para gerar uma recomendação de filme com base nos gêneros de preferência do usuário
gerarRecomendacaoFilme :: String -> [Film] -> IO (String, String)
gerarRecomendacaoFilme preferencia filmes = do
    let filmesFiltrados = filter (\(_, genero) -> map toLower genero `contains` map toLower preferencia) filmes
    if null filmesFiltrados
        then return ("Não encontramos nenhuma recomendação de filme com base no gênero de sua preferência.", "")
        else do
            (titulo, genero) <- escolherAleatorio filmesFiltrados
            return (titulo, genero)

-- Função para gerar uma recomendação de livro com base nos gêneros de preferência do usuário
gerarRecomendacaoLivro :: String -> [Book] -> IO (String, String)
gerarRecomendacaoLivro preferencia livros = do
    let livrosFiltrados = filter (\(_, genero) -> map toLower genero `contains` map toLower preferencia) livros
    if null livrosFiltrados
        then return ("Não encontramos nenhuma recomendação de livro com base no gênero de sua preferência.", "")
        else do
            (titulo, genero) <- escolherAleatorio livrosFiltrados
            return (titulo, genero)

-- Função auxiliar para escolher aleatoriamente um item de uma lista
escolherAleatorio :: [(String, String)] -> IO (String, String)
escolherAleatorio lista = do
    indice <- randomRIO (0, length lista - 1)
    return (fst (lista !! indice), snd (lista !! indice))

-- Função auxiliar para verificar se uma string contém outra
contains :: Eq a => [a] -> [a] -> Bool
contains [] _ = True
contains _ [] = False
contains (x:xs) (y:ys)
    | x == y    = contains xs ys
    | otherwise = contains (x:xs) ys

-- Função principal
main :: IO ()
main = do
    putStrLn "Bem-vindo ao sistema de recomendação de filmes e livros!"
    putStrLn "Por favor, insira o gênero de filme ou livro que você deseja:"
    genero <- getLine
    (titulo, generoRecomendado) <- gerarRecomendacao genero testFilmDatabase testBookDatabase
    putStrLn "Recomendação:"
    putStrLn ("Título: " ++ titulo)
    putStrLn ("Gênero: " ++ generoRecomendado)
