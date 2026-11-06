package com.github.Jeffi_V_Binu.wordleBackend.game;

import org.springframework.stereotype.Service;

import com.github.Jeffi_V_Binu.wordleBackend.game.exceptions.GameNotFoundException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@Service
public class GameServices { // this will act as an interface for the api to evaluate the game.
    private final Map<String, GameSession> gameSessions = new ConcurrentHashMap<>();
    private final WordDictionary wordDictionary;
    private final int wordLength = 5;
    GameServices(WordDictionary wordDictionary) {
        this.wordDictionary = wordDictionary;
    }

    public int newGame(String id ){
        String answer = wordDictionary.getRandomWord();
        GameSession gameSession = new GameSession(answer);
        gameSessions.put(id, gameSession);
        return 200;
    }

    public GameSession getGameStatus(String id){
        GameSession gameSession = gameSessions.get(id);
        if(gameSession == null){
            throw new GameNotFoundException(id);
        }
        return gameSession;
    }

    public List<HitType> makeGuesses(String id , String guess){
        GameSession gameSession = gameSessions.get(id);
        List<HitType> hitTypes = new java.util.ArrayList<>(wordLength);
        HashMap<Character, Integer> answerCharCount = new HashMap<>();
        if(gameSession == null){
            throw new GameNotFoundException(id);
        }
        else{
            for(char c : gameSession.getAnswer().toCharArray()){
                answerCharCount.put(c, answerCharCount.getOrDefault(c, 0) + 1);
            }
            for(int i  = 0 ; i < wordLength ; ++i){
                hitTypes.set(i, HitType.MISS);
            }
            String answer = gameSession.getAnswer();
            for(int i = 0 ; i < wordLength ; ++i){
                if(guess.charAt(i) == answer.charAt(i)){
                    hitTypes.set(i, HitType.HIT);
                    answerCharCount.put(guess.charAt(i), answerCharCount.get(guess.charAt(i)) - 1);
                }
            }
            for(int i = 0 ; i < wordLength ; ++i){
                if(hitTypes.get(i) == HitType.MISS){
                    if(answerCharCount.getOrDefault(guess.charAt(i), 0) > 0){
                        hitTypes.set(i, HitType.WRONG_POSITION);
                        answerCharCount.put(guess.charAt(i), answerCharCount.get(guess.charAt(i)) - 1);
                    }
                }
            }
            gameSession.decrementGuessesLeft();
            boolean correctGuesses = false;
            for(HitType Ht:hitTypes)
            {
                if(Ht == HitType.HIT){
                    correctGuesses = true;
                }
            }
            if(correctGuesses){
                gameSession.wonGame();
            }
            else{
                if(gameSession.getGuessesLeft() == 0){
                    gameSession.lostGame();
                }
            }
        }
        return hitTypes;
    }
}
