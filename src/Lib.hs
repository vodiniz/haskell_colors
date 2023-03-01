module Lib where

import Data.Maybe


{- 
Para todos os exercícios, você pode criar funções
auxiliares se achar conveniente. Não se esqueça de dar
nome aos parâmetros que for utilizar.

Considere o seguinte tipo de dado algébrico
que representa 4 cores.
-}

data Color = Red | Green | Blue | Yellow
            deriving (Eq)

-- Exemplo de valor
-- c1 :: Color
-- c1 = Yellow

{-
Red será "R", Green será "G", e assim por diante.

Exercício 1: Instância de Show.
-}

instance Show Color where
    show Red    = "R"
    show Green  = "G"
    show Blue   = "B"
    show Yellow = "Y"

{-
Tabuleiro de cores. Este "tabuleiro" não necessariamente é
uma matriz quadrada.
-}



--IMPLEMENTAR INSTANCIA DE SHOW PARA O BOARD

type Board = [[Color]]

-- Exemplo de tabuleiro
-- t1 :: Board
-- t1 = [[Red, Blue, Blue, Green], [Yellow, Red], [Blue, Green, Red]]

{-
Exercício 2: 

Trocar todas as ocorrências da primeira
cor no tabuleiro pela segunda cor, mantendo todas 
as outras cores inalteradas.
-}


replaceColor :: Color -> Color -> Color -> Color
replaceColor from to element
    | element == from = to
    | otherwise = element

replace :: Color -> Color -> [Color] -> [Color]
-- fmap :: Functor [] => (Color -> Color) -> [Color] -> [Color]
replace from to = fmap (replaceColor from to)



fill :: Color -> Color -> Board -> Board
-- removed board from arguments
fill from to = fmap (replace from to)


{-
Exercício 3: Implemente a seguinte função que deve 
retornar o número de ocorrências de uma cor no tabuleiro.
-}

--Conta as cores em uma lista simples de cor
count :: Color -> [Color] -> Int
count x xs = length (filter ( == x) xs)


-- Conta as cores em uma lista simples e retorna uma lista 
-- com o numero de cores que aparece em cada linha do tabuleiro
countColorList :: Color -> Board -> [Int]
countColorList color = fmap (count color)


-- soma a ocorrencia das cores em cada linha
countColor :: Color -> Board -> Int
countColor color board = sum (countColorList color board)

{-
Exercício 4: 
Converter uma letra na cor correspondente. Estaremos 
considerando a possibilidade do caractere informado
não representar uma cor.
-}

readColor :: Char -> Maybe Color
readColor color
    | color =='R' = Just Red
    | color =='G' = Just Green
    | color =='B' = Just Blue
    | color =='Y' = Just Yellow
    | otherwise = Nothing

{-
Exercício 5: 
Converter uma sequência de caracteres numa lista de 
possíveis cores correspondentes.
-}

readColors :: String -> [Maybe Color]
readColors = fmap readColor

-- readColors "BBHYGB" ~= [Just B, Just B, Nothing, Just Y, Just G, Just B] 

{-
Exercício 6: Implemente a seguinte função que deve converter
uma lista de sequências de caracteres num tabuleiro de possíveis
cores.
-}


readColorLines :: [String] -> [[Maybe Color]]
readColorLines = fmap readColors

{- 
    readColorLines ["BBHYGB", "JYG", "BKKGBGY"]
       ~= [[Just B,Just B,Nothing,Just Y,Just G,Just B],
           [Nothing,Just Y,Just G],
           [Just B,Nothing,Nothing,Just G,Just B,Just G,Just Y]]
-}

{-
Exercício 7: 
Converter um tabuleiro de possíveis cores
 em um tabuleiro comum, simplesmente
eliminando todas as cores invalidadas no processo.
-}

-- maybeColorToList :: Maybe Color -> [Color]
-- maybeColorToList = maybeToList
maybeListToList :: [Maybe Color] -> [Color]
--  concat . fmap maybeToList
maybeListToList = catMaybes



createBoard :: [[Maybe Color]] -> Board
createBoard = fmap maybeListToList

{-
    createBoard (readColorLines ["BBHYGB", "JYG", "BKKGBGY"])
        ~= [[B,B,Y,G,B],
            [Y,G],
            [B,G,B,G,Y]]
-}

{-
Exercício 8:
lê um número n digitado do teclado e depois lê n linhas
, retornando-as em uma lista.
-}


--fmap de readColorLines fazendo um SUM ao mesmo tempo para retornar uma lista de string

readNLines :: Int -> IO [String]
readNLines n
    | n <= 0 = return []
    | otherwise = do
        x <- getLine
        xs <- readNLines (n-1)
        return (x:xs)



readLines :: IO [String]
readLines = do
    line <- getLine
    let numLines = read line :: Int
    readNLines numLines

{-
Exercício 9: mostra na tela a contagem de cada uma das cores,
 exibindo inclusive as cores
cuja contagem for zero.
-}


--FILL PODE SER UMA COR DINAMICA ESCOLHIDA PELO USUARIO

printCounters :: Board -> IO ()
printCounters board = do
    
    putStr $ show Red ++" : "
    print $ countColor Red board

    putStr $ show Green ++ " : "
    print $ countColor Green board

    putStr $ show Blue ++ " : "
    print $ countColor Blue board

    putStr $ show Yellow ++ " : "
    print $ countColor Yellow board
    


{- 
Exercício 10: Vá ao arquivo Main.hs e faça o que se pede.
-}