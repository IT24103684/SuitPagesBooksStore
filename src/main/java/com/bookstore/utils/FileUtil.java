package com.bookstore.utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

    private static final String DATA_DIR = "data/";

    static {
        File dir = new File(DATA_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    public static <T> void saveToFile(List<T> objects, String filename) {
        File file = new File(DATA_DIR + filename);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (T obj : objects) {
                writer.write(obj.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Error saving to file: " + filename, e);
        }
    }

    public static <T> List<T> loadFromFile(String filename, LineMapper<T> mapper) {
        List<T> objects = new ArrayList<>();
        File file = new File(DATA_DIR + filename);

        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
                throw new RuntimeException("Error creating file: " + filename, e);
            }
            return objects;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    T obj = mapper.mapLine(line);
                    if (obj != null) {
                        objects.add(obj);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading from file: " + filename, e);
        }

        return objects;
    }

    public interface LineMapper<T> {
        T mapLine(String line);
    }
}