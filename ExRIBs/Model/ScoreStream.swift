//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import RxSwift
import RxCocoa

struct Score {
    let player1Score: Int
    let player2Score: Int

    static func equals(lhs: Score, rhs: Score) -> Bool {
        return lhs.player1Score == rhs.player1Score && lhs.player2Score == rhs.player2Score
    }
}

protocol ScoreStream: class {
    var score: Observable<Score> { get }
}

protocol MutableScoreStream: ScoreStream {
    func updateScore(withWinner winner: PlayerType)
}

class ScoreStreamImpl: MutableScoreStream {

    var score: Observable<Score> {
        return variable
            .asObservable()
            .distinctUntilChanged { (lhs: Score, rhs: Score) -> Bool in
                Score.equals(lhs: lhs, rhs: rhs)
            }
    }

    func updateScore(withWinner winner: PlayerType) {
        let newScore: Score = {
            let currentScore = variable.value
            switch winner {
            case .player1:
                return Score(player1Score: currentScore.player1Score + 1, player2Score: currentScore.player2Score)
            case .player2:
                return Score(player1Score: currentScore.player1Score, player2Score: currentScore.player2Score + 1)
            }
        }()
        variable.accept(newScore)
    }

    // MARK: - Private

    private let variable = BehaviorRelay<Score>(value: Score(player1Score: 0, player2Score: 0)) // 확실히 캡슐화를 한 놈이네
}
