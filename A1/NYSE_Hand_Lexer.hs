module Main where

import Network.HTTP
import Data.List

type Name       = String 
type Symbol     = String
type PercentChn = Float
type Volume     = Integer

data Token =   ProfitStock Name Symbol PercentChn Volume
             | LossStock Name Symbol PercentChn Volume
             | NoChange  Name Symbol Volume
             deriving (Eq,Show)


-- take raw company data and determine what kind of stock it is.
processRawCompData :: [String] -> Token
processRawCompData attrs 
        | perChange == 0 = NoChange  name symbol volume  
        | perChange > 0  = ProfitStock name symbol perChange volume
        | perChange < 0  = LossStock name symbol perChange volume   
    where
        rattrs    = reverse attrs
        perChange = read ((filter (/= '+').init) (rattrs !! 1))::Float
        symbol    = rattrs !! 4
        volume    = (read.filter ( /= ',')) (rattrs !! 0)
        name      = (intercalate " ".reverse.drop 6) rattrs


generateRawData :: String -> [[String]]
generateRawData = map words.init.tail.lines

main = do
    conts <- readFile "table.txt"
    let rawData = generateRawData conts
    --mapM_ (putStrLn.show) rawData
    mapM_ (putStrLn.show) $  map processRawCompData rawData

{-    
*Main> main
["Bank","of","America","BAC","BAC","+0.0823.00","+0.08","+0.35%","161,930,864"]
["Fmc","Technologies","FTI","FTI","-0.1535.85","-0.15","-0.42%","40,555,699"]
["Wells","Fargo","WFC","WFC","+0.8155.31","+0.81","+1.49%","37,231,593"]
["Rite","Aid","RAD","RAD","-0.038.67","-0.03","-0.34%","34,303,556"]
["Freeport","Mcmoran","FCX","FCX","-0.0815.19","-0.08","-0.52%","33,977,849"]
["Companhia","Vale","Do","Rio","Doce","VALE","VALE","+0.149.58","+0.14","+1.48%","31,394,330"]
["Ford","Motor","F","F","+0.0412.63","+0.04","+0.32%","29,197,105"]
["Jp","Morgan","Chase","JPM","JPM","+0.3986.63","+0.39","+0.45%","28,295,985"]
["Regions","RF","RF","+0.2514.68","+0.25","+1.73%","26,587,335"]
["Jc","Penney","JCP","JCP","-0.176.77","-0.17","-2.45%","26,551,383"]
["Gen","Electric","GE","GE","-0.0431.35","-0.04","-0.13%","24,323,767"]
["Chesapeake","CHK","CHK","-0.016.92","-0.01","-0.14%","21,300,691"]
["Citigroup","C","C","+0.4059.63","+0.40","+0.68%","21,045,164"]
["Pfizer","PFE","PFE","-0.0932.51","-0.09","-0.28%","20,291,186"]
["A","K","Steel","AKS","AKS","-0.169.71","-0.16","-1.62%","17,386,180"]
["Media","General","MEG","MEG","-0.3118.81","-0.31","-1.62%","17,359,734"]
["Nokia","NOK","NOK","+0.054.75","+0.05","+1.06%","17,246,229"]
["United","States","Steel","X","X","-0.1332.69","-0.13","-0.40%","16,648,081"]
["Weatherford","WFT","WFT","-0.015.26","-0.01","-0.19%","15,290,271"]
["Gamestop","GME","GME","-1.9822.74","-1.98","-8.01%","14,823,876"]
["Att","T","T","-0.0540.96","-0.05","-0.12%","13,932,163"]
["Amerada","Hess","HES","HES","+0.0858.93","+0.08","+0.14%","13,255,552"]
["Morgan","Stanley","MS","MS","+0.1743.80","+0.17","+0.39%","12,904,520"]
["Barrick","Gold","ABX","ABX","-0.0116.89","-0.01","-0.03%","12,428,469"]
["Banco","Bradesco","BBD","BBD","-0.189.63","-0.18","-1.79%","12,239,939"]
["Whiting","Pete","WLL","WLL","-0.2012.24","-0.20","-1.61%","11,865,739"]
["Sprint","Nextel","S","S","+0.148.60","+0.14","+1.65%","11,828,108"]
["Valeant","Pharma","VRX","VRX","-0.3215.32","-0.32","-2.02%","11,117,733"]
["Southwestern","Energy","SWN","SWN","-0.0610.04","-0.06","-0.59%","10,932,078"]
["Mittal","Steel","MT","MT","+0.148.04","+0.14","+1.77%","10,719,158"]
["Keycorp","KEY","KEY","+0.3018.59","+0.30","+1.64%","10,607,461"]
["Petroleo","Brasileiro","PBR","PBR","-0.1811.31","-0.18","-1.57%","10,234,555"]
["Xerox","XRX","XRX","+0.117.05","+0.11","+1.59%","10,081,345"]
["Wal","Mart","Stores","WMT","WMT","-0.8767.10","-0.87","-1.28%","10,012,519"]
["Merck","MRK","MRK","+0.1262.33","+0.12","+0.19%","9,969,105"]
["Cleveland","Cliffs","CLF","CLF","-0.309.23","-0.30","-3.15%","9,901,510"]
["Taiwan","Semicond","TSM","TSM","+0.1629.45","+0.16","+0.55%","9,811,059"]
["Gerdau","GGB","GGB","+0.044.05","+0.04","+1.00%","9,709,906"]
["Abbott","Labs","ABT","ABT","+0.2140.93","+0.21","+0.52%","9,533,780"]
["Boston","Scientific","BSX","BSX","+0.3123.83","+0.31","+1.32%","9,486,079"]
["Verizon","VZ","VZ","-0.1252.56","-0.12","-0.23%","9,458,660"]
["Hewlett","Packard","HPQ","HPQ","-0.0314.76","-0.03","-0.20%","9,336,199"]
["Ensco","ESV","ESV","-0.3111.27","-0.31","-2.68%","8,935,453"]
["Yamana","Gold","Inc.","AUY","AUY","+0.053.18","+0.05","+1.60%","8,835,536"]
["M","G","M","Mirage","MGM","MGM","0.0028.63","0.00","0.00%","8,786,605"]
["Gm","GM","GM","-0.1837.33","-0.18","-0.48%","8,748,845"]
["Exxon","Mobil","XOM","XOM","+0.0186.35","+0.01","+0.01%","8,415,603"]
["Transocean","RIG","RIG","-0.3715.48","-0.37","-2.30%","8,264,458"]
["Kinross","Gold","KGC","KGC","+0.043.35","+0.04","+1.21%","8,183,354"]
["Coca","Cola","KO","KO","-0.0840.87","-0.08","-0.20%","8,123,494"]
["Host","Marriott","Financial","Trust","HST","HST","+0.2318.25","+0.23","+1.28%","7,907,372"]
["Iamgold","IAG","IAG","-0.034.44","-0.03","-0.56%","7,905,608"]
["Us","Bancorp","USB","USB","+0.2451.67","+0.24","+0.47%","7,876,357"]
["Williams","WMB","WMB","-0.1528.55","-0.15","-0.52%","7,703,767"]
["First","Horizon","FHN","FHN","-0.3919.88","-0.39","-1.92%","7,427,955"]
["Delta","Air","Lines","DAL","DAL","+0.3351.22","+0.33","+0.65%","7,380,552"]
["Visa","V","V","-0.1981.18","-0.19","-0.23%","7,291,220"]
["Deutsche","Bank","DB","DB","+0.4619.18","+0.46","+2.46%","6,959,672"]
["Nrg","Energy","NRG","NRG","+0.2114.59","+0.21","+1.46%","6,953,502"]
["Lowes","Companies","LOW","LOW","+0.5672.14","+0.56","+0.78%","6,947,951"]
["Kroger","KR","KR","+0.5834.10","+0.58","+1.73%","6,886,880"]
["Procter","Gamble","PG","PG","+0.1784.01","+0.17","+0.20%","6,762,797"]
["Nike","NKE","NKE","+0.5252.92","+0.52","+0.99%","6,694,367"]
["Noble","NE","NE","-0.307.28","-0.30","-3.97%","6,610,273"]
["Walt","Disney","DIS","DIS","+0.51108.04","+0.51","+0.47%","6,488,966"]
["Energy","Transfer","Equity","ETE","ETE","-0.1918.61","-0.19","-1.01%","6,307,897"]
["Denbury","DNR","DNR","+0.023.80","+0.02","+0.53%","6,267,500"]
["Novartis","NVS","NVS","-0.3972.40","-0.39","-0.54%","6,149,958"]
["Goldcorp","GG","GG","-0.0214.60","-0.02","-0.10%","6,029,535"]
["Halliburton","HAL","HAL","-0.6354.55","-0.63","-1.14%","5,995,616"]
["Nabors","NBR","NBR","-0.2417.28","-0.24","-1.37%","5,916,238"]
["Macys","M","M","-0.1129.87","-0.11","-0.37%","5,858,026"]
["Dow","Chemical","DOW","DOW","-0.4857.81","-0.48","-0.82%","5,769,805"]
["Lilly","Eli","LLY","LLY","+0.2677.41","+0.26","+0.34%","5,602,614"]
["Icici","Bank","IBN","IBN","-0.097.86","-0.09","-1.13%","5,599,209"]

-}

{-
ProfitStock "Bank of America" "BAC" 0.35 161930864
LossStock "Fmc Technologies" "FTI" (-0.42) 40555699
ProfitStock "Wells Fargo" "WFC" 1.49 37231593
LossStock "Rite Aid" "RAD" (-0.34) 34303556
LossStock "Freeport Mcmoran" "FCX" (-0.52) 33977849
ProfitStock "Companhia Vale Do Rio Doce" "VALE" 1.48 31394330
ProfitStock "Ford Motor" "F" 0.32 29197105
ProfitStock "Jp Morgan Chase" "JPM" 0.45 28295985
ProfitStock "Regions" "RF" 1.73 26587335
LossStock "Jc Penney" "JCP" (-2.45) 26551383
LossStock "Gen Electric" "GE" (-0.13) 24323767
LossStock "Chesapeake" "CHK" (-0.14) 21300691
ProfitStock "Citigroup" "C" 0.68 21045164
LossStock "Pfizer" "PFE" (-0.28) 20291186
LossStock "A K Steel" "AKS" (-1.62) 17386180
LossStock "Media General" "MEG" (-1.62) 17359734
ProfitStock "Nokia" "NOK" 1.06 17246229
LossStock "United States Steel" "X" (-0.4) 16648081
LossStock "Weatherford" "WFT" (-0.19) 15290271
LossStock "Gamestop" "GME" (-8.01) 14823876
LossStock "Att" "T" (-0.12) 13932163
ProfitStock "Amerada Hess" "HES" 0.14 13255552
ProfitStock "Morgan Stanley" "MS" 0.39 12904520
LossStock "Barrick Gold" "ABX" (-3.0e-2) 12428469
LossStock "Banco Bradesco" "BBD" (-1.79) 12239939
LossStock "Whiting Pete" "WLL" (-1.61) 11865739
ProfitStock "Sprint Nextel" "S" 1.65 11828108
LossStock "Valeant Pharma" "VRX" (-2.02) 11117733
LossStock "Southwestern Energy" "SWN" (-0.59) 10932078
ProfitStock "Mittal Steel" "MT" 1.77 10719158
ProfitStock "Keycorp" "KEY" 1.64 10607461
LossStock "Petroleo Brasileiro" "PBR" (-1.57) 10234555
ProfitStock "Xerox" "XRX" 1.59 10081345
LossStock "Wal Mart Stores" "WMT" (-1.28) 10012519
ProfitStock "Merck" "MRK" 0.19 9969105
LossStock "Cleveland Cliffs" "CLF" (-3.15) 9901510
ProfitStock "Taiwan Semicond" "TSM" 0.55 9811059
ProfitStock "Gerdau" "GGB" 1.0 9709906
ProfitStock "Abbott Labs" "ABT" 0.52 9533780
ProfitStock "Boston Scientific" "BSX" 1.32 9486079
LossStock "Verizon" "VZ" (-0.23) 9458660
LossStock "Hewlett Packard" "HPQ" (-0.2) 9336199
LossStock "Ensco" "ESV" (-2.68) 8935453
ProfitStock "Yamana Gold Inc." "AUY" 1.6 8835536
NoChange "M G M Mirage" "MGM" 8786605
LossStock "Gm" "GM" (-0.48) 8748845
ProfitStock "Exxon Mobil" "XOM" 1.0e-2 8415603
LossStock "Transocean" "RIG" (-2.3) 8264458
ProfitStock "Kinross Gold" "KGC" 1.21 8183354
LossStock "Coca Cola" "KO" (-0.2) 8123494
ProfitStock "Host Marriott Financial Trust" "HST" 1.28 7907372
LossStock "Iamgold" "IAG" (-0.56) 7905608
ProfitStock "Us Bancorp" "USB" 0.47 7876357
LossStock "Williams" "WMB" (-0.52) 7703767
LossStock "First Horizon" "FHN" (-1.92) 7427955
ProfitStock "Delta Air Lines" "DAL" 0.65 7380552
LossStock "Visa" "V" (-0.23) 7291220
ProfitStock "Deutsche Bank" "DB" 2.46 6959672
ProfitStock "Nrg Energy" "NRG" 1.46 6953502
ProfitStock "Lowes Companies" "LOW" 0.78 6947951
ProfitStock "Kroger" "KR" 1.73 6886880
ProfitStock "Procter Gamble" "PG" 0.2 6762797
ProfitStock "Nike" "NKE" 0.99 6694367
LossStock "Noble" "NE" (-3.97) 6610273
ProfitStock "Walt Disney" "DIS" 0.47 6488966
LossStock "Energy Transfer Equity" "ETE" (-1.01) 6307897
ProfitStock "Denbury" "DNR" 0.53 6267500
LossStock "Novartis" "NVS" (-0.54) 6149958
LossStock "Goldcorp" "GG" (-0.1) 6029535
LossStock "Halliburton" "HAL" (-1.14) 5995616
LossStock "Nabors" "NBR" (-1.37) 5916238
LossStock "Macys" "M" (-0.37) 5858026
LossStock "Dow Chemical" "DOW" (-0.82) 5769805
ProfitStock "Lilly Eli" "LLY" 0.34 5602614
LossStock "Icici Bank" "IBN" (-1.13) 5599209
-}