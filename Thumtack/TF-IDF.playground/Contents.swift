//: TF-IDF

// Given a array of articles, give top k keywords of first article using TF-IDF

import Foundation

func getTF(_ numOfWord: Int, _ totalWords: Int) -> Double {
    return Double(numOfWord) / Double(totalWords)
}

func getIDF(_ numOfArticles: Int, _ numOfArticlesContainWord: Int) -> Double {
    return log(Double(numOfArticles) / (Double(numOfArticlesContainWord + 1)))
}

func getTopKeyword(_ articles: [String], _ k: Int) -> [String] {
    
    var res = [String]()
    
    guard k > 0 && articles.count > 0 else {
        return res
    }
    
    var wordsDicts = [Dictionary<String, Int>]()
    let numOfArticles = articles.count
    var firstArticleWCount = 0
    
    // create words Dictionary for each article
    for i in 0..<numOfArticles {
        let article = articles[i]
        let words = article.components(separatedBy: CharacterSet([" ", ",", "."]))
        var tempDict = [String : Int]()
        for word in words {
            if i == 0 {
                firstArticleWCount += 1
            }
            
            if let count = tempDict[word] {
                tempDict[word] = count + 1
            } else {
                tempDict[word] = 1
            }
        }
        
        wordsDicts.append(tempDict)
    }
    
    // calculate TF-IDF of each word in article one, then store in a new Dictionary
    var tfIdfDict = [String : Double]()
    let fDict = wordsDicts[0]
    
    for word in fDict.keys {
        
        // num of article contains
        var numOfArticlesContainWord = 1
        for i in 1..<wordsDicts.count {
            if wordsDicts[i].keys.contains(word) {
                numOfArticlesContainWord += 1
            }
        }
        
        let tf = getTF(fDict[word]!, firstArticleWCount)
        let idf = getIDF(4, numOfArticlesContainWord)
        
        tfIdfDict[word] = tf * idf
    }
    
    print(tfIdfDict)
    
    let sorted = tfIdfDict.sorted { (a, b) -> Bool in
        if a.value == b.value {
            return a.key < b.key
        } else {
            return a.value > b.value
        }
    }
    
    for i in 0..<k {
        res.append(sorted[i].key)
    }
    
    return res
}

let article_1 = "Imagine you’re in New Zealand during the late Paleocene, around 60 million years ago. That means you’re pretty much in Antarctica (thanks, continental drift), but don’t worry: you’re enjoying subtropical climes. Then you hear something large shuffling toward the shore, coming up from behind you. Wow, you think, did two humans time travel to this exact spot at the exact same time? How awkward."

let article_2 = "We’re not the only species that enjoys sex as more than a means to an evolutionary end. Bonobos practically build their (peaceful and matriarchal) society on the exchange of sexual favors. There are gay creatures all over the animal kingdom. Scientists even caught brown bears engaging in oral sex."

let article_3 = "It would be kind of adorable if monkeys were just hitching rides on the back of their long-legged neighbors (which they sometimes do), but researchers say they’ve determined this ritual is sexual in nature. They think it could be the start of a new social trend, with young macaques females—who are known to mount one another in a sexual fashion—gradually picking up the idea that sika stags can provide release."


getTopKeyword([article_1, article_2, article_3], 2)
