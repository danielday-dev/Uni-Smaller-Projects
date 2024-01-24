--
-- MATHFUN
-- Template for the Haskell assignment program (replace this comment)
-- Add your student number
-- UP2018443

--
-- Imports
--

import Text.Printf
import Control.Concurrent (threadDelay)

--
-- Types (define your Station type here)
--

type Station = (String, (Float, Float), [Float])
-- type Station = (String, Float, Float, [Float])


testData :: [Station]
testData = [
    
    ("Mumbles Head",
    (51.565, -3.981),
    [8.26, 8.33, 9.84, 12.36, 15.24, 17.83, 19.55, 19.67, 17.97, 14.70, 11.49, 9.09]),
    
    ("Greenwich Park",
    (51.477, 0.004),
    [8.47, 9.21, 12.07, 15.35, 18.59, 21.37, 23.75, 23.31, 20.29, 15.83, 11.55, 8.85]),

    ("Solent",
    (50.807, -1.208),
    [8.56, 8.74, 11.01, 13.94, 17.07, 19.59, 21.62, 21.61, 19.38, 15.73, 11.88, 9.17]),

    ("Ronaldsway",
    (54.085, -4.632),
    [8.47, 8.35, 9.44, 11.48, 14.33, 16.52, 18.19, 18.15, 16.56, 13.83, 11.10, 9.17]),

    ("Baltasound",
    (60.749, -0.850),
    [6.55, 6.32, 7.35, 9.16, 11.20, 13.25, 15.08, 15.39, 13.62, 10.88, 8.47, 7.00]),

    ("St Austell",
    (50.337, -4.787),
    [9.46, 9.65, 11.33, 13.30, 16.18, 18.10, 20.60, 20.36, 18.54, 14.99, 12.30, 10.18]),

    ("Heathrow",
    (51.479, -0.449),
    [8.42, 8.98, 11.73, 15.00, 18.37, 21.57, 23.89, 23.40, 20.22, 15.81, 11.47, 8.79]),

    ("Hunstanton",
    (52.939, 0.493) ,
    [7.05, 7.45, 9.77, 12.65, 15.96, 18.84, 21.34, 21.28, 18.32, 14.46, 10.29, 7.56]),

    ("Durham",
    (54.767, -1.583),
    [6.86, 7.75, 9.87, 12.49, 15.42, 17.96, 20.24, 19.87, 17.36, 13.51, 9.65, 7.07]),

    ("Monks Wood",
    (52.400, -0.233),
    [7.58, 8.36, 11.05, 14.14, 17.19, 20.01, 22.63, 22.49, 19.50, 15.18, 10.68, 7.85])
        
    ]


--
--  Your functional code goes here
--

-- i
outputStationNames :: [Station] -> [String]
outputStationNames [] = []
outputStationNames stationList = [name | (name, _, _) <- stationList]

-- ii
-- addStation :: [Station] -> String -> Float -> Float -> [Float] -> [Station]
addStation :: [Station] -> Station -> [Station]
addStation stationList (name, location, values)
    | length values == 12 = (name, location, values):stationList  
    | otherwise = stationList

-- iii
dataToFahrenheit :: [Station] -> [Station]
dataToFahrenheit [] = []
dataToFahrenheit stationList = [(name, location, map toFahrenheit values) | (name, location, values) <- stationList]

toFahrenheit :: Float -> Float
toFahrenheit x = (x+32)*1.8

-- iv
higherTemp :: [Station] -> Int -> Float -> [String]
higherTemp [] _ _ = []
higherTemp stationList month temp = [name | (name, _, values) <- stationList, values!!(month-1) > temp]

-- v
-- Return all the data as a single string which, when output using putStr, will display the
-- data formatted neatly into a table of 15 columns giving the name, location (degrees
-- N & E formatted to 1 decimal place), and the 12 temperature values (from January to
-- December each formatted to 1 decimal place).

dataToString :: [Station] -> String
dataToString stationList = printf "| % 15s | % 5s | % 5s" "Name" "N" "E" ++ foldl (\b month -> b ++ printf "% 5s |" month) "|" months ++ "\n" ++ table 
    where 
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        table = foldl (\b v -> b ++ createRow v ++ "\n") "" stationList 

createRow :: Station -> String
createRow (name, (n, e), values) = printf "| % 15s | % 5.1f | % 5.1f" name n e ++ foldl (\b value -> b ++ printf "% 5.1f |" value) "|" values

-- vi
replaceNth :: [a] -> Int -> a -> [a]
replaceNth [] _ _ = []
replaceNth (x:xs) 0 value = value: xs
replaceNth (x:xs) index value = x: replaceNth xs (index-1) value

replaceTemp :: [Station] -> String -> Int -> Float -> [Station]
replaceTemp [] _ _ _ = []
replaceTemp ((name, location, values):stations) searchName month temp 
    | name == searchName = (name, location, (replaceNth values (month-1) temp)):replaceTemp stations searchName month temp
    | otherwise = (name, location, values):replaceTemp stations searchName month temp

-- vii
-- Given a location (N and E figures), a month and a temperature value, return the name
-- of the closest weather station with a higher temperature for that month, or “none”
-- if no such station exists; use Pythagoras’ theorem to calculate the distance between
-- locations (i.e. assume the world is flat!)

calcDistance :: (Float, Float) -> (Float, Float) -> Float
calcDistance (n1, e1) (n2, e2) = sqrt ((n1 - n2)^2+(e1 - e2)^2)

nearestStation :: [Station] -> (Float, Float) -> Int -> Float -> String
nearestStation [] _ _ _ = "none"
nearestStation stationList location2 month temp 
    | array == [] = "none"
    | otherwise = fst (findMinimumDistance array)

    where array = [(name, calcDistance location location2) | (name, location, temps) <- stationList, temps!!(month-1) > temp] 

findMinimumDistance :: [(String, Float)] -> (String, Float)
findMinimumDistance ((an, ad):xs) 
    | xs == [] = (an, ad)
    | ad <= bd = (an, ad)
    | otherwise = (bn, bd)
    where (bn, bd) = findMinimumDistance xs

--
--  Demo
--

demo :: Int -> IO ()
demo 1 = putStrLn (show (outputStationNames testData))
demo 2 = putStrLn (dataToString (addStation testData ("Valley", (53.252, (-4.537)), [8.37, 8.44, 9.84, 12.09, 15.01, 17.24, 18.77, 18.76, 17.26, 14.31, 11.26, 9.09])))
demo 3 = putStrLn (dataToString (dataToFahrenheit testData))
demo 4 = putStrLn (show (higherTemp testData 8 20))
demo 5 = putStrLn (dataToString testData)
demo 6 = putStrLn (dataToString (replaceTemp testData "Heathrow" 7 25) )
demo 7 = putStrLn (nearestStation testData (50.2, -0.4) 3 10)
demo 8 = barChart testData 1

--
-- Screen Utilities (use these to do the bar chart)
--

type ScreenPosition = (Int,Int)

-- Clears the screen
clearScreen :: IO ()
clearScreen = putStr "\ESC[2J"

-- Moves to a position on the screen
goTo :: ScreenPosition -> IO ()
goTo (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

-- Writes a string at a position on the screen
writeAt :: ScreenPosition -> String -> IO ()
writeAt position text = do
    goTo position
    putStr text

--
-- Your bar chart code goes here
--

barChart :: [Station] -> Int -> IO ()
barChart _ 13 = return ()
barChart stationList month = do
    clearScreen
    goTo (0,0)
    putStrLn (printf "| % 15s | % -30s" "Name" "Degrees (# = 1°C)")
    putStrLn (drawChart stationList month)
    threadDelay 1000000
    barChart stationList (month+1)

drawChart :: [Station] -> Int -> String
drawChart stationList month =  foldl (\ b station -> b ++ (drawRow station month)) "" stationList 

drawRow :: Station -> Int -> String
drawRow (name, _ , values) month = printf "| % 15s | % -30s\n" name (replicate (round (values!!(month-1))) '#') 

--
-- Your user interface (and loading/saving) code goes here
--

listToString :: [String] -> String
listToString [] = ""
listToString (x:xs) = x ++ "\n" ++ (listToString xs)

getInt :: IO Int
getInt = do 
    str <- getLine
    return (read str :: Int)
    
getFloat :: IO Float
getFloat = do 
    str <- getLine
    return (read str :: Float)

save :: [Station] -> IO ()
save stationList = do 
    writeFile "stations.txt" (show stationList)

load :: IO ([Station])
load = do
    stationList <- readFile "stations.txt"
    return (read stationList :: [Station])

main :: IO ()
main = do
    stationList <- load
    putStrLn (listToString (outputStationNames stationList)) 
    stationList <- recursiveChoice stationList
    save stationList

run :: String -> [Station] -> IO ([Station])
run "1" stationList = do
    putStrLn (listToString (outputStationNames stationList))
    return stationList
run "2" stationList = do
    putStrLn "added successfully"
    return (addStation stationList ("Valley", (53.252, (-4.537)), [8.37, 8.44, 9.84, 12.09, 15.01, 17.24, 18.77, 18.76, 17.26, 14.31, 11.26, 9.09]))
run "3" stationList = do
    putStrLn (dataToString (dataToFahrenheit stationList))
    return stationList
run "4" stationList = do
    putStrLn "Please enter which month"
    month <- getInt
    putStrLn "Please enter which month"
    month <- getInt
    putStrLn "Please enter which month"
    month <- getInt
    putStrLn "Please enter which month"
    month <- getInt
    putStrLn "Please enter which month"
    month <- getInt
    putStrLn "Please enter which temperature you would like to check"
    temp <- getFloat
    if month >= 1 && month <= 12 
        then do putStrLn (listToString (higherTemp stationList month temp)) 
        else do putStrLn "Invalid Month"
    return stationList
run "5" stationList = do
    putStrLn (dataToString stationList)
    return stationList
run "6" stationList = do
    putStrLn ("data updated")
    return (replaceTemp testData "Heathrow" 7 25)
run "7" stationList = do
    putStrLn (nearestStation testData (50.2, -0.4) 3 10)
    return stationList
run "8" stationList = do
    barChart stationList 1
    return stationList
run _ stationList = do
    putStrLn "invalid input"
    return stationList

recursiveChoice ::[Station] -> IO ([Station])
recursiveChoice stationList = do
    putStrLn ("Option 1 - List Station Names")
    putStrLn ("Option 2 - Add New Station")
    putStrLn ("Option 3 - Display Fahrenheit")
    putStrLn ("Option 4 - Show Higher temperatures")
    putStrLn ("Option 5 - Display Table")
    putStrLn ("Option 6 - Replace Temperature")
    putStrLn ("Option 7 - Find Closest Station")
    putStrLn ("Option 8 - Display Bar Chart Animation")
    putStrLn ("Option 9 - Quit")
    choice <- getLine
    clearScreen
    goTo (0,0)
    if choice /= "9" 
        then do 
            stationList <- run choice stationList
            getLine
            stationList <- recursiveChoice stationList
            return stationList 
        else do return stationList
    
    