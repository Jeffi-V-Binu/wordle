package com.github.Jeffi_V_Binu.wordleBackend.game.exceptions;

public class GameNotFoundException extends RuntimeException {
    public GameNotFoundException(String id){
        super("Game not found" + id);
    }

}
