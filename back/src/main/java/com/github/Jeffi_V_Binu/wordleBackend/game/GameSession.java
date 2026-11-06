package com.github.Jeffi_V_Binu.wordleBackend.game;

import java.util.List;

public class GameSession { // this will hold the specific data of each game session and functions to manipulate those.

    private final String answer;
    private Boolean isGameOver;
    private Boolean isGameWon;
    private Integer guessesLeft;

    GameSession(String answer) {
        this.answer = answer;
        this.isGameOver = false;
        this.isGameWon = false;
        this.guessesLeft = 5;
    }

    public String getAnswer() {
        return answer;
    }

    public Boolean getIsGameOver() {
        return isGameOver;
    }

    public Boolean getIsGameWon() {
        return isGameWon;
    }

    public Integer getGuessesLeft() {
        return guessesLeft;
    }

    public void wonGame(){
        this.isGameOver = true;
        this.isGameWon = true;
    }

    public void lostGame(){
        this.isGameOver = true;
        this.isGameWon = false;
    }

    public void decrementGuessesLeft() {
        this.guessesLeft--;
    }

}
