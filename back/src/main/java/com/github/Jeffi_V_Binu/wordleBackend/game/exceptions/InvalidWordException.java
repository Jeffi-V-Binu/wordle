package com.github.Jeffi_V_Binu.wordleBackend.game.exceptions;

public class InvalidWordException extends RuntimeException {
    public InvalidWordException(String guess){
        super("Invalid Guess : " + guess);
    }}
