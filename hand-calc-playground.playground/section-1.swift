import Foundation

func binomial(n: Int, k: Int) -> Int {
    var r = 1
    var d = n - k
    var n_ = n
    var k_ = k
    if (d > k) {
        k_ = d
        d = n - k_
    }
    
    while (n_ > k_) {
        if (r >= Int.max / n) {
            return 0
        }
        
        r *= n_
        n_--
        
        while (d > 1 && (r % d == 0)) {
            r /= d
            d--
        }
    }
    return r
}

/*
In probability theory and statistics, the hypergeometric distribution is a discrete probability distribution that describes the probability of k successes in n draws without replacement from a finite population of size N containing exactly K successes. This is in contrast to the binomial distribution, which describes the probability of k successes in n draws with replacement.
*/

func hypergeometric(successes: Int, draws: Int, totalSuccesses: Int, populationSize: Int)->Float {
    var k = successes
    var n = draws
    var K = totalSuccesses
    var N = populationSize
    var probability = Float(binomial(K,k))*Float(binomial(N-K,n-k))/Float(binomial(N,n))
    return probability
}

func cumulativeHypergeometric(maxSuccesses: Int, draws: Int, totalSuccesses: Int, populationSize: Int)->Float {
    var total: Float = 0.0
    for x in 0...maxSuccesses {
        total += hypergeometric(x, draws, totalSuccesses, populationSize)
    }
    return total
}

class HandCalculator {
    var totalCards:Int
    var goodCards:Int
    var cardsDrawn:Int
    var possibleGoodCards:Int
    
    init(totalCards:Int, goodCards:Int, cardsDrawn:Int) {
        self.totalCards = totalCards
        self.goodCards = goodCards
        self.cardsDrawn = cardsDrawn
        self.possibleGoodCards = min(cardsDrawn,totalCards)
    }
    
    var exactlyArray: Double[] = []
    var orMoreArray: Double[] = []
    var orLessArray: Double[] = []
    for index in 0...possibleGoodCards {
        exactlyArray += hypergeometric(index,cardsDrawn,goodCards,totalCards)
        orLessArray += cumulativeHypergeometric(index,cardsDrawn,goodCards,totalCards)
        orMoreArray += 1-orLessArray[index]+exactlyArray[index]
    }
    
    func displayArray() -> Double[] {
        return exactlyArray
    }
}

let test = HandCalculator(totalCards: 40,goodCards: 17, cardsDrawn: 7)
test.displayArray()


