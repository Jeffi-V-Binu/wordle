package com.github.Jeffi_V_Binu.wordleBackend.game;

import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

@Component
public class WordDictionary {
    private final Set<String> answers;
    private final Set<String> allGuesses;
    private final List<String> answersList;

    public WordDictionary() throws IOException{
        answers = loadWords("/words/answers.txt");
        answersList = new ArrayList<>(answers);
        Set<String> allowedGuesses = new HashSet<>(loadWords("words/guesses.txt"));
        allowedGuesses.addAll(answers);
        allGuesses = Set.copyOf(allowedGuesses);

    }
    private Set<String> loadWords(String path) throws IOException {
        try (var stream = getClass().getResourceAsStream(path)) {
            if (stream == null) {
                throw new IOException("Word list not found");
            }

            try (var reader = new BufferedReader(
                    new InputStreamReader(stream , StandardCharsets.UTF_8)
            )){
                return reader.lines()
                        .map(String::trim)
                        .map(String::toLowerCase)
                        .filter(word -> !word.isEmpty())
                        .collect(Collectors.toUnmodifiableSet());
            }
        }
    }

    public Set<String> getAnswers(){
        return answers;
    }

    public Set<String> getAllGuesses(){
        return allGuesses;
    }

    public String getRandomWord() {
        int randomIndex = (int) (ThreadLocalRandom.current().nextDouble(0 , answersList.size()));
        return answersList.get(randomIndex);
    }
}